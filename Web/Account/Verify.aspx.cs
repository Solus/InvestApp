using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace InvestApp.Web
{
	public partial class Verify : UIControls.InvestAppPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Request.QueryString.HasKeys() && Request.QueryString["user"] != null)
				{
					Guid userID = new Guid(Request.QueryString["user"]);

					var user = Membership.GetUser(userID);

					if (user != null)
					{
						user.IsApproved = true;
						Membership.UpdateUser(user);

						Log("Korisnik je potvrdio registraciju. Username: " + user.UserName);

						lblPoruka.Text = "Vaš račun je potvrđen; sad se možete prijaviti na stranicu";
					}
					else
					{
						lblPoruka.Text = "Pogrešan zahtjev";
						Log("Pogrešan Guid kod verifikacije korisnika");
					}
				}
				else
				{
					lblPoruka.Text = "Pogrešan zahtjev";
					Log("Pogrešan link za verifikaciju");
				}
			}
		}
	}
}