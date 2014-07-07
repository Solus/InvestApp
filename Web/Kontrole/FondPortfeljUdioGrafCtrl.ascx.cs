using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class FondPortfeljUdioGrafCtrl : System.Web.UI.UserControl
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

			_TraziS();
		}

		private void _TraziS()
		{
			DateTime poc = DateTime.Now;

			string kategorija = ddlPrikaz.SelectedValue;

			var struktura = DAL.FondDAC.DohvatiPortfeljStruktura(KorisnikId, DateTime.Today, kategorija);

			if (struktura.Any())
			{
                DevExpress.XtraCharts.Series s = qtyChart.Series[0];// new DevExpress.XtraCharts.Series("QtyOnHand", DevExpress.XtraCharts.ViewType.Pie3D);
				s.DataSource = struktura;
				s.ValueScaleType = DevExpress.XtraCharts.ScaleType.Numerical;
				s.ValueDataMembers.AddRange(new string[] { "VRIJEDNOST" });
				s.ArgumentDataMember = "KATEGORIJA";
				//((DevExpress.XtraCharts.PiePointOptions)s.Label.PointOptions).PercentOptions.ValueAsPercent = true;
				//((DevExpress.XtraCharts.PiePointOptions)s.Label.PointOptions).PercentOptions.PercentageAccuracy = 4;
				//((DevExpress.XtraCharts.PiePointOptions)s.Label.PointOptions).ValueNumericOptions.Format = DevExpress.XtraCharts.NumericFormat.Percent;
				s.LegendPointOptions.Pattern = "{A} : {V}";
				//((DevExpress.XtraCharts.Pie3DSeriesView)s.View).ExplodeMode = DevExpress.XtraCharts.PieExplodeMode.All;

				//qtyChart.Legend.Direction = DevExpress.XtraCharts.LegendDirection.BottomToTop;

				qtyChart.Width = new Unit(Width);
				qtyChart.Height = new Unit(Height);

				qtyChart.Series.Clear();
				qtyChart.Series.Add(s);
				qtyChart.DataBind();

			}

			UpdatePanel1.Update();

			TimeSpan ts = DateTime.Now - poc;
			(Page.Master.FindControl("lblLog") as Label).Text += " Piechart: " + (int)ts.TotalMilliseconds;
		}

		protected void ddlPrikaz_SelectedIndexChanged(object sender, EventArgs e)
		{
			_TraziS();
		}

	}
}