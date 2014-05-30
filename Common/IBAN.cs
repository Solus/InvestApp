using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InvestApp.Common
{
	public static class IBAN
	{
		public static void RastaviIBAN(string iban, ref string vbdi, ref string broj_racuna)
		{
			if (iban == null || iban.Length != 21)
				return;

			vbdi = iban.Substring(4, 7);
			broj_racuna = iban.Substring(11);
		}
	}
}
