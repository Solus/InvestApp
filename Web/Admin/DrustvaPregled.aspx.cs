using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace InvestApp.Web
{
	public partial class DrustvaPregled : UIControls.InvestAppPage
	{
		public string LogoFileName
		{
			get { return ViewState["drustvoLogo"] != null ? ViewState["drustvoLogo"].ToString() : null; }
			set { ViewState["drustvoLogo"] = value; }
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
                this.Master.Page.Title = "Uređivanje društava | investiraj.net";
			}
		}

		protected void gvDrustva_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
		{
			try
			{
				int drustvoID = Convert.ToInt32((gvDrustva.FindEditFormTemplateControl("txtID") as HiddenField).Value);

				string fileName = SpremiLogo(drustvoID);

				if(!string.IsNullOrEmpty(fileName))
					e.NewValues["LOGO_URL"] = fileName;
				e.NewValues["NAZIV"] = (gvDrustva.FindEditFormTemplateControl("txtNaziv") as TextBox).Text;
			}
			catch (Exception ex)
			{
				Log("Greška pri ažuriranju društva: ", ex);
			}
		}

		protected void gvDrustva_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
		{
			try
			{
				string fileName = SpremiLogo(null);

				e.NewValues["LOGO_URL"] = fileName;
				e.NewValues["NAZIV"] = (gvDrustva.FindEditFormTemplateControl("txtNaziv") as TextBox).Text;
			}
			catch (Exception ex)
			{
				Log("Greška pri unosu društva: ", ex);
			}
		}

		protected void gvDrustva_Load(object sender, EventArgs e)
		{
			if (gvDrustva.IsEditing)
				gvDrustva.SettingsText.PopupEditFormCaption = "Uređivanje društva";
			else
				gvDrustva.SettingsText.PopupEditFormCaption = "Unos društva";
		}

		private string SpremiLogo(int? drustvoID)
		{
			FileUpload fileUpload = gvDrustva.FindEditFormTemplateControl("fileLogo") as FileUpload;

			if (fileUpload.HasFile)
			{
					string ext = Path.GetExtension(fileUpload.FileName);
					string fileName = "~/Images/Drustva/drustvo_logo_" + (drustvoID ?? DateTime.Now.Ticks) + ext;
					string fullFileName = Server.MapPath(fileName);

					fileUpload.SaveAs(fullFileName);

					return fileName;
			}

			return null;
		}
	}
}