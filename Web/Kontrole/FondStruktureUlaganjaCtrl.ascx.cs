using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.Common;

namespace InvestApp.Web
{
	public partial class FondStruktureUlaganjaCtrl : System.Web.UI.UserControl
	{
		public int FondID
		{
			get { return ViewState["fondID"] == null ? -1 : (int)ViewState["fondID"]; }
			set { ViewState["fondID"] = value; }
		}

		public FondoviHelper.StrukturaUlaganjaTip Tip
		{
			get { return ViewState["fondstrultip"] == null ? FondoviHelper.StrukturaUlaganjaTip.None : (FondoviHelper.StrukturaUlaganjaTip)ViewState["fondstrultip"]; }
			set { ViewState["fondstrultip"] = value; }
		}

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void Page_PreRender(object sender, EventArgs e)
		{
		}

		public override void DataBind()
		{
			base.OnDataBinding(EventArgs.Empty);

			GenerirajStrukturuUlaganja();
		}

		private void GenerirajStrukturuUlaganja()
		{
			if (FondID <= 0)
				return;

			var struktura = DAL.FondDAC.VratiFondStrukturaUlaganja(FondID, Tip, DateTime.Today);
			if (struktura == null)
				return;

			Table table = new Table();
			table.CssClass = "struktura_ulaganja_table";

			#region Header

			TableHeaderRow headerRow = new TableHeaderRow();
			TableHeaderCell headerCell = new TableHeaderCell();
			headerCell.Text = FondoviHelper.StrukturaUlaganjaNaslov(Tip);
			headerCell.ColumnSpan = 2;
			headerRow.Cells.Add(headerCell);
			table.Rows.Add(headerRow);

			#endregion

			foreach (var detalj in struktura.Detalji)
			{
				TableRow row = new TableRow();
				TableCell cellNaziv = new TableCell();
				cellNaziv.Text = detalj.NAZIV;
				row.Cells.Add(cellNaziv);

				TableCell cellUdio = new TableCell();
				cellUdio.Text = Utility.DecimalToString(detalj.UDIO) + "%";
				row.Cells.Add(cellUdio);

				table.Rows.Add(row);
			}

			Controls.Add(table);
		}
	}
}