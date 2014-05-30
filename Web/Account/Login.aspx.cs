using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class Login : UIControls.InvestAppPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			RegisterHyperLink.NavigateUrl = "Register";
			//OpenAuthLogin.ReturnUrl = Request.QueryString["ReturnUrl"];

			var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
			if (!String.IsNullOrEmpty(returnUrl))
			{
				RegisterHyperLink.NavigateUrl += "?ReturnUrl=" + returnUrl;
			}
		}

		protected void LoginForm_LoggedIn(object sender, EventArgs e)
		{
			Log("Korisnik logiran. Username: " + Login1.UserName);
		}

		protected void Login1_LoginError(object sender, EventArgs e)
		{
			string username = Login1.UserName;

			Log("Neuspješan pokušaj logiranja. Username: " + username);
		}

		//protected void LoginForm_Authenticate(object sender, AuthenticateEventArgs e)
		//{
		//	int? id = DAL.KorisnikDAC.TraziKorisnik(LoginForm.UserName, LoginForm.Password);

		//	if (id != null)
		//		e.Authenticated = true;
		//	else
		//		LoginForm.FailureText = "Nepoznati korisnik";

		//}

	}
}