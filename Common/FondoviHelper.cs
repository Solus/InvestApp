using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InvestApp.Common
{
    public static class FondoviHelper
    {
        public enum Kategorija
        {
            NOVCANI = 1,
            OBVEZNICKI = 2,
            MJESOVITI = 3,
            DIONICKI = 4
        }

        public enum Regija
        {
            Globalni = 1,
            Regionalni = 2,
            JednaDrzava = 3
        }

        public enum Ulaganje
        {
            FondFondova = 1,
            DirektnoUlaganje = 2
        }

        public enum Upravljanje
        {
            Aktivno = 1,
            Pasivno = 2
        }

		public enum StrukturaUlaganjaTip
		{
			Top10,
			GeografskaIzlozenost,
			SektorskaIzlozenost,
			ValutnaIzlozenost,
			None
		}

		///// <summary>
		///// Vraća ID kategorije prema nazivu
		///// </summary>
		//public static int? KategorijaNazivToID(string naziv)
		//{
		//	switch (naziv)
		//	{
		//		case "DIONICKI":
		//			return (int)Kategorija.DIONICKI;
		//		case "MJESOVITI":
		//			return (int)Kategorija.MJESOVITI;
		//		case "OBVEZNICKI":
		//			return (int)Kategorija.OBVEZNICKI;
		//		case "NOVCANI":
		//			return (int)Kategorija.NOVCANI;
		//		default:
		//			return null;
		//	}
		//}

		///// <summary>
		///// Vraća ID regije prema nazivu
		///// </summary>
		//public static int? RegijaNazivToID(string naziv)
		//{
		//	switch (naziv)
		//	{
		//		case "GLOBALNI":
		//			return (int)Regija.Globalni;
		//		case "REGIONALNI":
		//			return (int)Regija.Regionalni;
		//		case "JEDNA_DRZAVA":
		//			return (int)Regija.JednaDrzava;
		//		default:
		//			return null;
		//	}
		//}

		///// <summary>
		///// Vraća ID ulaganja prema nazivu
		///// </summary>
		//public static int? UlaganjeNazivToID(string naziv)
		//{
		//	switch (naziv)
		//	{
		//		case "FOND_FONDOVA":
		//			return (int)Ulaganje.FondFondova;
		//		case "DIREKTNO_ULAGANJE":
		//			return (int)Ulaganje.DirektnoUlaganje;
		//		default:
		//			return null;
		//	}
		//}

		///// <summary>
		///// Vraća ID upravljanja prema nazivu
		///// </summary>
		//public static int? UpravljanjeNazivToID(string naziv)
		//{
		//	switch (naziv)
		//	{
		//		case "AKTIVNO":
		//			return (int)Upravljanje.Aktivno;
		//		case "PASIVNO":
		//			return (int)Upravljanje.Pasivno;
		//		default:
		//			return null;
		//	}
		//}

		#region Dodatni podaci

		public static string PravnaPlaniranaGodUlaganjaNaziv(string value)
		{
			switch (value)
			{
				case "1": return "do 100.000,00 kn";
				case "2": return "100.001 kn do 500.000 kn";
				case "3": return "500.001 kn do 1.000.000 kn";
				case "4": return "1.000.001 kn do 4.000.000 kn";
				case "5": return "iznad 4.000.000,00 kn";
				default:
					return "";
			}
		}

		public static string FizickaPlaniranaGodUlaganja(string value)
		{
			switch (value)
			{
				case "1": return "do 50.000,00 kn";
				case "2": return "50.001 kn do 200.000 kn";
				case "3": return "200.001 kn do 500.000 kn";
				case "4": return "500.001 kn do 1.000.000 kn";
				case "5": return "iznad 1.000.000,00 kn";
				default:
					return "";
			}
		}

		public static string DokumentTipNaziv(string tip)
		{
			switch (tip)
			{
				case "o": return "Osobna iskaznica";
				case "p": return "Putovnica";
				default:
					return "";
			}
		}

		public static string FizickaStatusNaziv(string tip)
		{
			switch (tip)
			{
				case "z": return "zaposlenik";
				case "p": return "poduzetnik";
				case "n": return "nezaposlen";
				case "u": return "umirovljenik";
				case "s": return "student/učenik";
				case "o": return "ostalo";
				default:
					return "";
			}
		}

		public static string FizickaVrstaPoslodavcaNaziv(string tip)
		{
			switch (tip)
			{
				case "ps": return "privatni sektor";
				case "ds": return "državna služba";
				case "td": return "tijela državne/regionalne vlasti";
				case "dt": return "državna trgovačka društva";
				case "os": return "ostalo(nezaposleni, umirovljenici)";
				default:
					return "";
			}
		}

		public static string FizickaStrucnaSpremaNaziv(string tip)
		{
			switch (tip)
			{
				case "NKV": return "NKV";
				case "NSS": return "NSS (KV,NSS)";
				case "KV": return "KV";
				case "SSS": return "SSS";
				case "VKV": return "VKV";
				case "VŠS": return "VŠS";
				case "VSS": return "VSS";
				case "VSS-MR": return "VSS-MR";
				case "VSS-DR": return "VSS-DR";
				default:
					return "";
			}
		}

		public static string FizickaSredstvaOstvarenaNaziv(string tip)
		{
			switch (tip)
			{
				case "1": return "dohotka od redovne plaće - nesamostalni rad";
				case "2": return "dohotka od samostalne djelatnosti";
				case "3": return "dohotka od imovine i imovinskih prava";
				case "4": return "dohotka od kapitala";
				case "5": return "izvanrednih prihoda";
				case "6": return "ostalog (stipendije, nasljedstva, naknade i sl)";
				default:
					return "";
			}
		}

		public static string StrukturaUlaganjaOznaka(StrukturaUlaganjaTip tip)
		{
			switch (tip)
			{
				case StrukturaUlaganjaTip.Top10: return "T";
				case StrukturaUlaganjaTip.GeografskaIzlozenost: return "G";
				case StrukturaUlaganjaTip.SektorskaIzlozenost: return "S";
				case StrukturaUlaganjaTip.ValutnaIzlozenost: return "V";
				default: return "";
			}
		}

		public static string StrukturaUlaganjaNaslov(StrukturaUlaganjaTip tip)
		{
			switch (tip)
			{
				case StrukturaUlaganjaTip.Top10: return "Top 10 ulaganja";
				case StrukturaUlaganjaTip.GeografskaIzlozenost: return "Geografska struktura";
				case StrukturaUlaganjaTip.SektorskaIzlozenost: return "Sektorska izloženost";
				case StrukturaUlaganjaTip.ValutnaIzlozenost: return "Valutna izloženost";
				default: return "";
			}
		}

		#endregion
	}

	public class FondZahtjevHelper
	{
		public enum Tip
		{
			Kupnja,
			Prodaja,
			None
		}

		public enum Status
		{
			Podnesen,
			Realiziran,
			None
		}

		public static string TipNaziv(string tip)
		{
			switch (tip)
			{
				case "K": return "Kupnja";
				case "P": return "Prodaja";
				default: return "";
			}
		}

		public static Tip TipIzOznake(string tip)
		{
			switch (tip)
			{
				case "K": return Tip.Kupnja;
				case "P": return Tip.Prodaja;
				default: return Tip.None;
			}
		}

		public static string TipOznaka(Tip tip)
		{
			switch (tip)
			{
				case Tip.Kupnja: return "K";
				case Tip.Prodaja: return "P";
				default: return null;
			}
		}

		public static Status StatusIzOznake(string statusOznaka)
		{
			switch (statusOznaka)
			{
				case "UN": return Status.Podnesen;
				case "OB": return Status.Realiziran;
				default: return Status.None;
			}
		}

		public static string StatusNaziv(string statusOznaka)
		{
			switch (statusOznaka)
			{
				case "UN": return "Podnesen";
				case "OB": return "Realiziran";
				default: return "";
			}
		}

		public static string StatusOznaka(Status statusTip)
		{
			switch (statusTip)
			{
				case Status.Podnesen: return "UN";
				case Status.Realiziran: return "OB";
				default: return null;
			}
		}

	}
}
