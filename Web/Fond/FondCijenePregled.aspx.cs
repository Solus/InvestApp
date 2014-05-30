using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;
using InvestApp.Common;

namespace InvestApp.Web
{
	public partial class FondCijenePregled : InvestApp.UIControls.InvestAppPage
    {
        public int FondID
        {
            get
            {
                return Session["fondID"] == null ? -1 : (int)Session["fondID"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
				if (Request.UrlReferrer == null)
					divBtn.Visible = false;
				else
					ViewState["PrevPage"] = Request.UrlReferrer;

                if (FondID < 0)
                    return;

				string fondNaziv = DAL.FondDAC.VratiFondNaziv(FondID);

				if (!fondNaziv.IsNullOrEmpty())
					lblFondNaziv.Text = fondNaziv + " - ";

				tablePrinosi.FondIDs = new List<int>() { FondID };

				chartPrinos.FondID = FondID;
				PostaviGraf();

            }

			tablePrinosi.DataBind();
        }

		private void PostaviGraf()
		{
			DateTime datumPoc;

			switch (menuPeriod.SelectedValue)
			{
				case "1M":
					datumPoc = DateTime.Today.AddMonths(-1);
					break;
				case "3M":
					datumPoc = DateTime.Today.AddMonths(-3);
					break;
				case "6M":
					datumPoc = DateTime.Today.AddMonths(-6);
					break;
				case "1G":
					datumPoc = DateTime.Today.AddYears(-1);
					break;
				case "3G":
					datumPoc = DateTime.Today.AddYears(-3);
					break;
				case "5G":
					datumPoc = DateTime.Today.AddYears(-5);
					break;
				default:
					datumPoc = DateTime.MinValue;
					break;
			}

			chartPrinos.DatumPoc = datumPoc;
			chartPrinos.DataBind();
		}

		//protected void chartCijene_DataBinding(object sender, EventArgs e)
		//{
		//	var cijene = DAL.FondDAC.DohvatiCijeneProsireno(FondID, DateTime.MinValue, DateTime.Today);

		//	//postotne
		//	var max = cijene.Max(c => c.POSTOTAK);
		//	var min = cijene.Min(c => c.POSTOTAK);

		//	if (cijene.Any())
		//	{
		//		DevExpress.XtraCharts.Series series = new DevExpress.XtraCharts.Series("Series1", DevExpress.XtraCharts.ViewType.Line);

		//		series.DataSource = cijene;
		//		series.ArgumentScaleType = DevExpress.XtraCharts.ScaleType.DateTime;
		//		series.ArgumentDataMember = "DATUM";
		//		series.ValueScaleType = DevExpress.XtraCharts.ScaleType.Numerical;
		//		series.ValueDataMembers.AddRange(new string[] { "POSTOTAK" });

		//		((XYDiagram)chartCijene.Diagram).AxisY.Label.EndText = "%";

		//		chartCijene.Series.Add(series);

		//		decimal razlika = (max.Value - min.Value) * (decimal)0.1;
		//		if (razlika == 0) razlika = (decimal)0.001;

		//		min = min - razlika;
		//		max = max + razlika;

		//		((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MinValue = decimal.MinValue;
		//		((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MaxValue = decimal.MaxValue;

		//		((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MinValue = min;
		//		((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MaxValue = max;

		//		((XYDiagram)chartCijene.Diagram).AxisY.Label.NumericOptions.Format = NumericFormat.Number;
		//		((XYDiagram)chartCijene.Diagram).AxisY.Label.NumericOptions.Precision = 2;

		//		((XYDiagram)chartCijene.Diagram).AxisX.Label.Staggered = true;
		//		((XYDiagram)chartCijene.Diagram).AxisX.Label.DateTimeOptions.Format = DateTimeFormat.Custom;
		//		((XYDiagram)chartCijene.Diagram).AxisX.Label.DateTimeOptions.FormatString = "dd.MM.yyyy";

		//		((LineSeriesView)series.View).Color = System.Drawing.ColorTranslator.FromHtml("#C6234F");

		//		//((LineSeriesView)series.View).LineMarkerOptions.Visible = false;
		//		((LineSeriesView)series.View).LineMarkerOptions.Color = System.Drawing.Color.Transparent;
		//		((LineSeriesView)series.View).LineMarkerOptions.BorderVisible = false;
		//		((LineSeriesView)series.View).LineMarkerOptions.FillStyle.FillMode = FillMode.Solid;

		//		((XYDiagram)chartCijene.Diagram).DefaultPane.BackColor = System.Drawing.ColorTranslator.FromHtml("#F5F5F5");
		//		((XYDiagram)chartCijene.Diagram).DefaultPane.FillStyle.FillMode = DevExpress.XtraCharts.FillMode.Solid;

		//		chartCijene.Width = new Unit(845);
		//		chartCijene.Height = new Unit(400);
		//		chartCijene.Legend.Visible = false;
		//	}
		//}

		protected void btnPovratak_Click(object sender, EventArgs e)
		{
			if (ViewState["PrevPage"] != null)
				Response.Redirect(ViewState["PrevPage"].ToString());
		}

		protected void menuPeriod_MenuItemClick(object sender, MenuEventArgs e)
		{
			PostaviGraf();
		}
    }
}