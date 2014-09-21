using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;
using System.Web.Security;

namespace InvestApp.Common
{
	public class Security
	{
		private const string AVAILABLE_CHARS = "123456789ABCDEFGHJKMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz";

		public static string GenerateToken(int length)
		{
			var rng = new RNGCryptoServiceProvider();
			var random = new byte[length];
			rng.GetNonZeroBytes(random);
			 
			var outputchars = new char[length];
			var usableChars = AVAILABLE_CHARS.ToCharArray();
			var usableLength = usableChars.Length;

			for (int index = 0; index < length; index++)
			{
				outputchars[index] = usableChars[random[index] % usableLength];
			}

			return new string(outputchars);
		}

		public static bool ProvjeriLozinku(string lozinka, out string poruka)
		{
			bool valid = true;
			poruka = "";

			//dužina lozinke
			if (lozinka.Length < Membership.MinRequiredPasswordLength)
				valid = false;

			if (valid)
			{
				int numNonAlphaNumeric = 0;
				foreach (char c in lozinka)
				{
					if (!char.IsLetterOrDigit(c))
						numNonAlphaNumeric++;
				}

				//specijalni znakovi
				if (numNonAlphaNumeric < Membership.MinRequiredNonAlphanumericCharacters)
					valid = false;
			}

			////regex
			//if (valid && !Membership.PasswordStrengthRegularExpression.IsNullOrEmpty())
			//{
			//	if (!Regex.IsMatch(lozinka, Membership.PasswordStrengthRegularExpression))
			//	{
			//		args.IsValid = false;
			//	}
			//}

			poruka = string.Format("Min. dužina lozinke: {0}. Min. br. specijalnih znakova: {1}",
									Membership.MinRequiredPasswordLength,
									Membership.MinRequiredNonAlphanumericCharacters);

			return valid;
		}

        public static bool KorisnikJeAdmin
        {
            get
            {
                return Roles.IsUserInRole("Admin");
            }
        }
	}
}
