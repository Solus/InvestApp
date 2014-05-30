using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;

namespace InvestApp.Web
{
	public partial class FondPortfeljVrijednostGrafCtrl : System.Web.UI.UserControl
	{
		public string Width { get; set; }
		public string Height { get; set; }

		private int KorisnikId
		{
			get
			{
				if (this.Page != null)
					return (this.Page as UIControls.InvestAppPage).KorisnikID;
				else
					return -1;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void Page_PreRender(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				
			}
		}

		public override void DataBind()
		{
			base.OnDataBinding(EventArgs.Empty);

			_TraziV();
		}

		private void _TraziV()
		{
			DateTime poc = DateTime.Now;

			DateTime datumOd = DateTime.MinValue, datumDo = DateTime.Today;

			// Izračun datuma
			if (ddlInterval.SelectedValue == "1T")
			{
				datumOd = DateTime.Today.AddDays(-7);
			}
			else if (ddlInterval.SelectedValue == "1M")
			{
				datumOd = DateTime.Today.AddMonths(-1);
			}
			else if (ddlInterval.SelectedValue == "3M")
			{
				datumOd = DateTime.Today.AddMonths(-3);
			}
			else if (ddlInterval.SelectedValue == "6M")
			{
				datumOd = DateTime.Today.AddMonths(-6);
			}
			else if (ddlInterval.SelectedValue == "G")
			{
				datumOd = new DateTime(DateTime.Now.Year, 1, 1);
			}
			else if (ddlInterval.SelectedValue == "1G")
			{
				datumOd = DateTime.Today.AddYears(-1);
			}
			else if (ddlInterval.SelectedValue == "2G")
			{
				datumOd = DateTime.Today.AddYears(-2);
			}
			else if (ddlInterval.SelectedValue == "P")
			{
				datumOd = tbDatumOd.Date;
				datumDo = tbDatumDo.Date;
			}

			var vrijednosti = DAL.FondDAC.VrijednostiPortfelja(KorisnikId, datumOd, datumDo, 25);

			//ograničavanje broja elemenata grafa
			int? maxZapisa = DAL.AdminDAC.VratiConfig().GRAF_MAX_ZAPISA;
			if (vrijednosti.Any() && maxZapisa.HasValue)
			{
				int broj = vrijednosti.Count;
				int skip = broj <= maxZapisa ? 0 : (int)(Math.Ceiling(broj / (decimal)maxZapisa.Value));

				if (skip > 0)
					vrijednosti = vrijednosti.Where((c, i) => i % skip == 0).ToList();
			}
			
			if (vrijednosti.Any())
			{
				Series series = chartPortfelj.Series[0];
				series.DataSource = vrijednosti;

				series.ArgumentScaleType = ScaleType.DateTime;
				series.ArgumentDataMember = "DATUM";
				series.ValueScaleType = ScaleType.Numerical;
				series.ValueDataMembers.AddRange(new string[] { "VRIJEDNOST" });

				//Min max
				decimal min = vrijednosti.Min(v => v.VRIJEDNOST);
				decimal max = vrijednosti.Max(v => v.VRIJEDNOST);
				decimal razlika = (max - min) * (decimal)0.1;
				if (razlika == 0) razlika = (decimal)0.001;

				min = min - razlika;
				max = max + razlika;

				((XYDiagram)chartPortfelj.Diagram).AxisY.VisualRange.MinValue = min;
				((XYDiagram)chartPortfelj.Diagram).AxisY.VisualRange.MaxValue = max;

				//((XYDiagram)chartPortfelj.Diagram).AxisY.Label.NumericOptions.Format = NumericFormat.Number;
				//((XYDiagram)chartPortfelj.Diagram).AxisY.Label.NumericOptions.Precision = 2;

				//((XYDiagram)chartPortfelj.Diagram).AxisX.Label.Staggered = true;

				//((LineSeriesView)series.View).Color = System.Drawing.ColorTranslator.FromHtml("#C6234F");

				//((LineSeriesView)series.View).LineMarkerOptions.Visible = false;
				//((LineSeriesView)series.View).LineMarkerOptions.Color = System.Drawing.Color.Transparent;
				//((LineSeriesView)series.View).LineMarkerOptions.BorderVisible = false;
				//((LineSeriesView)series.View).LineMarkerOptions.FillStyle.FillMode = FillMode.Solid;

				chartPortfelj.Width = new Unit(Width);
				chartPortfelj.Height = new Unit(Height);

				chartPortfelj.DataBind();
			}

			UpdatePanel1.Update();

			TimeSpan vrijeme = DateTime.Now - poc;
			(Page.Master.FindControl("lblLog") as Label).Text += " Vrijednosti graf: " + (int)vrijeme.TotalMilliseconds;
		}

		protected void btnTrazi_Click(object sender, EventArgs e)
		{
			_TraziV();
		}

		protected void ddlInterval_SelectedIndexChanged(object sender, EventArgs e)
		{
			//if (ddlInterval.SelectedValue == "P")
			//	divDatum.Visible = true;
			//else
			{
				//divDatum.Visible = false;
				_TraziV();
			}
		}


	}
}