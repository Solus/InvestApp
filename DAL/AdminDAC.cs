using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;

namespace InvestApp.DAL
{
	public class AdminDAC
	{
		public static AdminConfig VratiConfig()
		{
			using (FondEntities context = new FondEntities())
			{
				return context.AdminConfigs.First();
			}
		}

		//public static void SpremiConfig(string registerEmailSubject, string registerEmailBody, string resetEmailSubject, string resetEmailBody)
		//{
		//	using (FondEntities context = new FondEntities())
		//	{
		//		var config = context.AdminConfigs.First();

		//		config.PASSWORD_RESET_EMAIL_SUBJECT = resetEmailSubject;
		//		config.PASSWORD_RESET_EMAIL_BODY = resetEmailBody;
		//		config.USER_REGISTER_EMAIL_SUBJECT = registerEmailSubject;
		//		config.USER_REGISTER_EMAIL_BODY = registerEmailBody;

		//		context.SaveChanges();
		//	}
		//}

		public static Korisnik VratiKorisnika(string username)
		{
			using (FondEntities context = new FondEntities())
			{
				Guid userID = (Guid)Membership.GetUser(username).ProviderUserKey;

				var korisnik = context.Korisnici.SingleOrDefault(k => k.UserId.Equals(userID));

				return korisnik;
			}
		}

		public static void PostaviKorisnikDrustvo(string username, int? drustvoID)
		{
			using (FondEntities context = new FondEntities())
			{
				Guid userID = (Guid)Membership.GetUser(username).ProviderUserKey;

				var korisnik = context.Korisnici.SingleOrDefault(k => k.UserId == userID);

				korisnik.DRUSTVO_ID = drustvoID;

				context.SaveChanges();
			}
		}

		public static int ObrisiKorisnika(Guid userID)
		{
			using (FondEntities context = new FondEntities())
			{
				var korisnik = context.Korisnici.SingleOrDefault(k => k.UserId.Equals(userID));

				context.Korisnici.DeleteObject(korisnik);
				return context.SaveChanges();
			}
		}

	}
}
