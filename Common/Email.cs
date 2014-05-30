using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;

namespace InvestApp.Common
{
	public class Email
	{
		public static bool PosaljiEmail(string primateljEmail, string subject, string body, string posiljatelj = null)
		{
			MailMessage mail = new MailMessage();

			mail.Body = body;
			mail.Subject = subject;
			mail.To.Add(new MailAddress(primateljEmail));
			mail.IsBodyHtml = true;

			if (!string.IsNullOrEmpty(posiljatelj))
				mail.From = new MailAddress(posiljatelj);

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
