using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using DevExpress.Web.ASPxGridView;
using InvestApp.Common;

namespace InvestApp.Web
{
	public partial class FondZahtjeviPregled : UIControls.InvestAppPage
	{
		#region Vrijednosti pretraživanja
		
		public string Tip
		{
			get
			{
				return ViewState["pretrTip"] == null ? "" : (string)ViewState["pretrTip"];
			}
			set
			{
				ViewState["pretrTip"] = value;
			}
		}

		public string Status
		{
			get
			{
				return ViewState["pretrStatus"] == null ? "" : (string)ViewState["pretrStatus"];
			}
			set
			{
				ViewState["pretrStatus"] = value;
			}
		}

		public int? FondID
		{
			get
			{
				return ViewState["pretrFondID"] == null ? (int?)null : (int)ViewState["pretrFondID"];
			}
			set
			{
				ViewState["pretrFondID"] = value;
			}
		}

		public DateTime? DatumOd
		{
			get
			{
				return ViewState["pretrDatOd"] == null ? (DateTime?)null : (DateTime)ViewState["pretrDatOd"];
			}
			set
			{
				ViewState["pretrDatOd"] = value;
			}
		}

		public DateTime? DatumDo
		{
			get
			{
				return ViewState["pretrDatDo"] == null ? (DateTime?)null : (DateTime)ViewState["pretrDatDo"];
			}
			set
			{
				ViewState["pretrDatDo"] = value;
			}
		}

		#endregion Vrijednosti pretraživanja

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				this.Page.Title = "Pregled zahtjeva";
				//(this.Page.Master.FindControl("zahtjeviLink") as HtmlAnchor).Attributes["class"] = "current";
				
				gvZahtjevi.DataBind();

				InitSearchKontrole();
			}
		}

		private void InitSearchKontrole()
		{
			ddlFond.DataSource = DAL.FondDAC.VratiFondove(true);
			ddlFond.DataBind();
		}

		protected void btnTrazi_Click(object sender, EventArgs e)
		{
			//spremiti u viewstate
			Tip = ddlTip.SelectedValue;
			DatumOd = Utility.DateTimeToNullable(tbDatumOd.Date);
			DatumDo = Utility.DateTimeToNullable(tbDatumDo.Date);
			Status = ddlStatus.SelectedValue;
			FondID = ddlFond.SelectedValue == "-1" ? null : Utility.StringToInt(ddlFond.SelectedValue);

			gvZahtjevi.DataBind();
		}

		protected void gvZahtjevi_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs e)
		{
			var zahtjev = (gvZahtjevi.GetRow(e.VisibleIndex) as DAL.FondZahtjev);

			if (zahtjev == null)
				return;

			if (e.ButtonID == "cbIzvrsi")
			{
				Session["zahtjevID"] = zahtjev.ID;

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Fond/FondZahtjevRealizacija.aspx");
			}
			else if (e.ButtonID == "cbZahtjevReport")
			{
				//Reports.Report.IspisiZahtjev(zahtjev.ID);
				Response.Redirect(ResolveClientUrl("~/Reports/ZahtjevIspis.aspx?ID=" + zahtjev.ID));
			}
		}

		protected void gvZahtjevi_DataBinding(object sender, EventArgs e)
		{
			var zahtjevi = DAL.FondDAC.TraziZahtjeve(KorisnikID, DatumOd, DatumDo, Tip, Status, FondID);
			gvZahtjevi.DataSource = zahtjevi;
		}

		protected void gvZahtjevi_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
		{
			int id = (int)e.Keys[0];

			DAL.FondDAC.BrisiZahtjev(id);

			e.Cancel = true;
		}

		protected void gvZahtjevi_HtmlEditFormCreated(object sender, ASPxGridViewEditFormEventArgs e)
		{
			//ASPxGridView grid = (sender as ASPxGridView);

			//int rowIndex = grid.EditingRowVisibleIndex;

			//if (rowIndex < 0)
			//	return;

			//var zahtjev = (grid.GetRow(rowIndex) as DAL.FondZahtjev);

			//if (zahtjev != null)
			//{
			//	if(zahtjev.Tip == Common.FondZahtjevHelper.Tip.Kupnja)
			//		grid.FindEditFormTemplateControl("divBrojUdjela").Visible = false;
			//	else if(zahtjev.Tip == Common.FondZahtjevHelper.Tip.Prodaja)
			//		grid.FindEditFormTemplateControl("divIznosUdjela").Visible = false;
			//}
		}

		protected void gvZahtjevi_CustomButtonInitialize(object sender, ASPxGridViewCustomButtonEventArgs e)
		{
			if (e.ButtonID == "cbIzvrsi")
			{
				var zahtjev = (gvZahtjevi.GetRow(e.VisibleIndex) as DAL.FondZahtjev);

				if (zahtjev.StatusTip == Common.FondZahtjevHelper.Status.Realiziran)
					e.Visible = DevExpress.Utils.DefaultBoolean.False;
			}
		}

		protected void gvZahtjevi_CustomColumnDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
		{
			var zahtjev = (gvZahtjevi.GetRow(e.VisibleRowIndex) as DAL.FondZahtjev);

			if (zahtjev == null)
				return;

			if (e.Column.Name == "DOKUMENT_URL")
			{
				if (zahtjev.DOKUMENT_URL.IsNullOrEmpty())
					return;

				string dokUrl = ResolveClientUrl(zahtjev.DOKUMENT_URL);
				string imgUrl = ResolveClientUrl("~/Images/document.png");

				e.DisplayText = string.Format("<a href='{0}' title=\"Potvrda zahtjeva\" target='_blank' ><img src='{1}' /></a>", dokUrl, imgUrl);
			}
		}

		//protected void EntityDataSourceZahtjevi_Selecting(object sender, EntityDataSourceSelectingEventArgs e)
		//{
		//	EntityDataSourceZahtjevi.Where = "it.PODNOSENJE_KORISNIK_ID = @korisnikID";
		//	EntityDataSourceZahtjevi.WhereParameters["korisnikID"] = new Parameter("korisnikID", System.Data.DbType.Int32, KorisnikID.ToString());
		//}
	}
}