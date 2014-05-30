using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace InvestApp.Web
{
	public partial class FondKorisnikDetalji : InvestApp.UIControls.InvestAppPage
	{
		private bool Pravna
		{
			get { return ViewState["korPravna"] == null ? false : (bool)ViewState["korPravna"]; }
			set { ViewState["korPravna"] = value; }
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if (KorisnikID <= 0)
				return;
						
			if (!IsPostBack)
			{
				this.Page.Title = "Korisnik";

				EntityDataSourceKorisnikDodatno.WhereParameters["ID"] = new Parameter("ID", System.Data.DbType.Int32, KorisnikID.ToString());

				Pravna = DAL.FondDAC.VratiKorisnika(KorisnikID).IsPravna;
			}
		}

		protected void rblPravna_SelectedIndexChanged(object sender, EventArgs e)
		{
			Pravna = (sender as RadioButtonList).SelectedValue == "P";
			PostaviFizickaPravna();
		}

		protected void FormViewKorisnik_ItemCommand(object sender, FormViewCommandEventArgs e)
		{
			if (e.CommandName == "slika_osobna")
			{
				//da li je slika uploadana
				FileUpload upload = (FileUpload)FormViewKorisnik.FindControl("fileOsobna");

				if (upload != null && upload.PostedFile != null && upload.PostedFile.FileName.Length > 0)
				{
					string folder = "/Slike/";
					string fileName = folder + "os_" + KorisnikID + System.IO.Path.GetExtension(upload.PostedFile.FileName);
					string fileThumbName = folder + "os_" + KorisnikID + "_thumb.jpg";

					string fullImagePath = Server.MapPath(fileName);
					upload.SaveAs(fullImagePath);

					//generiranje i spremanje thumbnaila
					System.Drawing.Bitmap thumbnail = Common.Utility.CreateThumbnail(fullImagePath, 100, 100);
					thumbnail.Save(Server.MapPath(fileThumbName));

					Image ctrlImgOsobna = (Image)FormViewKorisnik.FindControl("imgSLIKA_OSOBNE");
					HtmlAnchor osobnaFull = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxSLIKA_OSOBNE");

					if (ctrlImgOsobna != null)
						ctrlImgOsobna.ImageUrl = fileThumbName/* + "?t=" + DateTime.Now.Ticks.ToString()*/;

					if (osobnaFull != null)
						osobnaFull.HRef = fileName/* + "?t=" + DateTime.Now.Ticks.ToString()*/;
				}
			}
			else if (e.CommandName == "slika_kartica")
			{
				//da li je slika uploadana
				FileUpload upload = (FileUpload)FormViewKorisnik.FindControl("fileKartica");

				if (upload != null && upload.PostedFile != null && upload.PostedFile.FileName.Length > 0)
				{
					string folder = "/Slike/";
					string fileName = folder + "kr_" + KorisnikID + System.IO.Path.GetExtension(upload.PostedFile.FileName);
					string fileThumbName = folder + "kr_" + KorisnikID + "_thumb.jpg";

					string fullImagePath = Server.MapPath(fileName);
					upload.SaveAs(fullImagePath);

					//generiranje i spremanje thumbnaila
					System.Drawing.Bitmap thumbnail = Common.Utility.CreateThumbnail(fullImagePath, 100, 100);
					thumbnail.Save(Server.MapPath(fileThumbName));

					Image ctrlImgKartica = (Image)FormViewKorisnik.FindControl("imgKARTICA_RACUNA");
					HtmlAnchor osobnaFull = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxKARTICA_RACUNA");

					if (ctrlImgKartica != null)
						ctrlImgKartica.ImageUrl = fileThumbName/* + "?t=" + DateTime.Now.Ticks.ToString()*/;

					if (osobnaFull != null)
						osobnaFull.HRef = fileName/* + "?t=" + DateTime.Now.Ticks.ToString()*/;
				}
			}
		}

		/// <summary>
		/// Mijenja sučelje ovisno o tome da li je korisnik fizička ili pravna
		/// </summary>
		private void PostaviFizickaPravna()
		{
			if (Pravna)
			{
				KontrolaHTML("divVlasnistvoPodijeljeno").Visible = true;
				KontrolaHTML("divPravnaUlaganja").Visible = true;
				KontrolaHTML("divZastupnik").Visible = true;
				KontrolaHTML("divFizickaOstalo").Visible = false;
				KontrolaHTML("divPrezime").Visible = false;
				KontrolaHTML("lblMB").InnerText = "MB:";
				KontrolaHTML("lblIme").InnerText = "Naziv pravne osobe:";
			}
			else // fizička
			{
				KontrolaHTML("divVlasnistvoPodijeljeno").Visible = false;
				KontrolaHTML("divPravnaUlaganja").Visible = false;
				KontrolaHTML("divZastupnik").Visible = false;
				KontrolaHTML("divFizickaOstalo").Visible = true;
				KontrolaHTML("divPrezime").Visible = true;
				KontrolaHTML("lblMB").InnerText = "JMBG:";
				KontrolaHTML("lblIme").InnerText = "Ime:";
			}
		}

		public string BoolToString(object value)
		{
			if (value == null)
				return "";

			return value.ToString() == "D" ? "DA" : "NE";
		}

		private HtmlGenericControl KontrolaHTML(string kontrolaID)
		{
			return FormViewKorisnik.FindControl(kontrolaID) as HtmlGenericControl;
		}

		protected void FormViewKorisnik_ModeChanged(object sender, EventArgs e)
		{
		}

		protected void FormViewKorisnik_ModeChanging(object sender, FormViewModeEventArgs e)
		{
		}

		protected void FormViewKorisnik_DataBound(object sender, EventArgs e)
		{
			PostaviFizickaPravna();
		}

	}
}