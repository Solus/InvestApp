using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace InvestApp.Common
{
	public enum DokumentMod
	{
		Novi,
		Ispravka
	}

    public enum DatotekaTip
    {
        PDF,
        Slika,
        Doc,
        Ostalo
    }

	public class UpdateCartResult
	{
		public bool Success { get; set; }
		/// <summary>Da li je fond dodan ili uklonjen</summary>
		public bool Removed { get; set; }
		public int Count { get; set; }
		public bool IsFull { get; set; }
	}

	public class PortfeljStruktura
	{
		public string KATEGORIJA { get; set; }
		public decimal VRIJEDNOST { get; set; }
		public decimal POSTOTAK { get; set; }

		public PortfeljStruktura(string kategorija, decimal vrijednost)
		{
			this.KATEGORIJA = kategorija;
			this.VRIJEDNOST = vrijednost;
		}
	}

	public class PortfeljVrijednost
	{
		public DateTime DATUM { get; set; }
		public decimal VRIJEDNOST { get; set; }
		public decimal POSTOTAK { get; set; }

		public PortfeljVrijednost(DateTime datum, decimal vrijednost)
		{
			this.DATUM = datum;
			this.VRIJEDNOST = vrijednost;
		}
	}
}
