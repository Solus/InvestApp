using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using System.Web;

namespace InvestApp.UIControls
{
    public class InvestAppPage : System.Web.UI.Page
    {
		public const string KORISNIK_ID_SESSION = "currKorId";
		public const string KORISNIK_GUID_SESSION = "currKorGuid";

		public int KorisnikID
		{
			get
			{
				if (HttpContext.Current != null && HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)
				{
					Guid userID = (Guid)Membership.GetUser().ProviderUserKey;

					if (Session[KORISNIK_GUID_SESSION] == null || !Session[KORISNIK_GUID_SESSION].Equals(userID.ToString()))
					{
						int? korisnikID = DAL.KorisnikDAC.VratiKorisnikID(userID);

						Session[KORISNIK_ID_SESSION] = korisnikID.HasValue ? korisnikID.Value : (int?)null;
						Session[KORISNIK_GUID_SESSION] = userID.ToString();
					}
				}
				else
				{
					Session[KORISNIK_ID_SESSION] = null;
					Session[KORISNIK_GUID_SESSION] = null;
				}

				return Session[KORISNIK_ID_SESSION] == null ? -1 : Convert.ToInt32(Session[KORISNIK_ID_SESSION]);
			}

			set
			{
				Session[KORISNIK_ID_SESSION] = value;
			}
		}

		public bool KorisnikJeAdmin
		{
			get
			{
				return Roles.IsUserInRole("Admin");
			}
		}

		public bool KorisnikJeDrustvo
		{
			get
			{
				return Roles.IsUserInRole("Drustvo");
			}
		}

		public int? KorisnikDrustvoID
		{
			get
			{
				if (KorisnikID > 0)
				{
					return DAL.KorisnikDAC.VratiKorisnikDrustvoID(KorisnikID);
				}
				else
					return null;
			}
		}

		protected string PorukaText
		{
			get { return Session["portxt"] == null ? "" : (string)Session["portxt"]; }
			set { Session["portxt"] = value; }
		}

		public static void PostaviKorisnikSession(string username = "")
		{
			//if (HttpContext.Current != null)
			//{
			//	MembershipUser user = null;

			//	if (!string.IsNullOrEmpty(username))
			//	{
			//		user = Membership.GetUser(username);
			//	}
			//	else
			//		user = Membership.GetUser();

			//	if (user != null || (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated))
			//	{
			//		Guid userID = (Guid)user.ProviderUserKey;

			//		int? korisnikID = DAL.KorisnikDAC.VratiKorisnikID(userID);

			//		HttpContext.Current.Session[KORISNIK_ID_SESSION] = korisnikID.HasValue ? korisnikID.Value : (int?)null;
			//	}
			//	else
			//		HttpContext.Current.Session[KORISNIK_ID_SESSION] = null;
			//}
		}

		protected static void Log(string tekst, Exception ex = null)
		{
			DAL.DAC.Logiraj(tekst, ex);
		}

        protected override void InitializeCulture()
        {
            base.InitializeCulture();
        }
    }
}
