using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.Common;
using System.Web.Security;
using System.Text.RegularExpressions;

namespace InvestApp.Web.Admin
{
	public partial class AdminKorisnikUredjivanje : UIControls.InvestAppPage
	{
		#region Privatni članovi

		private string UserName
		{
			get
			{
				return ViewState["editusername"] == null ? null : (string)ViewState["editusername"];
			}
			set
			{
				ViewState["editusername"] = value;
			}
		}

		private string PrevPage
		{
			get { return ViewState["PrevPage"] == null ? null : ViewState["PrevPage"].ToString(); }
			set { ViewState["PrevPage"] = value; }
		}

		private bool Novi
		{
			get { return ViewState["modnovikor"] == null ? false : (bool)ViewState["modnovikor"]; }
			set { ViewState["modnovikor"] = value; }
		}

		#endregion

		private const string DRUSTVO_ROLA = "Drustvo";

		[Serializable]
		private class RoleForUser
		{
			public bool IsInRole { get; set; }
			public string Rola { get; set; }

			public RoleForUser(string rola, bool isInRole)
			{
				this.IsInRole = isInRole;
				this.Rola = rola;
			}
		}

		private List<RoleForUser> RolesForUser
		{
			get { return ViewState["usrRoles"] == null ? null : (List<RoleForUser>)ViewState["usrRoles"]; }
			set { ViewState["usrRoles"] = value; }
		}


		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				ViewState["editusername"] = Session["editusername"];
				Session["editusername"] = null;

				ViewState["modnovikor"] = Session["modnovikor"];
				Session["modnovikor"] = null;

				if (Request.UrlReferrer != null)
					PrevPage = Request.UrlReferrer.AbsoluteUri;

				this.Page.Title = "Uređivanje korisnika";
				formHeader.InnerText = "Uređivanje korisnika";

				PrikaziRole();
				divDrustvo.Visible = KorisnikJeDrustvo(UserName);
				BindDrustva();

				if (Novi)
				{
					PostaviUnosNovog();
				}
				else if (!UserName.IsNullOrEmpty())
				{
					var user = Membership.GetUser(UserName);

					//inicijalno punjenje podataka
					if (user != null)
					{
						lblUsername.Text = user.UserName;
						txtEmail.Text = user.Email;
					}

					var korisnik = DAL.AdminDAC.VratiKorisnika(UserName);

					if (korisnik.DRUSTVO_ID.HasValue)
						ddlDrustva.SelectedValue = korisnik.DRUSTVO_ID.Value.ToString();
				}
			}
			else
			{
				txtNovaLozinka.Attributes.Add("value", txtNovaLozinka.Text);
				txtLozinkaPonavljanje.Attributes.Add("value", txtLozinkaPonavljanje.Text);
			}
		}

		private void PostaviUnosNovog()
		{
			if (!Novi)
				return;

			lblUsername.Visible = false;
			txtUserNameNovi.Visible = true;
			valUsernameReq.Enabled = true;
			valUsernameCustom.Enabled = true;
			chkLozinka.Visible = false;
			divLozinka.Visible = true;

			formHeader.InnerText = "Unos korisnika";
		}

		protected void gvRole_DataBinding(object sender, EventArgs e)
		{
			gvRole.DataSource = RolesForUser;
		}

		private void BindDrustva()
		{
			var drustva = DAL.FondDAC.VratiDrustva();

			//var prazno = new DAL.Drustvo();
			//prazno.ID = -1;
			//prazno.NAZIV = "-- Odaberite društvo --";

			//drustva.Insert(0, prazno);

			ddlDrustva.DataSource = drustva;
			ddlDrustva.DataBind();
		}

		private void PrikaziRole()
		{
			string[] userRoles = UserName.IsNullOrEmpty() ? new string[]{} : Roles.GetRolesForUser(UserName);
			string[] allRoles = Roles.GetAllRoles();

			var roles = new List<RoleForUser>();

			foreach (string r in allRoles)
			{
				bool isInRole = userRoles.Contains(r);

				roles.Add(new RoleForUser(r, isInRole));
			}

			RolesForUser = roles;

			gvRole.DataBind();
		}

		private bool KorisnikJeDrustvo(string username)
		{
			if(username.IsNullOrEmpty())
				return false;
			else
				return Roles.IsUserInRole(username, DRUSTVO_ROLA);
		}

		protected void cbIsInRole_CheckedChanged(object sender, EventArgs e)
		{
			GridViewRow Row = ((GridViewRow)((Control)sender).Parent.Parent);
			string rola = gvRole.DataKeys[Row.RowIndex].Value.ToString();
			CheckBox chk = sender as CheckBox;

			RolesForUser.Find(r => r.Rola == rola).IsInRole = chk.Checked;

			if (rola == DRUSTVO_ROLA)
			{
				divDrustvo.Visible = chk.Checked;
			}
		}

		protected void UpdateButton_Click(object sender, EventArgs e)
		{
			if (!Page.IsValid)
				return;

			try
			{
				MembershipUser user = null;
				string password = txtNovaLozinka.Text;
				string email = txtEmail.Text;

				if (!Novi && !UserName.IsNullOrEmpty()) //ažuriranje
				{
					user = Membership.GetUser(UserName);
					user.Email = txtEmail.Text;

					//promjena lozinke
					if (chkLozinka.Checked && txtNovaLozinka.Text.Length > 0)
						user.ChangePassword(user.ResetPassword(), txtNovaLozinka.Text);

					Membership.UpdateUser(user);

					Log("Admin je ažurirao korisnika - " + user.UserName);
				}
				else //unos novog
				{
					string usernameNovi = txtUserNameNovi.Text;
					user = Membership.CreateUser(usernameNovi, password, email);

					if (user != null)
					{
						DAL.KorisnikDAC.NoviKorisnik(usernameNovi);

						Log("Admin je napravio korisnika - " + user.UserName);
					}
				}


				if (user != null)
				{
					PostaviRole(user);

					//postavljanje društva
					int? drustvoID = KorisnikJeDrustvo(user.UserName) ? Convert.ToInt32(ddlDrustva.SelectedValue) : (int?)null;

					DAL.AdminDAC.PostaviKorisnikDrustvo(user.UserName, drustvoID);
				}

				_Povratak();
			}
			catch (MembershipCreateUserException ex)
			{
				valCustom.ErrorMessage  = ex.Message;
				valCustom.IsValid = false;

				string akcija = Novi ? "kreiranja" : "ažuriranja";

				Log("Greška kod adminovog " + akcija + " korisnika: " + ex.Message);
			}
		}

		private void PostaviRole(MembershipUser user)
		{
			//postavljanje rola korisnika
			foreach (var rola in RolesForUser)
			{
				if (rola.IsInRole)
				{
					if (!Roles.IsUserInRole(user.UserName, rola.Rola))
						Roles.AddUserToRole(user.UserName, rola.Rola);
				}
				else if (Roles.IsUserInRole(user.UserName, rola.Rola))
					Roles.RemoveUserFromRole(user.UserName, rola.Rola);
			}
		}

		protected void chkLozinka_CheckedChanged(object sender, EventArgs e)
		{
			divLozinka.Visible = chkLozinka.Checked;
		}

		protected void UpdateCancelButton_Click(object sender, EventArgs e)
		{
			_Povratak();
		}

		private void _Povratak()
		{
			if (!string.IsNullOrEmpty(PrevPage))
				Response.Redirect(PrevPage);
			else
				Response.Redirect(ResolveUrl("~/Admin/AdminCP.aspx"));
		}

		protected void valLozinka_ServerValidate(object source, ServerValidateEventArgs args)
		{
			string lozinka = args.Value;
			string poruka;
			args.IsValid = Common.Security.ProvjeriLozinku(lozinka, out poruka);

			if (!args.IsValid)
				valLozinka.ErrorMessage = poruka;
		}

		protected void valUsernameCustom_ServerValidate(object source, ServerValidateEventArgs args)
		{
			//provjeri postoji li taj username
			string username = args.Value;

			var user = Membership.GetUser(username);

			if (user != null)
			{
				args.IsValid = false;
				valUsernameCustom.ErrorMessage = "Korisničko ime je već zauzeto";
			}
			else
				args.IsValid = true;
		}

		protected void valEmailCustom_ServerValidate(object source, ServerValidateEventArgs args)
		{

			//provjeri postoji li taj email
			string email = args.Value;

			var user = Membership.GetUserNameByEmail(email);

			if (user != null)
			{
				args.IsValid = false;
				valEmailCustom.ErrorMessage = "E-mail je već zauzet";
			}
			else
				args.IsValid = true;
		}
	}
}