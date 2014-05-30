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
	public partial class FondUredjivanje : InvestApp.UIControls.InvestAppPage
	{
		#region Privatni članovi

		private int FondID
		{
			get
			{
				return Session["fondID"] == null ? -1 : (int)Session["fondID"];
			}
			set
			{
				Session["fondID"] = value;
			}
		}

		private string PrevPage {
			get { return ViewState["PrevPage"] == null ? null : ViewState["PrevPage"].ToString(); }
			set { ViewState["PrevPage"] = value; }
		}

		private string DokKIID
		{
			get { return ViewState["dokkiid"] == null ? null : ViewState["dokkiid"].ToString(); }
			set { ViewState["dokkiid"] = value; }
		}

		private string DokPravila
		{
			get { return ViewState["dokpravila"] == null ? null : ViewState["dokpravila"].ToString(); }
			set { ViewState["dokpravila"] = value; }
		}

		private string DokProspekt
		{
			get { return ViewState["dokprosp"] == null ? null : ViewState["dokprosp"].ToString(); }
			set { ViewState["dokprosp"] = value; }
		}

		private string DokOsobna
		{
			get { return ViewState["dokosobna"] == null ? null : ViewState["dokosobna"].ToString(); }
			set { ViewState["dokosobna"] = value; }
		}

		#endregion

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Request.UrlReferrer != null)
					PrevPage = Request.UrlReferrer.AbsoluteUri;

				if (FondID > 0) //ispravka
				{
					FormViewFond.ChangeMode(FormViewMode.Edit);

					var fond = DAL.FondDAC.VratiFond(FondID);
					formHeader.InnerText = fond.NAZIV;
					this.Page.Title = fond.NAZIV + " - Ispravka";

					//trenutni dokumenti
					DokKIID = fond.KIID_URL;
					DokOsobna = fond.OSOBNA_ISKAZNICA_URL;
					DokPravila = fond.PRAVILA_URL;
					DokProspekt = fond.PROSPEKT_URL;

					EntityDataSourceFond.WhereParameters["ID"] = new Parameter("ID", System.Data.DbType.Int32, FondID.ToString());
				}
				else if (((Common.DokumentMod)Session["fonddokmod"]) == Common.DokumentMod.Novi) //novi
				{
					FormViewFond.ChangeMode(FormViewMode.Insert);
				}
				else
					FormViewFond.ChangeMode(FormViewMode.ReadOnly);

				//društvo može samo svoje fondove uređivati
				if (KorisnikJeDrustvo)
				{
					EntityDataSourceDrustva.AutoGenerateWhereClause = true;
					EntityDataSourceDrustva.WhereParameters["ID"] = new Parameter("ID", System.Data.DbType.Int32, KorisnikDrustvoID.ToString());
				}

			}
		}

		protected void EntityDataSourceFond_Selecting(object sender, EntityDataSourceSelectingEventArgs e)
		{
			if (FondID <= 0)
				e.Cancel = true;
		}

		protected void FormViewKorisnik_ItemCommand(object sender, FormViewCommandEventArgs e)
		{
			if (e.CommandName == "Cancel")
			{
				_Povratak();
			}
		}

		protected void FormViewKorisnik_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
		{
			_Povratak();
		}

		private FileUpload KontrolaFile(string id)
		{
			return FormViewFond.FindControl(id) as FileUpload;
		}

		private void _Povratak()
		{
			if (!string.IsNullOrEmpty(PrevPage))
				Response.Redirect(PrevPage);
			else
				Response.Redirect(ResolveUrl("~/Fond/FondPregled.aspx"));
		}

		protected void FormViewFond_ItemUpdating(object sender, FormViewUpdateEventArgs e)
		{
			//spremanje datoteka
			if ((FormViewFond.FindControl("chkDok") as CheckBox).Checked)
			{
				string kiid = SpremiDatoteku("fileKIID", DokKIID);
				string pravila = SpremiDatoteku("filePravila", DokPravila);
				string prospekt = SpremiDatoteku("fileProspekt", DokProspekt);
				string osobna = SpremiDatoteku("fileOsobna", DokOsobna);

				e.NewValues["KIID_URL"] = kiid;
				e.NewValues["PRAVILA_URL"] = pravila;
				e.NewValues["PROSPEKT_URL"] = prospekt;
				e.NewValues["OSOBNA_ISKAZNICA_URL"] = osobna;
			}
		}

		private string SpremiDatoteku(string fileUpload, string postojecaDatoteka=null, int? fondId = null)
		{
			FileUpload upload = KontrolaFile(fileUpload);

			//brisanje postojeće
			if (!string.IsNullOrEmpty(postojecaDatoteka))
			{
				string fullPath = Server.MapPath(postojecaDatoteka);

				if (File.Exists(fullPath))
					File.Delete(fullPath);
			}

			if (upload.HasFile)
			{
				string fondFolder = (fondId ?? FondID).ToString();

				string fileName = Path.GetFileName(upload.FileName);
				string folder = "~/Dokumenti/Fondovi/" + fondFolder + "/";
				string filePath = folder + fileName;

				string fullFolderPath = Server.MapPath(folder);
				string fullFilePath = Server.MapPath(filePath);

				if (!Directory.Exists(fullFolderPath))
					Directory.CreateDirectory(fullFolderPath);

				upload.PostedFile.SaveAs(fullFilePath);

				return filePath;
			}

			return null;
		}

		protected void chkDok_CheckedChanged(object sender, EventArgs e)
		{
			(FormViewFond.FindControl("divDokUpload") as HtmlGenericControl).Visible = (sender as CheckBox).Checked;
		}

		protected void EntityDataSourceFond_Inserted(object sender, EntityDataSourceChangedEventArgs e)
		{
			var fond = e.Entity as DAL.Fond;

			//spremanje datoteka
			if ((FormViewFond.FindControl("chkDok") as CheckBox).Checked)
			{
				string kiid = SpremiDatoteku("fileKIID", fondId: fond.ID);
				string pravila = SpremiDatoteku("filePravila", fondId: fond.ID);
				string prospekt = SpremiDatoteku("fileProspekt", fondId: fond.ID);
				string osobna = SpremiDatoteku("fileOsobna", fondId: fond.ID);

				DAL.FondDAC.UnesiFondDokumente(fond.ID, kiid, pravila, prospekt, osobna);
			}
		}

		protected void FormViewFond_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
			_Povratak();
		}

		protected void FormViewFond_DataBound(object sender, EventArgs e)
		{
			if (FormViewFond.CurrentMode == FormViewMode.Insert)
			{
				(FormViewFond.FindControl("VALUTA_SIFRALabel") as DropDownList).SelectedValue = "191";
			}
		}

	}
}