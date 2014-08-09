using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class FondPortfeljPregledCtrl : System.Web.UI.UserControl
	{
		#region Privatni članovi

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

		private decimal _ukupnoPrinos
		{
			get { return (ViewState["prns"] != null) ? Convert.ToDecimal(ViewState["prns"]) : 0; }
			set { ViewState["prns"] = value; }
		}
 
		#endregion
		
		
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				gvPortfelj.DataBind();

                var novac = DAL.FondDAC.KorisnikNovac(KorisnikId);
                txtNovac.Text = lblNovac.Text = Common.Utility.DecimalToString(novac);
			}
		}

		protected void gvPortfelj_DataBinding(object sender, EventArgs e)
		{
			if (KorisnikId <= 0)
				return;

			DateTime poc = DateTime.Now;

			decimal outUkupno, outPrinosKnUkupno, outDobitKnUkupno;
			gvPortfelj.DataSource = DAL.FondDAC.DohvatiPortfeljProsireno(KorisnikId, DateTime.Today, out outUkupno, out outPrinosKnUkupno, out outDobitKnUkupno);

			TimeSpan ts = DateTime.Now - poc;
			(Page.Master.FindControl("lblLog") as Label).Text += " Tablica: " + (int)ts.TotalMilliseconds;

			_ukupnoPrinos = outPrinosKnUkupno;
		}

		protected void gvPortfelj_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs e)
		{
			if (e.Column.Name == "Cijena")
			{
				DAL.DohvatiPortfelj_Result portfelj = (gvPortfelj.GetRow(e.VisibleRowIndex) as DAL.DohvatiPortfelj_Result);
				
				if (portfelj.CIJENA.HasValue)
				{
					var postotak = portfelj.POSTOTAK;
					
					string datum = Common.Utility.DateTimeToString(portfelj.DATUM_ZADNJE_CIJENE);

					string img = "";

					if (postotak.HasValue)
					{
						img =
							postotak == 0 ? "" :
							postotak > 0 ? "gore_green.png" :
							"dolje_red.png";
					}

					e.DisplayText = string.Format(@"<span title='{0}'>{1}</span>&nbsp;<img src='../Images/{2}' />", datum, portfelj.CIJENA.Value.ToString("n4"), img);
				}
			}
			else if (e.Column.Name == "FOND_NAZIV")
			{
				DAL.DohvatiPortfelj_Result portfelj = (gvPortfelj.GetRow(e.VisibleRowIndex) as DAL.DohvatiPortfelj_Result);

				if (portfelj != null)
					e.DisplayText = String.Format("<a class='thickbox' href='../Fond/FondDokumentStandalone.aspx?ID={0}&KeepThis=true&TB_iframe=true&height=700&width=800' >{1}</a>", portfelj.FOND_ID, portfelj.NAZIV_FONDA);
			}
		}

		protected void gvPortfelj_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs e)
		{
			var portfelj = (gvPortfelj.GetRow(e.VisibleIndex) as DAL.DohvatiPortfelj_Result);

			if (portfelj == null)
				return;

			if (e.ButtonID == "cbKupi")
			{
				Session["fondID"] = portfelj.FOND_ID;
				Session["zahtjevMod"] = "K";

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Fond/FondKupnja.aspx");
			}
			else if (e.ButtonID == "cbProdaj")
			{
				Session["fondID"] = portfelj.FOND_ID;
				Session["zahtjevMod"] = "P";

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Fond/FondProdaja.aspx");
			}
		}

		protected void gvPortfelj_CustomSummaryCalculate(object sender, DevExpress.Data.CustomSummaryEventArgs e)
		{
			DevExpress.Web.ASPxGridView.ASPxSummaryItem item = e.Item as DevExpress.Web.ASPxGridView.ASPxSummaryItem;
			if (item.FieldName == "PRINOS")
			{
				e.TotalValue = _ukupnoPrinos.ToString("n2");
				e.TotalValueReady = true;
			}
		}

		protected void btnRucno_Click(object sender, EventArgs e)
		{
			Response.Redirect(ResolveUrl("~/Fond/FondRealizacija.aspx"));
		}

        private void NovacChangeMode(bool edit)
        {
            if (edit)
            {
                divNovacView.Visible = false;
                divNovacEdit.Visible = true;
            }
            else
            {
                divNovacView.Visible = true;
                divNovacEdit.Visible = false;
            }
        }

        protected void btnNovacEdit_Click(object sender, EventArgs e)
        {
            NovacChangeMode(true);
        }

        protected void btnNovacSave_Click(object sender, EventArgs e)
        {
            decimal novac = 0;

            if (decimal.TryParse(txtNovac.Text, out novac))
            {
                DAL.FondDAC.AzurirajNovac(novac, KorisnikId);

                lblNovac.Text = Common.Utility.DecimalToString(novac);
                NovacChangeMode(false);
            }
        }

        protected void btnNovacCancel_Click(object sender, EventArgs e)
        {
            NovacChangeMode(false);
        }
	}
}