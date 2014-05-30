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
            Kartica
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

				//Pravna = DAL.FondDAC.VratiKorisnika(KorisnikID).IsPravna;
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
		}

        private void SpremiDokument(DokTip tip)
        {
            FileUpload upload = (FileUpload)FormViewKorisnik.FindControl(tip == DokTip.Osobna ? "fileOsobna" : "fileKartica");

            if (upload.HasFile)
            {
                string ext = Path.GetExtension(upload.FileName);
				string fileName = (tip == DokTip.Osobna ? "os_" : "kr_") + KorisnikID;
				string folder = "~/Dokumenti/Korisnici/";
				string filePath = folder + fileName + ext;
                //string fileThumbName = folder + "os_" + KorisnikID + "_thumb.jpg";

                string fullFilePath = Server.MapPath(filePath);

				//prije spremanja briše postojeće slike
				foreach (FileInfo f in new DirectoryInfo(Server.MapPath(folder)).GetFiles(fileName + ".*"))
				{
					f.Delete();
				}

                upload.SaveAs(fullFilePath);
                
                ////generiranje i spremanje thumbnaila
                //System.Drawing.Bitmap thumbnail = Common.Utility.CreateThumbnail(fullImagePath, 100, 100);
                //thumbnail.Save(Server.MapPath(fileThumbName));

                Image imgThumbnail = (Image)FormViewKorisnik.FindControl(tip == DokTip.Osobna ? "imgSLIKA_OSOBNE" : "imgKARTICA_RACUNA");
                HtmlAnchor linkDatoteka = (HtmlAnchor)FormViewKorisnik.FindControl(tip == DokTip.Osobna ? "lightboxSLIKA_OSOBNE" : "lightboxKARTICA_RACUNA");

				//Common.DatotekaTip dokTip = Common.Utility.VratiTipDatoteke(filePath);
                string previewUrl = Common.Utility.VratiDatotekaIkonaUrl(filePath);

                imgThumbnail.ImageUrl = ResolveClientUrl(previewUrl);
                linkDatoteka.HRef = ResolveClientUrl(filePath);

				//sprječavanje cachiranja
				if (Common.Utility.VratiTipDatoteke(filePath) == Common.DatotekaTip.Slika)
					linkDatoteka.HRef += "?t=" + DateTime.Now.Ticks;

                //samo slika koristi lightbox
                linkDatoteka.Attributes["class"] = VratiKlasuLightboxLinka(filePath);

                //if (osobnaFull != null)
                //    osobnaFull.HRef = fileName/* + "?t=" + DateTime.Now.Ticks.ToString()*/;
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

        /// <summary>
        /// Postavlja lightbox na sliku ovisno o tome koji tip datoteke predstavlja
        /// </summary>
        private void PostaviLightbox()
        {
            HtmlAnchor linkOsobna = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxSLIKA_OSOBNE");
            HtmlAnchor linkKartica = (HtmlAnchor)FormViewKorisnik.FindControl("lightboxKARTICA_RACUNA");

            linkOsobna.Attributes["class"] = VratiKlasuLightboxLinka(linkOsobna.HRef);
            linkKartica.Attributes["class"] = VratiKlasuLightboxLinka(linkKartica.HRef);
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
		}

		protected void EntityDataSourceKorisnikDodatno_Selecting(object sender, EntityDataSourceSelectingEventArgs e)
		{
			if (KorisnikID <= 0)
				e.Cancel = true;

			vrijemeKorisnik = DateTime.Now;
		}

	}
}