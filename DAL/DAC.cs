﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using InvestApp.Common;
using System.Web.Security;
using System.Web;

namespace InvestApp.DAL
{
	public class DAC
	{
		public static void Logiraj(string tekst, Exception ex = null, bool noContext = false)
		{
            try
            {
                if (ex != null)
                {
                    tekst += Environment.NewLine + ex.Message;

                    tekst += Environment.NewLine + ex.StackTrace;

                    if (ex.InnerException != null)
                    {
                        tekst += Environment.NewLine + ex.InnerException.Message;
                    }

                    if (ex.InnerException.InnerException != null)
                    {
                        tekst += Environment.NewLine + ex.InnerException.InnerException.Message;
                    }
                }

                using (var context = new FondEntities())
                {
                    AplLog log = new AplLog();
                    log.VRIJEME = DateTime.Now;
                    log.TEKST = tekst;

                    if (!noContext)
                    {
                        string ip = HttpContext.Current == null ? null : HttpContext.Current.Request.UserHostAddress;
                        string userAgent = HttpContext.Current == null ? null : HttpContext.Current.Request.UserAgent;
                        string url = HttpContext.Current == null ? null : HttpContext.Current.Request.RawUrl;

                        var user = Membership.GetUser();

                        log.IP = ip.EnsureMaxLength(50);
                        log.USER_AGENT = userAgent;
                        log.URL = url.EnsureMaxLength(256);

                        if (user != null)
                            log.KORISNIK = user.UserName.EnsureMaxLength(256);
                    }

                    context.AplLogovi.AddObject(log);
                    context.SaveChanges();
                }
            }
            catch (Exception)
            {
                //ne smije doći do greške prilikom logiranja
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
