using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;
using System.Web;

namespace InvestApp.Common
{
	public class Email
	{
		public static bool PosaljiEmail(string primateljEmail, string subject, string body, string[] cc = null, string posiljatelj = null, List<string> privitciUrls = null)
		{
			MailMessage mail = new MailMessage();

			mail.Body = body;
			mail.Subject = subject;
            mail.IsBodyHtml = true;
			mail.To.Add(new MailAddress(primateljEmail));

            if (cc != null)
            {
                foreach (var c in cc)
                {
                    if (!string.IsNullOrEmpty(c))
                        mail.CC.Add(new MailAddress(c));
                }
            }

			if (!string.IsNullOrEmpty(posiljatelj))
				mail.From = new MailAddress(posiljatelj);

            if (privitciUrls != null)
            {
                foreach (var dok in privitciUrls)
                {
                    if (string.IsNullOrEmpty(dok))
                        continue;

                    string file = System.IO.Path.IsPathRooted(dok) ? dok : HttpContext.Current.Server.MapPath(dok);

                    if (!System.IO.File.Exists(file))
                        continue;

                    Attachment att = new Attachment(file);
                    mail.Attachments.Add(att);
                }
            }

			var smtp = new SmtpClient();
			try
			{
				smtp.Send(mail);
				return true;
			}
			catch (SmtpException)
			{
                return false;
			}
		}
	}
}
