using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using InvestApp.Common;
using System.Web.Security;
using System.Web;
using InvestApp.Common;

namespace InvestApp.DAL
{
	public class DAC
	{
		public static void Logiraj(string tekst, Exception ex = null)
		{
			if (ex != null)
			{
				tekst += Environment.NewLine + ex.Message;

				if (ex.InnerException != null)
					tekst += Environment.NewLine + ex.InnerException.Message;
			}

			using (var context = new FondEntities())
			{
				string ip = HttpContext.Current == null ? null : HttpContext.Current.Request.UserHostAddress;
				string userAgent = HttpContext.Current == null ? null : HttpContext.Current.Request.UserAgent;
				string url = HttpContext.Current == null ? null : HttpContext.Current.Request.RawUrl;

				var user = Membership.GetUser(); 

				AplLog log = new AplLog();
				log.VRIJEME = DateTime.Now;
				log.TEKST = tekst;
				log.IP = ip.EnsureMaxLength(50);
				log.USER_AGENT = userAgent;
				log.URL = url.EnsureMaxLength(256);

				if (user != null)
					log.KORISNIK = user.UserName.EnsureMaxLength(256);

				context.AplLogovi.AddObject(log);
				context.SaveChanges();
			}
		}

		public static void ObrisiNovost(int novostID)
		{
			using (var context = new FondEntities())
			{
				var novost = context.Novosti.Single(n => n.ID == novostID);
				
				context.Novosti.DeleteObject(novost);
				context.SaveChanges();
			}
		}
	}
}
