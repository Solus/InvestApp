using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.Profile;
using Web;
using System.IO;

namespace InvestApp.Web
{
	public class Global : HttpApplication
	{
		void Application_Start(object sender, EventArgs e)
        {
			// Code that runs on application startup
			AuthConfig.RegisterOpenAuth();
			RouteConfig.RegisterRoutes(RouteTable.Routes);

            DAL.DAC.Logiraj("Application Start", noContext: true);
		}

		void Application_End(object sender, EventArgs e)
		{
			//  Code that runs on application shutdown
            DAL.DAC.Logiraj("Application End", noContext: true);
		}

		static T DirectCast<T>(object o) where T : class
		{
			T value = o as T;
			if (value == null && o != null)
			{
				throw new InvalidCastException();
			}
			return value;
		}

		void Application_Error(object sender, EventArgs e)
		{
			// Code that runs when an unhandled error occurs
			var sb = new System.Text.StringBuilder();

            try
            {
                Exception objErr = Server.GetLastError().GetBaseException();
                //                  Server.ClearError();

                sb.Append("Greška u aplikaciji.");
                sb.AppendLine("Error Message: " + objErr.Message.ToString());
                sb.AppendLine("Stack Trace: " + objErr.StackTrace.ToString());

                DAL.DAC.Logiraj(sb.ToString());
            }
            catch (Exception ex)
            {
                string path = HttpContext.Current.Server.MapPath("log.txt");
                using (StreamWriter sw = new StreamWriter(path, true))
                {
                    sw.WriteLine("---------------------------");
                    sw.WriteLine("{0:G}", DateTime.Now);
                    sw.WriteLine("Greška pri logiranju greške. " + sb.ToString());
                    sw.WriteLine(ex.Message);

                    if (ex.InnerException != null)
                        sw.WriteLine(ex.InnerException.Message);
                }
            }

			//if (objErr is System.Reflection.ReflectionTypeLoadException)
			//{
			//	var reflerror = objErr as System.Reflection.ReflectionTypeLoadException;

			//	foreach (var ex in reflerror.LoaderExceptions)
			//		sb.AppendLine(ex.Message);

			//	sb.AppendLine("<b>Source:</b>" + Request.RawUrl);
			//	sb.AppendLine("<br><b>Browser:</b>" + Request.UserAgent);
			//	sb.AppendLine("<br><b>IP:</b>" + Request.UserHostAddress.ToString());
			//	sb.AppendLine("<br><b>UserID:</b>" + User.Identity.Name);
			//	sb.AppendLine("<hr><br><b>Error in: </b>" + Request.Url.ToString());
			//	sb.AppendLine("<br><b>Error Message: </b>" + objErr.Message.ToString());
			//	sb.AppendLine("<br><b>Stack Trace: </b><br>" + objErr.StackTrace.ToString());

			//	Response.Write(sb);
			//}
			//else
			//{
			//	sb.AppendLine("<br><b>Error Message: </b>" + objErr.Message.ToString());
			//	sb.AppendLine("<br><b>Stack Trace: </b><br>" + objErr.StackTrace.ToString());
				
			//	Response.Write(sb);
			//}
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Session_Start(object sender, EventArgs e)
		{
			FondUsporedbaContainer.Init(HttpContext.Current.Session);
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Session_End(Object sender, EventArgs e)
		{
		}

		public void FormsAuthentication_OnAuthenticate(object sender, FormsAuthenticationEventArgs args)
		{
		}

	}
}
