using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using InvestApp.Common;

namespace InvestApp.Web
{
	public partial class FondZahtjevRealizacija : InvestApp.UIControls.InvestAppPage
	{
		public int ZahtjevID
		{
			get
			{
				return Session["zahtjevid"] == null ? -1 : (int)Session["zahtjevid"];
			}
			set
			{
				Session["zahtjevid"] = value;
			}
		}

		public FondZahtjevHelper.Tip TipZahtjeva
		{
			get
			{
				return ViewState["zahtjevtip"] == null ? FondZahtjevHelper.Tip.None : (FondZahtjevHelper.Tip)ViewState["zahtjevtip"];
			}

			set
			{
				ViewState["zahtjevtip"] = value;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				this.Page.Title = "Realizacija";

				if (Request.UrlReferrer != null)
					ViewState["PrevPage"] = Request.UrlReferrer;

				InitKontrole();
			}
		}

		private void InitKontrole()
		{
			if (ZahtjevID <= 0)
				return;

			var zahtjev = DAL.FondDAC.VratiZahtjev(ZahtjevID);

			TipZahtjeva = zahtjev.Tip;

			if (zahtjev.Tip == Common.FondZahtjevHelper.Tip.Kupnja)
			{
				formHeader.InnerText = "Realizacija kupnje udjela";

				divKupnja.Visible = true;
				divProdaja.Visible = false;

				lblKupljenoIznos.Text = Common.Utility.DecimalToString(zahtjev.ZELJENI_IZNOS_UDJELA) + " kn";
			}
			else if (zahtjev.Tip == Common.FondZahtjevHelper.Tip.Prodaja)
			{
				formHeader.InnerText = "Realizacija prodaje udjela";

				divKupnja.Visible = false;
				divProdaja.Visible = true;

				lblProdanoBrojUdjela.Text = zahtjev.ZELJENI_BROJ_UDJELA.Value.ToString("n0");
			}

			lblFondNaziv.Text += zahtjev.FOND_NAZIV;
		}

		private void _Povratak()
		{
			if (ViewState["PrevPage"] != null)
				Response.Redirect(ViewState["PrevPage"].ToString());
		}

		protected void btnCancel_Click(object sender, EventArgs e)
		{
			_Povratak();
		}

		protected void btnUpdate_Click(object sender, EventArgs e)
		{
			//upload potvrdu i realizacija zahtjev
			string portvdaUrl = SpremiDokument();
			decimal? brojUdjela = null, iznosUdjela = null;

			if (TipZahtjeva == FondZahtjevHelper.Tip.Kupnja)
			{
				brojUdjela = Utility.StringToDecimal(txtKupljenoBrojUdjela.Text);
			}
			else if (TipZahtjeva == FondZahtjevHelper.Tip.Prodaja)
			{
				iznosUdjela = Utility.StringToDecimal(txtProdanoIznos.Text);
			}

			DAL.FondDAC.UnesiPromet(KorisnikID, ZahtjevID, portvdaUrl, iznosUdjela, brojUdjela);

			_Povratak();
		}

		private string SpremiDokument()
		{
			string filePath = "";

			if (fileDokument.HasFile)
			{
				string ext = Path.GetExtension(fileDokument.FileName);
				string fileName = "zahtjevPotvrda_" + ZahtjevID;
				string folder = "~/Dokumenti/Potvrde/";
				filePath = folder + fileName + ext;

				string fullFilePath = Server.MapPath(filePath);
				
				fileDokument.SaveAs(fullFilePath);
			}

			return filePath;
		}
	}
}