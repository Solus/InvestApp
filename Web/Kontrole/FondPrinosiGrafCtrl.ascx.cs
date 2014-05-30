using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;
using System.Drawing;

namespace InvestApp.Web
{
	public partial class FondPrinosiGrafCtrl : System.Web.UI.UserControl
	{
		#region Privatni članovi

		private int _fondID
		{
			get { return (ViewState["fondID"] != null) ? Convert.ToInt32(ViewState["fondID"]) : -1; }
			set { ViewState["fondID"] = value; }
		}

		private DateTime _datumPoc
		{
			get { return (ViewState["datumOd"] != null) ? Convert.ToDateTime(ViewState["datumOd"]) : DateTime.MinValue; }
			set { ViewState["datumOd"] = value; }
		}

		static List<Color> GrafBoje = new List<Color>() { Color.CornflowerBlue, Color.OliveDrab, Color.Salmon, Color.Indigo, Color.Plum, Color.MediumTurquoise };

		#endregion

		#region Javni članovi

		public int FondID
		{
			get { return _fondID; }
			set { _fondID = value; }
		}
		public DateTime DatumPoc
		{
			get { return _datumPoc; }
			set { _datumPoc = value; }
		}

		public int Width { get; set; }
		public int Height { get; set; }
		public string Naslov { get; set; }
		public bool PrikaziIndeksni { get; set; }

		#endregion

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
			}
		}

		protected void Page_PreRender(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				chartCijene.Width = Width;
				chartCijene.Height = Height;
			}
		}

		protected void chartCijene_DataBinding(object sender, EventArgs e)
		{
			if (FondID <= 0)
				return;

			DateTime maxDate = DateTime.Today;

			var cijene = DAL.FondDAC.DohvatiCijeneProsireno(FondID, DatumPoc, maxDate);

			//indeksni fondovi
			var indeksniCijene = PrikaziIndeksni ? DAL.FondDAC.DohvatiCijeneIndeksni(DatumPoc, maxDate) : null;

			#region Ograničavanje broja elemenata grafa

			int? maxZapisa = DAL.AdminDAC.VratiConfig().GRAF_MAX_ZAPISA;
			
			if (cijene.Any() && maxZapisa.HasValue)
			{
				int broj = cijene.Count;
				int skip = broj <= maxZapisa ? 0 : (int)(Math.Ceiling(broj / (decimal)maxZapisa.Value));

				if (skip > 0)
					cijene = cijene.Where((c, i) => i % skip == 0).ToList();
			}

			//postotne
			var max = cijene.Max(c => c.POSTOTAK);
			var min = cijene.Min(c => c.POSTOTAK);

			if (indeksniCijene != null && indeksniCijene.Any() && maxZapisa.HasValue)
			{
				foreach (var ind in indeksniCijene)
				{
					int broj = ind.Cijene.Count;
					int skip = broj <= maxZapisa ? 0 : (int)(Math.Ceiling(broj / (decimal)maxZapisa.Value));

					if (skip > 0)
						ind.Cijene = ind.Cijene.Where((c, i) => i % skip == 0).ToList();
				}
			}

			#endregion Ograničavanje broja elemenata grafa

			if (indeksniCijene != null && indeksniCijene.Any())
			{
				var maxInd = indeksniCijene.Max(i=>i.Cijene.Max(c=>c.POSTOTAK));
				var minInd = indeksniCijene.Min(i => i.Cijene.Min(c => c.POSTOTAK));

				if (maxInd > max)
					max = maxInd;

				if (minInd < min)
					min = minInd;
			}

			if (cijene.Any())
			{
				//ako se nije dosegao početak intervala, ubaci prazan zapis
				//if (cijene.Min(c => c.DATUM) > DatumPoc)
				//{
				//	var novaCijena = new DAL.DohvatiCijene_Result();
				//	novaCijena.DATUM = DatumPoc;
				//	novaCijena.POSTOTAK = 0;
				//	cijene.Add(novaCijena);
				//}

				//DevExpress.XtraCharts.Series series = new DevExpress.XtraCharts.Series("Series1", DevExpress.XtraCharts.ViewType.Line);
				DevExpress.XtraCharts.Series series = chartCijene.Series[0];

				((LineSeriesView)series.View).Color = System.Drawing.ColorTranslator.FromHtml("#C6234F");
				series.DataSource = cijene;
				//series.ArgumentScaleType = DevExpress.XtraCharts.ScaleType.DateTime;
				series.ArgumentDataMember = "DATUM";
				//series.ValueScaleType = DevExpress.XtraCharts.ScaleType.Numerical;
				series.ValueDataMembers.AddRange(new string[] { "POSTOTAK" });
				series.Name = DAL.FondDAC.VratiFondNaziv(FondID);
				
				//indeksni
				if (indeksniCijene != null && indeksniCijene.Any())
				{
					int i = 0;
					foreach (var ind in indeksniCijene)
					{
						DevExpress.XtraCharts.Series seriesIndeksni = (DevExpress.XtraCharts.Series)chartCijene.Series[0].Clone();
						((LineSeriesView)seriesIndeksni.View).Color = GrafBoje[i++ % GrafBoje.Count];

						seriesIndeksni.DataSource = ind.Cijene;

						chartCijene.Series.Add(seriesIndeksni);
						chartCijene.Legend.Visible = true;

						seriesIndeksni.Name = ind.Naziv;

						((LineSeriesView)series.View).LineStyle.Thickness = 1;
						((LineSeriesView)seriesIndeksni.View).LineStyle.Thickness = 1;
					}
				}

				//((XYDiagram)chartCijene.Diagram).AxisY.Label.EndText = "%";

				//chartCijene.Series.Add(series);

				decimal razlika = (max.Value - min.Value) * (decimal)0.1;
				if (razlika == 0) razlika = (decimal)0.001;

				min = min - razlika;
				max = max + razlika;

				((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MinValue = decimal.MinValue;
				((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MaxValue = decimal.MaxValue;

				((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MinValue = min;
				((XYDiagram)chartCijene.Diagram).AxisY.VisualRange.MaxValue = max;

				//((XYDiagram)chartCijene.Diagram).AxisX.VisualRange.Auto = false;
				//((XYDiagram)chartCijene.Diagram).AxisX.VisualRange.SetMinMaxValues(DatumPoc, DateTime.Today);

				//var minDate = DatumPoc == DateTime.MinValue ? cijene.Min(c => c.DATUM).Value : DatumPoc;

				if (!string.IsNullOrEmpty(Naslov))
				{
					chartCijene.Titles[0].Visible = true;
					chartCijene.Titles[0].Text = Naslov;
				}

				//((XYDiagram)chartCijene.Diagram).AxisY.Label.NumericOptions.Format = NumericFormat.Number;
				//((XYDiagram)chartCijene.Diagram).AxisY.Label.NumericOptions.Precision = 2;

				//((XYDiagram)chartCijene.Diagram).AxisX.Label.Staggered = true;
				//((XYDiagram)chartCijene.Diagram).AxisX.Label.DateTimeOptions.Format = DateTimeFormat.Custom;
				//((XYDiagram)chartCijene.Diagram).AxisX.Label.DateTimeOptions.FormatString = "dd.MM.yyyy";

				//((LineSeriesView)series.View).Color = System.Drawing.ColorTranslator.FromHtml("#C6234F");

				//((LineSeriesView)series.View).LineMarkerOptions.Visible = false;
				//((LineSeriesView)series.View).LineMarkerOptions.Color = System.Drawing.Color.Transparent;
				//((LineSeriesView)series.View).LineMarkerOptions.BorderVisible = false;
				//((LineSeriesView)series.View).LineMarkerOptions.FillStyle.FillMode = FillMode.Solid;

				//((XYDiagram)chartCijene.Diagram).DefaultPane.BackColor = System.Drawing.ColorTranslator.FromHtml("#F5F5F5");
				//((XYDiagram)chartCijene.Diagram).DefaultPane.FillStyle.FillMode = DevExpress.XtraCharts.FillMode.Solid;

				//chartCijene.Width = new Unit(845);
				//chartCijene.Height = new Unit(400);
				//chartCijene.Legend.Visible = false;

			}
		}
	}
}