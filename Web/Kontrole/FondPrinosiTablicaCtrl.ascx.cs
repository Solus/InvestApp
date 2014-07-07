using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class FondPrinosiTablicaCtrl : System.Web.UI.UserControl
	{
		public List<int> FondIDs
		{
			get { return ViewState["fondoviIDs"] == null ? null : (List<int>)ViewState["fondoviIDs"]; }
			set { ViewState["fondoviIDs"] = value; }
		}

		private bool _detaljneLabele = false;
		public bool DetaljneLabele
		{
			get { return _detaljneLabele; }
			set { _detaljneLabele = value; }
		}

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void Page_PreRender(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
			}

			if (FondIDs != null && FondIDs.Any())
			{
				//var fondPrinosi = DAL.FondDAC.VratiFondPrinose(FondIDs);

				//if (fondPrinosi != null)
				//	GenerirajTablicuPrinosa();
			}
		}

		public override void DataBind()
		{
			base.OnDataBinding(EventArgs.Empty);

			GenerirajTablicuPrinosa();
		}

		private void GenerirajTablicuPrinosa()
		{
			if (FondIDs == null || !FondIDs.Any())
				return;

			var fondPrinosi = DAL.FondDAC.VratiFondPrinose(FondIDs);
			if (fondPrinosi == null)
				return;

			Table table = new Table();
			table.CssClass = "prinosi_table";

            if (fondPrinosi.Count() == 1)
                table.CssClass += " narrow";

			//ako ima više od jedan, dodaje se i header
			//if (fondPrinosi.Count() > 1)
			{
				TableHeaderRow headerRow = new TableHeaderRow();
				TableHeaderCell headerCell = new TableHeaderCell();
				headerCell.Text = "Prinosi";
				headerRow.Cells.Add(headerCell);

				if (fondPrinosi.Count() > 1)
				{
					foreach (var prinos in fondPrinosi)
					{
						TableHeaderCell headerCellPrinos = new TableHeaderCell();
                        headerCellPrinos.Text = "<span class=\"prinos_color\"></span>" + prinos.NAZIV;
						headerRow.Cells.Add(headerCellPrinos);
					}
				}
				else
					headerRow.Cells.Add(new TableHeaderCell());

				table.Rows.Add(headerRow);
			}

			//retci su vremenski periodi

			//1M
			TableRow row = new TableRow();
			TableCell cell = new TableCell();
			cell.Text = DetaljneLabele ? "Zadnji mjesec" : "1M";
			cell.ToolTip = "Prinos u 1 mjesec";
			row.Cells.Add(cell);

			foreach (var prinos in fondPrinosi)
			{
				TableCell cellPrinos = new TableCell();
                cellPrinos.Text = string.Format("<span class=\"{0}\">{1}</span>", NumberClass(prinos.PRINOS_1M), DecimalPrinosToString(prinos.PRINOS_1M));
				row.Cells.Add(cellPrinos);
			}

			table.Rows.Add(row);

			//3M
			row = new TableRow();
			cell = new TableCell();
			cell.Text = DetaljneLabele ? "Zadnja 3 mjeseca" : "3M";
			cell.ToolTip = "Prinos u 3 mjeseca";
			row.Cells.Add(cell);

			foreach (var prinos in fondPrinosi)
			{
				TableCell cellPrinos = new TableCell();
                cellPrinos.Text = string.Format("<span class=\"{0}\">{1}</span>", NumberClass(prinos.PRINOS_3M), DecimalPrinosToString(prinos.PRINOS_3M));
				row.Cells.Add(cellPrinos);
			}

			table.Rows.Add(row);

			//6M
			row = new TableRow();
			cell = new TableCell();
			cell.Text = DetaljneLabele ? "Zadnjih 6 mjeseci" : "6M";
			cell.ToolTip = "Prinos u 6 mjeseci";
			row.Cells.Add(cell);

			foreach (var prinos in fondPrinosi)
			{
				TableCell cellPrinos = new TableCell();
                cellPrinos.Text = string.Format("<span class=\"{0}\">{1}</span>", NumberClass(prinos.PRINOS_6M), DecimalPrinosToString(prinos.PRINOS_6M));
				row.Cells.Add(cellPrinos);
			}

			table.Rows.Add(row);

			//1G
			row = new TableRow();
			cell = new TableCell();
			cell.Text = DetaljneLabele ? "Zadnjih 12 mjeseci" : "1G";
			cell.ToolTip = "Prinos u 1 godinu";
			row.Cells.Add(cell);

			foreach (var prinos in fondPrinosi)
			{
				TableCell cellPrinos = new TableCell();
                cellPrinos.Text = string.Format("<span class=\"{0}\">{1}</span>", NumberClass(prinos.PRINOS_1G), DecimalPrinosToString(prinos.PRINOS_1G));
				row.Cells.Add(cellPrinos);
			}

			table.Rows.Add(row);

			//3G
			row = new TableRow();
			cell = new TableCell();
			cell.Text = DetaljneLabele ? "Zadnje 3 godine" : "3G";
			cell.ToolTip = "Prinos u 3 godine";
			row.Cells.Add(cell);

			foreach (var prinos in fondPrinosi)
			{
				TableCell cellPrinos = new TableCell();
                cellPrinos.Text = string.Format("<span class=\"{0}\">{1}</span>", NumberClass(prinos.PRINOS_3G), DecimalPrinosToString(prinos.PRINOS_3G));
				row.Cells.Add(cellPrinos);
			}

			table.Rows.Add(row);

			//5G
			row = new TableRow();
			cell = new TableCell();
			cell.Text = DetaljneLabele ? "Zadnjih 5 godina" : "5G";
			cell.ToolTip = "Prinos u 5 godina";
			row.Cells.Add(cell);

			foreach (var prinos in fondPrinosi)
			{
				TableCell cellPrinos = new TableCell();
                cellPrinos.Text = string.Format("<span class=\"{0}\">{1}</span>", NumberClass(prinos.PRINOS_5G), DecimalPrinosToString(prinos.PRINOS_5G));
				row.Cells.Add(cellPrinos);
			}

			table.Rows.Add(row);

			//PGP
			row = new TableRow();
			cell = new TableCell();
			cell.Text = DetaljneLabele ? "Prosječni godišnji prinos" : "PGP";
			cell.ToolTip = "Prosječni godišnji prinos";
			row.Cells.Add(cell);

			foreach (var prinos in fondPrinosi)
			{
				TableCell cellPrinos = new TableCell();
                cellPrinos.Text = string.Format("<span class=\"{0}\">{1}%</span>", NumberClass(prinos.PGP), Common.Utility.DecimalToString(prinos.PGP));
				row.Cells.Add(cellPrinos);
			}

			table.Rows.Add(row);

			Controls.Add(table);
		}

        private string DecimalPrinosToString(decimal? value)
        {
            if (value == 100)
                return "-";
            else
                return Common.Utility.DecimalToString(value) + "%"; 
        }

        private string NumberClass(decimal? value)
        {
            if (value.HasValue)
            {
                return value >= 0 ? "positive" : "negative";
            }
            else
                return "";
        }
	}
}