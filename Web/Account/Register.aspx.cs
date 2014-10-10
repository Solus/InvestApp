using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Membership.OpenAuth;

namespace InvestApp.Web
{
	public partial class Register : UIControls.InvestAppPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        }

        protected void RegisterUser_CreatedUser(object sender, EventArgs e)
        {
			//ako je registriran, upiši zapis u tablicu s detaljima
			MembershipUser createdUser = Membership.GetUser(RegisterUser.UserName);

			if (createdUser != null)
			{
				DAL.KorisnikDAC.NoviKorisnik(RegisterUser.UserName);
				createdUser.IsApproved = false;
				Membership.UpdateUser(createdUser);

				Roles.AddUserToRole(RegisterUser.UserName, "ObicanKorisnik");
			}

            //FormsAuthentication.SetAuthCookie(RegisterUser.UserName, createPersistentCookie: false);

			RegisterUser.Visible = false;
			lblPoruka.Text = "Posjetite link koji ste dobili na mail, radi potvrde registracije";

			Log("Registriran korisnik: " + RegisterUser.UserName);

            Common.Email.PosaljiEmail("investiraj@investiraj.net",
                "Novi registrirani korisnik",
                string.Format("Novi korisnik: <strong>{0}</strong> ({1})", RegisterUser.UserName, RegisterUser.Email));

			//string continueUrl = RegisterUser.ContinueDestinationPageUrl;
			//if (!OpenAuth.IsLocalUrl(continueUrl))
			//{
			//	continueUrl = "~/";
			//}

			//PosaljiMailDobrodoslice(RegisterUser.UserName, RegisterUser.Email);

            //Response.Redirect(continueUrl);
        }

		//private void PosaljiMailDobrodoslice(string username, string email)
		//{
		//	var config = DAL.AdminDAC.VratiConfig();

		//	string subject = config.USER_REGISTER_EMAIL_SUBJECT.Replace("#USERNAME#", username);
		//	string body = config.USER_REGISTER_EMAIL_BODY.Replace("#USERNAME#", username);

		//	Common.Email.PosaljiEmail(email, subject, body);
		//}

		protected void RegisterUser_SendingMail(object sender, MailMessageEventArgs e)
		{
			var user = Membership.GetUser(RegisterUser.UserName);

			string verifyUrl = Request.Url.GetLeftPart(UriPartial.Authority) + Page.ResolveUrl("~/Account/Verify.aspx?user=" + user.ProviderUserKey.ToString());

			e.Message.Body = e.Message.Body.Replace("<%VerifyUrl%>", verifyUrl);
		}

		protected void RegisterUser_CreateUserError(object sender, CreateUserErrorEventArgs e)
		{
			Log("Greška kod registracije. Username: " + RegisterUser.UserName + ". Greška: " + e.CreateUserError.ToString());
		}
    }
}