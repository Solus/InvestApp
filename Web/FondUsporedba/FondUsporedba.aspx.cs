using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Drawing;

namespace InvestApp.Web
{
	public partial class FondUsporedba : System.Web.UI.Page
	{
		DateTime vrijemePoc;
		TimeSpan vrijemeGraf, vrijemeFondovi, vrijemePrinosi;

		private class FondUsporedbaObj
		{
			public int ID { get; set; }
			public string NAZIV { get; set; }

			public FondUsporedbaObj(int id, string naziv)
			{
				this.ID = id;
				this.NAZIV = naziv;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			vrijemePoc = DateTime.Now;

			hidProizvoljno.Value = "false";

			if (!IsPostBack)
			{

				gvFondovi.RowDeleted += gvFondovi_RowDeleted;
				this.Page.Title = "Usporedba fodova";
				//(this.Page.Master.FindControl("usporedbaLink") as HtmlAnchor).Attributes["class"] = "current";

				//FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

				//container.AddFond(1);
				//container.AddFond(2);
				//container.AddFond(3);
				//container.AddFond(4);
				//container.AddFond(5);
				//container.AddFond(6);

				//ddlInterval.SelectedValue = "P";
				tbDatumOd.Date = DateTime.Today.AddYears(-1);
				tbDatumDo.Date = DateTime.Today;
				//ddlInterval_SelectedIndexChanged(null, null);
				divGraf.Visible = false;
				_SetGraph();

				PostaviPonudjeneFondove();
				PostaviTablicu();
				
			}
			
			_FormirajTablicuFondova2();

//			_FormirajTablicuFondova1();

			
		}

		protected void Page_LoadComplete(object sender, EventArgs e)
		{
			
		}

		protected void Page_PreRenderComplete(object sender, EventArgs e)
		{
			TimeSpan vrijemeTotal = DateTime.Now - vrijemePoc;

			//lblLog.Text = "Stranica: " + (int)vrijemeTotal.TotalMilliseconds + " ms" + "<br/>" +
			//	"Fondovi: " + (int)vrijemeFondovi.TotalMilliseconds + " ms" + "<br/>" +
			//	"Graf: " + (int)vrijemeGraf.TotalMilliseconds + " ms" + "<br/>" +
			//	"Prinosi: " + (int)vrijemePrinosi.TotalMilliseconds + " ms";
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		//protected void ddlInterval_SelectedIndexChanged(object sender, EventArgs e)
		//{
		//	divGraf.Visible = false;
		//	divDatum.Visible = false;
		//	if (ddlInterval.SelectedValue == "P")
		//	{
		//		divDatum.Visible = true;
		//		lblPoruka.Visible = false;
		//	}
		//	else
		//	{
		//		_SetGraph();
		//	}
		//}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void btnTrazi_Click(object sender, EventArgs e)
		{
			menuPeriod.Items[7].Selected = true;
			_SetGraph(true);
			PostaviTablicu();
			//_FormirajTablicuFondova2();

			hidProizvoljno.Value = "true";
		}

		private void PostaviTablicu()
		{
			DateTime vrijemePrinosiPoc = DateTime.Now;

			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);
			tablePrinosi.FondIDs = container.Fondovi();
			tablePrinosi.DataBind();

			vrijemePrinosi = DateTime.Now - vrijemePrinosiPoc;
		}

		/// <summary>
		/// 
		/// </summary>
		private void _SetGraph(bool proizvoljanInterval = false)
		{
			DateTime vrijemeGrafPoc = DateTime.Now;

			DateTime inDatumOd, inDatumDo;

			if (proizvoljanInterval)
			{
				inDatumOd = tbDatumOd.Date;
				inDatumDo = tbDatumDo.Date;
			}
			else
				_GetInterval(out inDatumOd, out inDatumDo);

			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

			bool bCijeneExist = false;

			chartUsporedba.Series.Clear();

            List<DAL.Fond> fondovi = new List<DAL.Fond>();

            foreach (Int32 fondId in container.Fondovi())
            {
                var fond = DAL.FondDAC.VratiFond(fondId);
                fondovi.Add(fond);
            }

            fondovi = fondovi.OrderBy(f => f.NAZIV).ToList();

            for (int fi = 0; fi < fondovi.Count; fi++)
			{
				var cijene = DAL.FondDAC.DohvatiCijeneProsireno(fondovi[fi].ID, inDatumOd, inDatumDo);

				//ograničavanje broja elemenata grafa
				int? maxZapisa = DAL.AdminDAC.VratiConfig().GRAF_MAX_ZAPISA;
				if (cijene.Any() && maxZapisa.HasValue)
				{
					int broj = cijene.Count;
					int skip = broj <= maxZapisa ? 0 : (int)(Math.Ceiling(broj / (decimal)maxZapisa.Value));

					if (skip > 0)
						cijene = cijene.Where((c, i) => i % skip == 0).ToList();
				}

				bCijeneExist = bCijeneExist || cijene.Any(); 

				DevExpress.XtraCharts.Series series = new DevExpress.XtraCharts.Series(fondovi[fi].NAZIV, DevExpress.XtraCharts.ViewType.Line);

				series.DataSource = cijene;
				series.ArgumentScaleType = DevExpress.XtraCharts.ScaleType.DateTime;
				series.ArgumentDataMember = "DATUM";
				series.ValueScaleType = DevExpress.XtraCharts.ScaleType.Numerical;
				series.ValueDataMembers.AddRange(new string[] { "POSTOTAK" });

                string boja = "";
                switch (fi)
                {
                    case 0: boja = "#0070bb"; break;
                    case 1: boja = "#c1272c"; break;
                    case 2: boja = "#8bc53e"; break;
                    case 3: boja = "#92278f"; break;
                }

                if(!string.IsNullOrEmpty(boja))
                    ((LineSeriesView)series.View).Color = System.Drawing.ColorTranslator.FromHtml(boja);

				((LineSeriesView)series.View).MarkerVisibility = DevExpress.Utils.DefaultBoolean.False;
                ((LineSeriesView)series.View).LineStyle.Thickness = 2;
				//((LineSeriesView)series.View).LineMarkerOptions.Color = System.Drawing.Color.Transparent;
				//((LineSeriesView)series.View).LineMarkerOptions.BorderVisible = false;
				//((LineSeriesView)series.View).LineMarkerOptions.FillStyle.FillMode = FillMode.Solid;

				chartUsporedba.Series.Add(series);
			}

			if (bCijeneExist)
			{
				chartUsporedba.BackColor = System.Drawing.Color.Transparent;
				chartUsporedba.BorderOptions.Visible = false;

				((XYDiagram)chartUsporedba.Diagram).AxisY.VisualRange.MinValue = decimal.MinValue;
				((XYDiagram)chartUsporedba.Diagram).AxisY.VisualRange.MaxValue = decimal.MaxValue;

				//((XYDiagram)chartUsporedba.Diagram).AxisY.VisualRange.MinValue = min;
				//((XYDiagram)chartUsporedba.Diagram).AxisY.VisualRange.MaxValue = max;
                
				((XYDiagram)chartUsporedba.Diagram).AxisY.Label.NumericOptions.Format = NumericFormat.Number;
				((XYDiagram)chartUsporedba.Diagram).AxisY.Label.NumericOptions.Precision = 0;
				((XYDiagram)chartUsporedba.Diagram).AxisY.Label.EndText = "%";
				((XYDiagram)chartUsporedba.Diagram).AxisY.Color = System.Drawing.ColorTranslator.FromHtml("#fff");
                ((XYDiagram)chartUsporedba.Diagram).AxisY.GridLines.Color = Color.White;

				//((XYDiagram)chartUsporedba.Diagram).AxisX.Label.Staggered = true;
				((XYDiagram)chartUsporedba.Diagram).AxisX.Label.DateTimeOptions.Format = DateTimeFormat.Custom;
				((XYDiagram)chartUsporedba.Diagram).AxisX.Label.DateTimeOptions.FormatString = "dd.MM.yyyy";
				((XYDiagram)chartUsporedba.Diagram).AxisX.Color = System.Drawing.ColorTranslator.FromHtml("#fff");
                ((XYDiagram)chartUsporedba.Diagram).AxisX.GridLines.Visible = true;
                ((XYDiagram)chartUsporedba.Diagram).AxisX.GridLines.Color = Color.White;

                ((XYDiagram)chartUsporedba.Diagram).DefaultPane.BackColor = System.Drawing.ColorTranslator.FromHtml("#E6E6E6");
				((XYDiagram)chartUsporedba.Diagram).DefaultPane.FillStyle.FillMode = DevExpress.XtraCharts.FillMode.Solid;
                ((XYDiagram)chartUsporedba.Diagram).DefaultPane.BorderColor = System.Drawing.Color.White;

				chartUsporedba.Width = new Unit(845);
				chartUsporedba.Height = new Unit(400);
				chartUsporedba.Legend.Visible = false;

				chartUsporedba.Visible = true;
				divGraf.Visible = true;
				lblPoruka.Visible = false;
			}
			else
			{
				chartUsporedba.Visible = false;
				divGraf.Visible = true;
				lblPoruka.Visible = true;

				if(container.BrojFondova == 0)
					lblPoruka.Text = "Dodajte fondove za usporedbu.";
				else
					lblPoruka.Text = "Nema podataka za zadane uvjete pretraživanja.";
			}

			vrijemeGraf = DateTime.Now - vrijemeGrafPoc;
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="inDatumOd"></param>
		/// <param name="inDatumDo"></param>
		private void _GetInterval(out DateTime inDatumOd, out DateTime inDatumDo)
		{
			inDatumOd = DateTime.MinValue;
			inDatumDo = DateTime.MaxValue;
			
			// Izračun datuma
			switch (menuPeriod.SelectedValue)
			{
				case "1M":
					inDatumOd = DateTime.Today.AddMonths(-1);
					break;
				case "3M":
					inDatumOd = DateTime.Today.AddMonths(-3);
					break;
				case "6M":
					inDatumOd = DateTime.Today.AddMonths(-6);
					break;
				case "1G":
					inDatumOd = DateTime.Today.AddYears(-1);
					break;
				case "3G":
					inDatumOd = DateTime.Today.AddYears(-3);
					break;
				case "5G":
					inDatumOd = DateTime.Today.AddYears(-5);
					break;
				default:
					inDatumOd = DateTime.MinValue;
					break;
			}

		}

		/// <summary>
		/// 
		/// </summary>
//		private void _FormirajTablicuFondova1()
//		{
//			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

//			if (container.Fondovi().Count == 0) return;

//			divFondovi.Visible = true;

//			tblFondovi.Rows.Clear();

//			tblFondovi.CellPadding = 0;
//			tblFondovi.CellSpacing = 0;
//			tblFondovi.BorderStyle = BorderStyle.Solid;
//			tblFondovi.BorderColor = System.Drawing.Color.Red;


//			TableRow tblRow;
//			TableCell tblCell;

//			int iRow = 1;

//			foreach (Int32 fondId in container.Fondovi())
//			{
//				var fond = DAL.FondDAC.VratiFond(fondId);

//				tblRow = new TableRow();
////				tblRow.Attributes.Add("class", (iRow % 2 == 0) ? "even" : "odd");
//				tblRow.TableSection = TableRowSection.TableBody;

//				// Naziv fonda
//				tblCell = new TableCell();
////				tblCell.Attributes.Add("class", "name");
//				tblCell.Text = fond.NAZIV;
//				tblCell.Width = 200;
//				tblRow.Cells.Add(tblCell);

//				// Izbaci
//				tblCell = new TableCell();
////				tblCell.Attributes.Add("class", "document");
//				tblCell.Style.Add("cursor", "pointer");
				
//				ImageButton btnIzbaci = new ImageButton();

//				btnIzbaci.ImageUrl = "~/Images/delete.gif";
//				btnIzbaci.ID = "btnIzbaci_" + fondId.ToString();
//				btnIzbaci.Click += btnIzbaci_Click;
//				btnIzbaci.ToolTip = "Izbaci fond iz usporedbe";
//				btnIzbaci.CommandArgument = fondId.ToString();
//				btnIzbaci.Width = 16;
//				btnIzbaci.Height = 16;

//				tblCell.Controls.Add(btnIzbaci);
//				tblRow.Cells.Add(tblCell);

//				tblFondovi.Rows.Add(tblRow);

//				iRow++;
//			}
//		}

		//void btnIzbaci_Click(object sender, EventArgs e)
		//{
		//	ImageButton btnIzbaci = (ImageButton)sender;

		//	Int32 fondId = Convert.ToInt32(btnIzbaci.CommandArgument);

		//	FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

		//	container.RemoveFond(fondId);

		//	_FormirajTablicuFondova1();
		//	_SetGraph();
		//}

		private FondUsporedbaObj VratiFondZaUsporedbu(int fondID)
		{
			var fond = DAL.FondDAC.VratiFond(fondID);

			if (fond == null)
				return null;
			else
				return new FondUsporedbaObj(fond.ID, fond.NAZIV);
		}

		/// <summary>
		/// 
		/// </summary>
		private void _FormirajTablicuFondova2()
		{
			DateTime vrijemeFondoviPoc = DateTime.Now;

			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

			if (container.Fondovi().Count == 0) return;

			//DataTable dtFondovi = new DataTable();
			//dtFondovi.Columns.Add("ID", typeof(Int32));
			//dtFondovi.Columns.Add("NAZIV", typeof(string));

			List<FondUsporedbaObj> fondovi = new List<FondUsporedbaObj>();

			foreach (int fondId in container.Fondovi())
			{
				//var fond = DAL.FondDAC.VratiFond(fondId);

				//DataRow drFond = dtFondovi.NewRow();
				//drFond["ID"] = fondId;
				//drFond["NAZIV"] = fond.NAZIV;
				//dtFondovi.Rows.Add(drFond);

				fondovi.Add(VratiFondZaUsporedbu(fondId));
			}

			gvFondovi.DataSource = fondovi.OrderBy(f => f.NAZIV).ToList();
			gvFondovi.DataBind();

			vrijemeFondovi = DateTime.Now - vrijemeFondoviPoc;
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void gvFondovi_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{
			int fondID = (int)gvFondovi.DataKeys[e.RowIndex].Value;

			//DataTable dtFondovi = gvFondovi.DataSource as DataTable;

			//Int32 fondId = Convert.ToInt32(dtFondovi.Rows[e.RowIndex]["ID"]);
			
			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);
			container.RemoveFond(fondID);

			List<FondUsporedbaObj> fondovi = gvFondovi.DataSource as List<FondUsporedbaObj>;

			if (fondovi != null)
				fondovi.RemoveAll(f => f.ID == fondID);

			gvFondovi.DataSource = fondovi.OrderBy(f => f.NAZIV).ToList();
			gvFondovi.DataBind();

			_SetGraph();

			PostaviPonudjeneFondove();
			PostaviTablicu();
		}

		void gvFondovi_RowDeleted(object sender, GridViewDeletedEventArgs e)
		{
			
		}

		/// <summary>
		/// Popunjava dropdownlist sa fondovima koji se mogu dodati u usporedbu
		/// </summary>
		private void PostaviPonudjeneFondove()
		{
			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

			var fondoviUsporedba = container.Fondovi();

			var fondovi = DAL.FondDAC.VratiFondove().Where(f=> !fondoviUsporedba.Contains(f.ID) && f.INDEKSNI != true).OrderBy(f=>f.NAZIV).ToList();
			
			var fondoviDionicki = fondovi.Where(f => f.KATEGORIJA_ID == (int)Common.FondoviHelper.Kategorija.DIONICKI).ToList();
			var fondoviMjesoviti = fondovi.Where(f => f.KATEGORIJA_ID == (int)Common.FondoviHelper.Kategorija.MJESOVITI).ToList();
			var fondoviObveznicki = fondovi.Where(f => f.KATEGORIJA_ID == (int)Common.FondoviHelper.Kategorija.OBVEZNICKI).ToList();
			var fondoviNovcani = fondovi.Where(f => f.KATEGORIJA_ID == (int)Common.FondoviHelper.Kategorija.NOVCANI).ToList();

			DAL.Fond fondBlank = new DAL.Fond();
			fondBlank.ID = -1;

			fondBlank.NAZIV = "DIONIČKI";
			fondoviDionicki.Insert(0, fondBlank);

			fondBlank = new DAL.Fond();
			fondBlank.ID = -1;
			fondBlank.NAZIV = "MJEŠOVITI";
			fondoviMjesoviti.Insert(0, fondBlank);

			fondBlank = new DAL.Fond();
			fondBlank.ID = -1;
			fondBlank.NAZIV = "NOVČANI";
			fondoviNovcani.Insert(0, fondBlank);

			fondBlank = new DAL.Fond();
			fondBlank.ID = -1;
			fondBlank.NAZIV = "OBVEZNIČKI";
			fondoviObveznicki.Insert(0, fondBlank);

            fondBlank = new DAL.Fond();
            fondBlank.ID = -1;
            fondBlank.NAZIV = "SVI";
            fondovi.Insert(0, fondBlank);

            ddlFondoviSvi.DataSource = fondovi;
			ddlFondoviDionicki.DataSource = fondoviDionicki;
			ddlFondoviMjesoviti.DataSource = fondoviMjesoviti;
			ddlFondoviNovcani.DataSource = fondoviNovcani;
			ddlFondoviObveznicki.DataSource = fondoviObveznicki;

            ddlFondoviSvi.DataBind();
			ddlFondoviDionicki.DataBind();
			ddlFondoviMjesoviti.DataBind();
			ddlFondoviNovcani.DataBind();
			ddlFondoviObveznicki.DataBind();
		}

		protected void menuPeriod_MenuItemClick(object sender, MenuEventArgs e)
		{
			_SetGraph();
			PostaviTablicu();
			//_FormirajTablicuFondova2();
		}

		private void DodajUsporedbu(Common.FondoviHelper.Kategorija kat)
		{
			string value = null;

			switch (kat)
			{
                case InvestApp.Common.FondoviHelper.Kategorija.SVI:
                    value = ddlFondoviSvi.SelectedValue;
                    break;
				case InvestApp.Common.FondoviHelper.Kategorija.NOVCANI:
					value = ddlFondoviNovcani.SelectedValue;
					break;
				case InvestApp.Common.FondoviHelper.Kategorija.OBVEZNICKI:
					value = ddlFondoviObveznicki.SelectedValue;
					break;
				case InvestApp.Common.FondoviHelper.Kategorija.MJESOVITI:
					value = ddlFondoviMjesoviti.SelectedValue;
					break;
				case InvestApp.Common.FondoviHelper.Kategorija.DIONICKI:
					value = ddlFondoviDionicki.SelectedValue;
					break;
				default:
					return;
			}

			if (!string.IsNullOrEmpty(value))
			{
				int fondID = Convert.ToInt32(value);

				if (fondID <= 0)
					return;

				FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);
				container.AddFond(Convert.ToInt32(value));

				_FormirajTablicuFondova2();
				PostaviPonudjeneFondove();

				_SetGraph();
				PostaviTablicu();
			}
		}

		protected void btnDodajNovcani_Click(object sender, EventArgs e)
		{
			DodajUsporedbu(Common.FondoviHelper.Kategorija.NOVCANI);
		}

		protected void btnDodajObveznicki_Click(object sender, EventArgs e)
		{
			DodajUsporedbu(Common.FondoviHelper.Kategorija.OBVEZNICKI);
		}

		protected void btnDodajMjesoviti_Click(object sender, EventArgs e)
		{
			DodajUsporedbu(Common.FondoviHelper.Kategorija.MJESOVITI);
		}

		protected void btnDodajDionicki_Click(object sender, EventArgs e)
		{
			DodajUsporedbu(Common.FondoviHelper.Kategorija.DIONICKI);
		}

        protected void btnDodajSvi_Click(object sender, EventArgs e)
        {
            DodajUsporedbu(Common.FondoviHelper.Kategorija.SVI);
        }
	}
}