using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;

namespace InvestApp.Web
{
	public partial class FondKorisnikDetalji : InvestApp.UIControls.InvestAppPage
	{
		DateTime vrijemePoc, vrijemeKorisnik;

		#region Privatni članovi
		
		private bool Pravna
		{
			get { return ViewState["korPravna"] == null ? false : (bool)ViewState["korPravna"]; }
			set { ViewState["korPravna"] = value; }
		}

        private enum DokTip
        {
            Osobna,
            Kartica,
            Izvod,
            PotpisniKarton
        }

		#endregion

		protected void Page_Load(object sender, EventArgs e)
		{
			vrijemePoc = DateTime.Now;

			if (!IsPostBack)
			{
				this.Page.Title = "Korisnik";
				//(this.Page.Master.FindControl("korisnikLink") as HtmlAnchor).Attributes["class"] = "current";
				
				EntityDataSourceKorisnikDodatno.WhereParameters["ID"] = new Parameter("ID", System.Data.DbType.Int32, KorisnikID.ToString());

				Pravna = DAL.KorisnikDAC.VratiKorisnika(KorisnikID).IsPravna;
			}
		}

		protected void Page_PreRenderComplete(object sender, EventArgs e)
		{
			TimeSpan vrijemeTotal = DateTime.Now - vrijemePoc;
			TimeSpan tsKorisnik = DateTime.Now - vrijemeKorisnik;

			//lblLog.Text = "Stranica: " + (int)vrijemeTotal.TotalMilliseconds + " ms" + "<br/>" + "Korisnik: " + (int)tsKorisnik.TotalMilliseconds + " ms";
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
                SpremiDokument(DokTip.Osobna);
                return;
			}
			else if (e.CommandName == "slika_kartica")
			{
                SpremiDokument(DokTip.Kartica);
                return;
			}
            else if (e.CommandName == "slika_izvod")
            {
                SpremiDokument(DokTip.Izvod);
                return;
            }
            else if (e.CommandName == "slika_postpisni_karton")
            {
                SpremiDokument(DokTip.PotpisniKarton);
                return;
            }
			else if (e.CommandName == "slika_osobna_clear")
			{
				HtmlAnchor linkOsobna = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxSLIKA_OSOBNE");
				Image imgThumbnail = (Image)FormViewKorisnik.FindControl("imgSLIKA_OSOBNE");
				imgThumbnail.ImageUrl = null;

				linkOsobna.HRef = null;
				linkOsobna.Attributes["class"] = VratiKlasuLightboxLinka(null);
			}
			else if (e.CommandName == "slika_kartica_clear")
			{
				HtmlAnchor linkKartica = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxKARTICA_RACUNA");
				Image imgThumbnail = (Image)FormViewKorisnik.FindControl("imgKARTICA_RACUNA");
				imgThumbnail.ImageUrl = null;
				
				linkKartica.HRef = null;
				linkKartica.Attributes["class"] = VratiKlasuLightboxLinka(null);
			}

            else if (e.CommandName == "izvod_clear")
            {
                HtmlAnchor link = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxIZVOD_SCAN_URL");
                Image imgThumbnail = (Image)FormViewKorisnik.FindControl("imgIZVOD_SCAN_URL");
                imgThumbnail.ImageUrl = null;

                link.HRef = null;
                link.Attributes["class"] = VratiKlasuLightboxLinka(null);
            }
            else if (e.CommandName == "potpisni_karton_clear")
            {
                HtmlAnchor link = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxPOTPISNI_KARTON_SCAN_URL");
                Image imgThumbnail = (Image)FormViewKorisnik.FindControl("imgPOTPISNI_KARTON_SCAN_URL");
                imgThumbnail.ImageUrl = null;

                link.HRef = null;
                link.Attributes["class"] = VratiKlasuLightboxLinka(null);
            }
		}

        private void SpremiDokument(DokTip tip)
        {
            string fileUploadName = "";

            switch (tip)
            {
                case DokTip.Osobna: fileUploadName = "fileOsobna"; break;
                case DokTip.Kartica: fileUploadName = "fileKartica"; break;
                case DokTip.Izvod: fileUploadName = "fileIzvod"; break;
                case DokTip.PotpisniKarton: fileUploadName = "filePotpisniKarton"; break;
                default:
                    return;
            }

            FileUpload upload = (FileUpload)FormViewKorisnik.FindControl(fileUploadName);

            if (upload.HasFile)
            {
                string ext = Path.GetExtension(upload.FileName);
                string fileName, imgName, lightboxName;

                switch (tip)
                {
                    case DokTip.Osobna: fileName = "os_"; imgName = "imgSLIKA_OSOBNE"; lightboxName = "lightboxSLIKA_OSOBNE"; break;
                    case DokTip.Kartica: fileName = "kr_"; imgName = "imgKARTICA_RACUNA"; lightboxName = "lightboxKARTICA_RACUNA"; break;
                    case DokTip.Izvod: fileName = "iz_"; imgName = "imgIZVOD_SCAN_URL"; lightboxName = "lightboxIZVOD_SCAN_URL"; break;
                    case DokTip.PotpisniKarton: fileName = "pk_"; imgName = "imgPOTPISNI_KARTON_SCAN_URL"; lightboxName = "lightboxPOTPISNI_KARTON_SCAN_URL"; break;
                    default:
                        return;
                }

                fileName += KorisnikID;
                
				string folder = "~/Dokumenti/Korisnici/";
				string filePath = folder + fileName + ext;

                string fullFilePath = Server.MapPath(filePath);

				//prije spremanja briše postojeće slike
				foreach (FileInfo f in new DirectoryInfo(Server.MapPath(folder)).GetFiles(fileName + ".*"))
				{
					f.Delete();
				}

                upload.SaveAs(fullFilePath);

                Image imgThumbnail = (Image)FormViewKorisnik.FindControl(imgName);
                HtmlAnchor linkDatoteka = (HtmlAnchor)FormViewKorisnik.FindControl(lightboxName);

				//Common.DatotekaTip dokTip = Common.Utility.VratiTipDatoteke(filePath);
                string previewUrl = Common.Utility.VratiDatotekaIkonaUrl(filePath);

                imgThumbnail.ImageUrl = ResolveClientUrl(previewUrl);
                linkDatoteka.HRef = ResolveClientUrl(filePath);

				//sprječavanje cachiranja
				if (Common.Utility.VratiTipDatoteke(filePath) == Common.DatotekaTip.Slika)
					linkDatoteka.HRef += "?t=" + DateTime.Now.Ticks;

                //samo slika koristi lightbox
                linkDatoteka.Attributes["class"] = VratiKlasuLightboxLinka(filePath);
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

                KontrolaHTML("divKarticaRacuna").Visible = false;
                KontrolaHTML("divIzvod").Visible = true;
                KontrolaHTML("divPotpisniKarton").Visible = true;
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

                KontrolaHTML("divKarticaRacuna").Visible = true;
                KontrolaHTML("divIzvod").Visible = false;
                KontrolaHTML("divPotpisniKarton").Visible = false;
			}
		}

        /// <summary>
        /// Postavlja lightbox na sliku ovisno o tome koji tip datoteke predstavlja
        /// </summary>
        private void PostaviLightbox()
        {
            HtmlAnchor linkOsobna = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxSLIKA_OSOBNE");
            HtmlAnchor linkKartica = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxKARTICA_RACUNA");
            HtmlAnchor linkIzvod = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxIZVOD_SCAN_URL");
            HtmlAnchor linkPotpisniKarton = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxPOTPISNI_KARTON_SCAN_URL");

            linkOsobna.Attributes["class"] = VratiKlasuLightboxLinka(linkOsobna.HRef);
            linkKartica.Attributes["class"] = VratiKlasuLightboxLinka(linkKartica.HRef);
            linkIzvod.Attributes["class"] = VratiKlasuLightboxLinka(linkIzvod.HRef);
            linkPotpisniKarton.Attributes["class"] = VratiKlasuLightboxLinka(linkPotpisniKarton.HRef);
        }

        /// <summary>
        /// Vraća koja klasa treba biti linka, ovisno o tipu datoteke na koji pokazuje
        /// </summary>
        private string VratiKlasuLightboxLinka(string href)
        {
            if (!string.IsNullOrEmpty(href) && Common.Utility.VratiTipDatoteke(href) == Common.DatotekaTip.Slika)
                return "image_link thickbox";
            else
                return "image_link";
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
            if (FormViewKorisnik.CurrentMode == FormViewMode.ReadOnly)
                Response.Redirect("FondKorisnikDetalji.aspx");
		}

		protected void FormViewKorisnik_ModeChanging(object sender, FormViewModeEventArgs e)
		{
		}

		protected void FormViewKorisnik_DataBound(object sender, EventArgs e)
		{
			if ((sender as FormView).DataItem != null)
			{
				PostaviFizickaPravna();
				PostaviLightbox();
			}
		}

		protected void FormViewKorisnik_ItemUpdating(object sender, FormViewUpdateEventArgs e)
		{
			//ispravi URL slika
			string osUrl = (string)e.NewValues["SLIKA_OSOBNE_URL"];
			if (osUrl.Contains('?'))
				 e.NewValues["SLIKA_OSOBNE_URL"] = osUrl.Remove(osUrl.IndexOf('?'));

			
			string krUrl = (string)e.NewValues["KARTICA_RACUNA_URL"];
			if (krUrl.Contains('?'))
				e.NewValues["KARTICA_RACUNA_URL"] = krUrl.Remove(krUrl.IndexOf('?'));

            string izvUrl = (string)e.NewValues["IZVOD_SCAN_URL"];
			if (izvUrl.Contains('?'))
				e.NewValues["IZVOD_SCAN_URL"] = izvUrl.Remove(izvUrl.IndexOf('?'));

            string pkUrl = (string)e.NewValues["POTPISNI_KARTON_SCAN_URL"];
            if (pkUrl.Contains('?'))
                e.NewValues["POTPISNI_KARTON_SCAN_URL"] = pkUrl.Remove(pkUrl.IndexOf('?'));    
		}

		protected void EntityDataSourceKorisnikDodatno_Selecting(object sender, EntityDataSourceSelectingEventArgs e)
		{
			if (KorisnikID <= 0)
				e.Cancel = true;

			vrijemeKorisnik = DateTime.Now;
		}

	}
}