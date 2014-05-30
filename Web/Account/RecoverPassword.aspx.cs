using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace InvestApp.Web
{
	public partial class RecoverPassword : UIControls.InvestAppPage
	{
		public string Username
		{
			get { return ViewState["chngusername"] == null ? null : (string)ViewState["chngusername"]; }
			set { ViewState["chngusername"] = value; }
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				lblPoruka.Visible = false;

				if (Request.QueryString.HasKeys() && Request.QueryString["username"] != null && Request.QueryString["request"] != null)
				{
					if (ProvjeriRequest()) //promjena lozinke
					{
						PasswordRecovery1.Visible = false;
						phPromijeni.Visible = true;

						Username = (string)Request.QueryString["username"];
						lblUsername.Text = Username;
					}
					else
					{
						PasswordRecovery1.Visible = phPromijeni.Visible = false;
						lblPoruka.Text = "Neispravan zahtjev";
						lblPoruka.Visible = true;
					}
				}
			}
		}

		private bool ProvjeriRequest()
		{
			string username = (string)Request.QueryString["username"];
			string token = (string)Request.QueryString["request"];

			return DAL.KorisnikDAC.PasswordRequestValjan(username, token);
		}

		#region Resetiranje lozinke
		
		protected void valUsernamePostoji_ServerValidate(object source, ServerValidateEventArgs args)
		{
			string username = args.Value;

			var user = Membership.GetUser(username);

			args.IsValid = user != null;
		}

		#endregion Resetiranje lozinke

		#region Promjena lozinke

		protected void valLozinkaCustom_ServerValidate(object source, ServerValidateEventArgs args)
		{
			string lozinka = args.Value;
			string poruka;
			args.IsValid = Common.Security.ProvjeriLozinku(lozinka, out poruka);

			if (!args.IsValid)
				valLozinkaCustom.ErrorMessage = poruka;
		}

		protected void btnPromijeni_Click(object sender, EventArgs e)
		{
			if (!IsValid)
				return;

			//promijeni lozinku
			string lozinka = txtLozinka.Text;

			var user = Membership.GetUser(Username);
			user.ChangePassword(user.ResetPassword(), lozinka);
			Membership.UpdateUser(user);

			DAL.KorisnikDAC.ObrisiPasswordRequest(Username);

			FormsAuthentication.SetAuthCookie(Username, true);
			Response.Redirect(ResolveUrl("~/Fond/FondPregled.aspx"));
		}

		#endregion Promjena lozinke

		protected void PasswordRecovery1_SendingMail(object sender, MailMessageEventArgs e)
		{
			Log("Zatraženo resetiranje lozinke. Username: " + PasswordRecovery1.UserName);

			string token = DAL.KorisnikDAC.PostaviPasswordResetZahtjev(PasswordRecovery1.UserName);

			string resetUrl = Request.Url.GetLeftPart(UriPartial.Authority) + Page.ResolveUrl("~/Account/RecoverPassword.aspx?username=" + PasswordRecovery1.UserName + "&request=" + token);

			e.Message.Body = e.Message.Body.Replace("<%ResetUrl%>", resetUrl);
		}

		protected void PasswordRecovery1_UserLookupError(object sender, EventArgs e)
		{
			Log("Unesen nepostojeći username kod resetiranja lozinke: " + PasswordRecovery1.UserName);
		}

		protected void PasswordRecovery1_SendMailError(object sender, SendMailErrorEventArgs e)
		{
			Log("Greška kod slanja maila za resetiranje lozinke. " + e.Exception.Message);
		}
	}
}