using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class FondZahtjevPoruka : UIControls.InvestAppPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				this.Page.Title = "InvestApp";

				lblStatusPoruka.Text = PorukaText;
				PorukaText = null;

				ViewState["fondzahtjevID"] = Session["fondzahtjevID"];
				Session["fondzahtjevID"] = null;

				int zahtjevID = ViewState["fondzahtjevID"] == null ? -1 : (int)ViewState["fondzahtjevID"];

                if (zahtjevID <= 0)
                    btnZahtjev.Visible = false;
                else
                {
                    btnZahtjev.Visible = true;

                    var zahtjev = DAL.FondDAC.VratiZahtjev(zahtjevID);

                    if (zahtjev != null && zahtjev.Tip == Common.FondZahtjevHelper.Tip.Prodaja)
                    {
                        btnZahtjev.Text = "Preuzmi zahtjev za otkup";
                        btnDokumenti.Text = "Predaj zahtjev za otkup";
                    }
                }
			}
		}

		protected void btnZahtjev_Click(object sender, EventArgs e)
		{
			int zahtjevID = ViewState["fondzahtjevID"] == null ? -1 : (int)ViewState["fondzahtjevID"];

			btnZahtjev.Visible = true;

			Reports.ZahtjeviGenericRpt rpt = new Reports.ZahtjeviGenericRpt();
			rpt.BindDataSource(zahtjevID);

			System.IO.MemoryStream stream = new System.IO.MemoryStream();
			rpt.ExportToPdf(stream);
			stream.Seek(0, System.IO.SeekOrigin.Begin);
			stream.CopyTo(Response.OutputStream);

			Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
			Response.ContentType = "application/pdf";
			Response.AddHeader("Content-Disposition", String.Format("attachment; filename=zahtjev.pdf"));
			Response.End();
		}

        protected void btnDokumenti_Click(object sender, EventArgs e)
        {
            Response.Redirect(ResolveUrl("~/Fond/SlanjeZahtjeva.aspx"));
        }
	}
}