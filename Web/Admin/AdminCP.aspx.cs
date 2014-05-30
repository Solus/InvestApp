using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace InvestApp.Web.Admin
{
	public partial class AdminCP : UIControls.InvestAppPage
	{
		class UserWithRoles
		{
			public string UserName { get; set; }
			public string Email { get; set; }
			public string Roles { get; set; }

			public UserWithRoles(string username, string email, string roles)
			{
				this.UserName = username;
				this.Email = email;
				this.Roles = roles;
			}
		}


		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				this.Page.Title = "Admin control panel";

				//var config = DAL.AdminDAC.VratiConfig();
				
				//txtRegisterEmailBody.Text = config.USER_REGISTER_EMAIL_BODY;
				//txtRegisterEmailSubject.Text = config.USER_REGISTER_EMAIL_SUBJECT;
				//txtResetEmailBody.Text = config.PASSWORD_RESET_EMAIL_BODY;
				//txtResetEmailSubject.Text = config.PASSWORD_RESET_EMAIL_SUBJECT;

				gvKorisnici.DataBind();
			}
		}

		protected void gvKorisnici_DataBinding(object sender, EventArgs e)
		{
			var users = Membership.GetAllUsers();

			var usersWithRoles = from u in users.Cast<MembershipUser>()
								 select new UserWithRoles(u.UserName, u.Email, String.Join(", ", Roles.GetRolesForUser(u.UserName)));

			gvKorisnici.DataSource = usersWithRoles;
		}

		protected void gvKorisnici_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs e)
		{
			var user = gvKorisnici.GetRow(e.VisibleIndex) as UserWithRoles;

			if (e.ButtonID == btnEdit.ID)
			{
				Session["editusername"] = user.UserName;

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Admin/AdminKorisnikUredjivanje.aspx");
			}
		}

		protected void gvKorisnici_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
		{
			var gridView = sender as DevExpress.Web.ASPxGridView.ASPxGridView;

			string username = (string)e.Values["UserName"];
			Guid userID = (Guid)Membership.GetUser(username).ProviderUserKey;

			bool deleted = Membership.DeleteUser(username);

			if (deleted)
			{
				DAL.AdminDAC.ObrisiKorisnika(userID);

				Log("Admin je obrisao korisnika - " + username);
			}

			e.Cancel = true;
		}

		protected void btnNovi_Click(object sender, EventArgs e)
		{
			Session["modnovikor"] = true;

			Response.Redirect(ResolveUrl("~/Admin/AdminKorisnikUredjivanje.aspx"));
		}

		//protected void UpdateButton_Click(object sender, EventArgs e)
		//{
		//	DAL.AdminDAC.SpremiConfig(txtRegisterEmailSubject.Text, txtRegisterEmailBody.Text, txtResetEmailSubject.Text, txtResetEmailBody.Text);

		//	lblPoruka.Text = "Postavke su spremljene";
		//}

	}
}