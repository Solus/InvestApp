using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;

namespace InvestApp.Common
{
	public class Email
	{
		public static bool PosaljiEmail(string primateljEmail, string subject, string body, string cc = null, string posiljatelj = null, List<string> privitciUrls = null)
		{
			MailMessage mail = new MailMessage();

			mail.Body = body;
			mail.Subject = subject;
            mail.IsBodyHtml = true;
			mail.To.Add(new MailAddress(primateljEmail));

            if(!string.IsNullOrEmpty(cc))
                mail.CC.Add(new MailAddress(cc));

			if (!string.IsNullOrEmpty(posiljatelj))
				mail.From = new MailAddress(posiljatelj);

            if (privitciUrls != null)
            {
                foreach (var dok in privitciUrls)
                {
                    Attachment att = new Attachment(dok);
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
				//TODO log exception
			}
		}
	}
}
