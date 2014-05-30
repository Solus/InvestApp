using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Security;
using InvestApp.Common;

namespace InvestApp.DAL
{
	public class KorisnikDAC
	{
		public static int NoviKorisnik(string username)
		{
			var user = Membership.GetUser(username);

			if (user == null)
				return -1;

			Guid userID = (Guid)user.ProviderUserKey;

			using (FondEntities ctx = new FondEntities())
			{
				var korisnik = new Korisnik();
				korisnik.UserId = userID;
				korisnik.USER_NAME = username;
				korisnik.PRAVNA = "F";
				korisnik.REZIDENTNOST = "R";
				korisnik.KONTAKT_EMAIL = user.Email;

				ctx.Korisnici.AddObject(korisnik);

				return ctx.SaveChanges();
			}
		}

		public static int? TraziKorisnikID(string userName, string password)
		{
			using (FondEntities ctx = new FondEntities())
			{
				var korisnik = ctx.Korisnici.SingleOrDefault(k => k.USER_NAME == userName && k.PASSWORD == password);

				if (korisnik == null)
					return null;
				else
					return korisnik.ID;
			}
		}

		public static int? VratiKorisnikID(Guid userID)
		{
			using (FondEntities context = new FondEntities())
			{
				var korisnik = context.Korisnici.SingleOrDefault(k => k.UserId == userID);

				return korisnik == null ? (int?)null : korisnik.ID;
			}
		}

		public static int? VratiKorisnikDrustvoID(int korisnikID)
		{
			using (FondEntities context = new FondEntities())
			{
				var korisnik = context.Korisnici.SingleOrDefault(k => k.ID == korisnikID);

				return korisnik == null ? (int?)null : korisnik.DRUSTVO_ID;
			}
		}

		#region Password reset

		public static bool PasswordRequestValjan(string username, string request)
		{
			using (var context = new FondEntities())
			{
				var user = Membership.GetUser(username);

				if (user == null)
					return false;
				else
				{
					Guid userID = (Guid)user.ProviderUserKey;

					var korisnik = context.Korisnici.SingleOrDefault(k => k.UserId.Equals(userID) && k.PASSWORD_RESET_TOKEN.Equals(request) && k.PASSWORD_RESET_VRIJEDI_DO >= DateTime.Now);

					return korisnik != null;
				}
			}
		}

		public static void ObrisiPasswordRequest(string username)
		{
			using (var context = new FondEntities())
			{
				var userID = (Guid)Membership.GetUser(username).ProviderUserKey;

				var korisnik = context.Korisnici.SingleOrDefault(k => k.UserId.Equals(userID));

				korisnik.PASSWORD_RESET_TOKEN = null;
				korisnik.PASSWORD_RESET_VRIJEDI_DO = null;

				context.SaveChanges();
			}
		}

		public static string PostaviPasswordResetZahtjev(string username)
		{
			using (var context = new FondEntities())
			{
				var user = Membership.GetUser(username);

				if (user != null)
				{
					var userID = (Guid)user.ProviderUserKey;
					var korisnik = context.Korisnici.SingleOrDefault(k => k.UserId.Equals(userID));

					if (korisnik != null)
					{
						string resetToken = Common.Security.GenerateToken(16);
						DateTime resetVrijediDo = DateTime.Now.AddDays(1);

						korisnik.PASSWORD_RESET_TOKEN = resetToken;
						korisnik.PASSWORD_RESET_VRIJEDI_DO = resetVrijediDo;

						context.SaveChanges();

						return resetToken;
					}
				}

				return null;
			}
		}

		#endregion Password reset

		public static void ToggleFondFavorit(int korisnikID, int fondID)
		{
			using (FondEntities context = new FondEntities())
			{
				var korisnik = context.Korisnici.SingleOrDefault(k => k.ID == korisnikID);

				var fond = context.Fondovi.Single(f => f.ID == fondID);

				if (korisnik.FondFavoriti.Any(f => f.ID == fondID)) //ako je favorit, ukloni ga
					korisnik.FondFavoriti.Remove(fond);
				else //ako nije, dodaj
					korisnik.FondFavoriti.Add(fond);

				context.SaveChanges();
			}
		}

		/// <summary>
		/// Jesi li podaci promijenjeni u odnosu na zadanom korisnika
		/// </summary>
		public static bool KorisnikPromijenjeniPodaci(int korisnikID, Korisnik korisnikUsporedba)
		{
			using (FondEntities context = new FondEntities())
			{
				var k = context.Korisnici.Single(kor => kor.ID == korisnikID);

				bool promijenjeno =
					Utility.StringPromijenjen(k.PRAVNA, korisnikUsporedba.PRAVNA) ||
					Utility.StringPromijenjen(k.REZIDENTNOST, korisnikUsporedba.REZIDENTNOST);

				if (!promijenjeno)
				{
					if (k.IsPravna)
					{
						promijenjeno =
							Utility.StringPromijenjen(k.IME, korisnikUsporedba.IME) ||
							Utility.StringPromijenjen(k.MB, korisnikUsporedba.MB) ||
							Utility.StringPromijenjen(k.OIB, korisnikUsporedba.OIB) ||
							Utility.StringPromijenjen(k.ADRESA_ULICA, korisnikUsporedba.ADRESA_ULICA) ||
							Utility.StringPromijenjen(k.ADRESA_KUCNI_BROJ, korisnikUsporedba.ADRESA_KUCNI_BROJ) ||
							Utility.StringPromijenjen(k.ADRESA_POSTANSKI_BROJ, korisnikUsporedba.ADRESA_POSTANSKI_BROJ) ||
							Utility.StringPromijenjen(k.ADRESA_MJESTO, korisnikUsporedba.ADRESA_MJESTO) ||
							Utility.StringPromijenjen(k.ADRESA_DRZAVA, korisnikUsporedba.ADRESA_DRZAVA) ||
							//kontakt
							Utility.StringPromijenjen(k.TELEFON, korisnikUsporedba.TELEFON) ||
							Utility.StringPromijenjen(k.MOBITEL, korisnikUsporedba.MOBITEL) ||
							Utility.StringPromijenjen(k.FAX, korisnikUsporedba.FAX) ||
							Utility.StringPromijenjen(k.KONTAKT_EMAIL, korisnikUsporedba.KONTAKT_EMAIL) ||
							//podaci fizičke osobe
							Utility.StringPromijenjen(k.ZASTUPNIK_IME, korisnikUsporedba.ZASTUPNIK_IME) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_PREZIME, korisnikUsporedba.ZASTUPNIK_PREZIME) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_JMBG, korisnikUsporedba.ZASTUPNIK_JMBG) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_OIB, korisnikUsporedba.ZASTUPNIK_OIB) ||
							//prebivalište
							Utility.StringPromijenjen(k.ZASTUPNIK_ADRESA_ULICA, korisnikUsporedba.ZASTUPNIK_ADRESA_ULICA) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_ADRESA_KUCNI_BROJ, korisnikUsporedba.ZASTUPNIK_ADRESA_KUCNI_BROJ) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_ADRESA_P_BROJ, korisnikUsporedba.ZASTUPNIK_ADRESA_P_BROJ) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_ADRESA_MJESTO, korisnikUsporedba.ZASTUPNIK_ADRESA_MJESTO) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_ADRESA_DRZAVA, korisnikUsporedba.ZASTUPNIK_ADRESA_DRZAVA) ||
							//kontakt
							Utility.StringPromijenjen(k.ZASTUPNIK_TELEFON, korisnikUsporedba.ZASTUPNIK_TELEFON) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_MOBITEL, korisnikUsporedba.ZASTUPNIK_MOBITEL) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_FAX, korisnikUsporedba.ZASTUPNIK_FAX) ||
							Utility.StringPromijenjen(k.ZASTUPNIK_EMAIL, korisnikUsporedba.ZASTUPNIK_EMAIL) ||
							Utility.StringPromijenjen(k.PRAVNA_PLANIRANA_GOD_ULAGANJA, korisnikUsporedba.PRAVNA_PLANIRANA_GOD_ULAGANJA) ||
							Utility.StringPromijenjen(k.PRAVNA_VLASNISTVO_PODIJELJENO, korisnikUsporedba.PRAVNA_VLASNISTVO_PODIJELJENO);
					}
					else //fizička
					{
						promijenjeno =
							Utility.StringPromijenjen(k.IME, korisnikUsporedba.IME) ||
							Utility.StringPromijenjen(k.PREZIME, korisnikUsporedba.PREZIME) ||
							Utility.StringPromijenjen(k.MB, korisnikUsporedba.MB) ||
							Utility.StringPromijenjen(k.OIB, korisnikUsporedba.OIB) ||
							//prebivalište
							Utility.StringPromijenjen(k.ADRESA_ULICA, korisnikUsporedba.ADRESA_ULICA) ||
							Utility.StringPromijenjen(k.ADRESA_KUCNI_BROJ, korisnikUsporedba.ADRESA_KUCNI_BROJ) ||
							Utility.StringPromijenjen(k.ADRESA_POSTANSKI_BROJ, korisnikUsporedba.ADRESA_POSTANSKI_BROJ) ||
							Utility.StringPromijenjen(k.ADRESA_MJESTO, korisnikUsporedba.ADRESA_MJESTO) ||
							Utility.StringPromijenjen(k.ADRESA_DRZAVA, korisnikUsporedba.ADRESA_DRZAVA) ||
							//kontakt
							Utility.StringPromijenjen(k.TELEFON, korisnikUsporedba.TELEFON) ||
							Utility.StringPromijenjen(k.MOBITEL, korisnikUsporedba.MOBITEL) ||
							Utility.StringPromijenjen(k.FAX, korisnikUsporedba.FAX) ||
							Utility.StringPromijenjen(k.KONTAKT_EMAIL, korisnikUsporedba.KONTAKT_EMAIL) ||
							Utility.StringPromijenjen(k.FIZICKA_STATUS_ODABIR, korisnikUsporedba.FIZICKA_STATUS_ODABIR) ||
							Utility.StringPromijenjen(k.FIZICKA_VRSTA_POSLODAVCA, korisnikUsporedba.FIZICKA_VRSTA_POSLODAVCA) ||
							Utility.StringPromijenjen(k.FIZICKA_STRUCNA_SPREMA, korisnikUsporedba.FIZICKA_STRUCNA_SPREMA) ||
							Utility.StringPromijenjen(k.FIZICKA_ZVANJE, korisnikUsporedba.FIZICKA_ZVANJE) ||
							Utility.StringPromijenjen(k.FIZICKA_ZANIMANJE, korisnikUsporedba.FIZICKA_ZANIMANJE) ||
							Utility.StringPromijenjen(k.FIZICKA_PLANIRANA_GOD_ULAGANJA, korisnikUsporedba.FIZICKA_PLANIRANA_GOD_ULAGANJA) ||
							Utility.StringPromijenjen(k.FIZICKA_SREDSTVA_OSTVARENA, korisnikUsporedba.FIZICKA_SREDSTVA_OSTVARENA) ||
							Utility.StringPromijenjen(k.FIZICKA_POLITICKA_IZLOZENOST, korisnikUsporedba.FIZICKA_POLITICKA_IZLOZENOST);
					}
				}

				if (!promijenjeno)
				{
					promijenjeno =
						Utility.StringPromijenjen(k.FIZICKA_DOKUMENT_TIP, korisnikUsporedba.FIZICKA_DOKUMENT_TIP) ||
						Utility.StringPromijenjen(k.FIZICKA_DOKUMENT_BROJ, korisnikUsporedba.FIZICKA_DOKUMENT_BROJ) ||
						Utility.StringPromijenjen(k.FIZICKA_DOKUMENT_IZDAVATELJ, korisnikUsporedba.FIZICKA_DOKUMENT_IZDAVATELJ) ||
						Utility.DatumPromijenjen(k.FIZICKA_DOKUMENT_VRIJEDI_DO, korisnikUsporedba.FIZICKA_DOKUMENT_VRIJEDI_DO) ||
						//rođenje
						Utility.DatumPromijenjen(k.FIZICKA_DATUM_RODENJA, korisnikUsporedba.FIZICKA_DATUM_RODENJA) ||
						Utility.StringPromijenjen(k.FIZICKA_MJESTO_RODENJA, korisnikUsporedba.FIZICKA_MJESTO_RODENJA) ||
						Utility.StringPromijenjen(k.FIZICKA_DRZAVA_RODENJA, korisnikUsporedba.FIZICKA_DRZAVA_RODENJA) ||
						Utility.StringPromijenjen(k.FIZICKA_DRZAVLJANSTVO, korisnikUsporedba.FIZICKA_DRZAVLJANSTVO) ||
						//adresa za slanje
						Utility.StringPromijenjen(k.ADRESA_SLANJE_ULICA, korisnikUsporedba.ADRESA_SLANJE_ULICA) ||
						Utility.StringPromijenjen(k.ADRESA_SLANJE_KUCNI_BROJ, korisnikUsporedba.ADRESA_SLANJE_KUCNI_BROJ) ||
						Utility.StringPromijenjen(k.ADRESA_SLANJE_POSTANSKI_BROJ, korisnikUsporedba.ADRESA_SLANJE_POSTANSKI_BROJ) ||
						Utility.StringPromijenjen(k.ADRESA_SLANJE_MJESTO, korisnikUsporedba.ADRESA_SLANJE_MJESTO) ||
						Utility.StringPromijenjen(k.ADRESA_SLANJE_DRZAVA, korisnikUsporedba.ADRESA_SLANJE_DRZAVA) ||
						//ostalo
						Utility.StringPromijenjen(k.RACUN_VBDI, korisnikUsporedba.RACUN_VBDI) ||
						Utility.StringPromijenjen(k.RACUN_BROJ, korisnikUsporedba.RACUN_BROJ);
				}

				return promijenjeno;
			}

		}

		public static void KorisnikAzuriraj(int korisnikID, Korisnik korisnikUsporedba)
		{
			using (FondEntities context = new FondEntities())
			{
				var k = context.Korisnici.Single(kor => kor.ID == korisnikID);

				k.PRAVNA = korisnikUsporedba.PRAVNA;
				k.REZIDENTNOST = korisnikUsporedba.REZIDENTNOST;

				if (k.IsPravna)
				{
					k.IME = Utility.NormalizeString(korisnikUsporedba.IME);
					k.MB = Utility.NormalizeString(korisnikUsporedba.MB);
					k.OIB = Utility.NormalizeString(korisnikUsporedba.OIB);
					k.ADRESA_ULICA = Utility.NormalizeString(korisnikUsporedba.ADRESA_ULICA);
					k.ADRESA_KUCNI_BROJ = Utility.NormalizeString(korisnikUsporedba.ADRESA_KUCNI_BROJ);
					k.ADRESA_POSTANSKI_BROJ = Utility.NormalizeString(korisnikUsporedba.ADRESA_POSTANSKI_BROJ);
					k.ADRESA_MJESTO = Utility.NormalizeString(korisnikUsporedba.ADRESA_MJESTO);
					k.ADRESA_DRZAVA = Utility.NormalizeString(korisnikUsporedba.ADRESA_DRZAVA);
					//kontakt
					k.TELEFON = Utility.NormalizeString(korisnikUsporedba.TELEFON);
					k.MOBITEL = Utility.NormalizeString(korisnikUsporedba.MOBITEL);
					k.FAX = Utility.NormalizeString(korisnikUsporedba.FAX);
					k.KONTAKT_EMAIL = Utility.NormalizeString(korisnikUsporedba.KONTAKT_EMAIL);
					//podaci fizičke osobe
					k.ZASTUPNIK_IME = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_IME);
					k.ZASTUPNIK_PREZIME = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_PREZIME);
					k.ZASTUPNIK_JMBG = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_JMBG);
					k.ZASTUPNIK_OIB = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_OIB);
					//prebivalište
					k.ZASTUPNIK_ADRESA_ULICA = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_ADRESA_ULICA);
					k.ZASTUPNIK_ADRESA_KUCNI_BROJ = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_ADRESA_KUCNI_BROJ);
					k.ZASTUPNIK_ADRESA_P_BROJ = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_ADRESA_P_BROJ);
					k.ZASTUPNIK_ADRESA_MJESTO = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_ADRESA_MJESTO);
					k.ZASTUPNIK_ADRESA_DRZAVA = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_ADRESA_DRZAVA);
					//kontakt
					k.ZASTUPNIK_TELEFON = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_TELEFON);
					k.ZASTUPNIK_MOBITEL = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_MOBITEL);
					k.ZASTUPNIK_FAX = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_FAX);
					k.ZASTUPNIK_EMAIL = Utility.NormalizeString(korisnikUsporedba.ZASTUPNIK_EMAIL);
					k.PRAVNA_PLANIRANA_GOD_ULAGANJA = Utility.NormalizeString(korisnikUsporedba.PRAVNA_PLANIRANA_GOD_ULAGANJA);
					k.PRAVNA_VLASNISTVO_PODIJELJENO = Utility.NormalizeString(korisnikUsporedba.PRAVNA_VLASNISTVO_PODIJELJENO);
				}
				else //fizička
				{
					k.IME = Utility.NormalizeString(korisnikUsporedba.IME);
					k.PREZIME = Utility.NormalizeString(korisnikUsporedba.PREZIME);
					k.MB = Utility.NormalizeString(korisnikUsporedba.MB);
					k.OIB = Utility.NormalizeString(korisnikUsporedba.OIB);
					//prebivalište
					k.ADRESA_ULICA = Utility.NormalizeString(korisnikUsporedba.ADRESA_ULICA);
					k.ADRESA_KUCNI_BROJ = Utility.NormalizeString(korisnikUsporedba.ADRESA_KUCNI_BROJ);
					k.ADRESA_POSTANSKI_BROJ = Utility.NormalizeString(korisnikUsporedba.ADRESA_POSTANSKI_BROJ);
					k.ADRESA_MJESTO = Utility.NormalizeString(korisnikUsporedba.ADRESA_MJESTO);
					k.ADRESA_DRZAVA = Utility.NormalizeString(korisnikUsporedba.ADRESA_DRZAVA);
					//kontakt
					k.TELEFON = Utility.NormalizeString(korisnikUsporedba.TELEFON);
					k.MOBITEL = Utility.NormalizeString(korisnikUsporedba.MOBITEL);
					k.FAX = Utility.NormalizeString(korisnikUsporedba.FAX);
					k.KONTAKT_EMAIL = Utility.NormalizeString(korisnikUsporedba.KONTAKT_EMAIL);
					k.FIZICKA_STATUS_ODABIR = Utility.NormalizeString(korisnikUsporedba.FIZICKA_STATUS_ODABIR);
					k.FIZICKA_VRSTA_POSLODAVCA = Utility.NormalizeString(korisnikUsporedba.FIZICKA_VRSTA_POSLODAVCA);
					k.FIZICKA_STRUCNA_SPREMA = Utility.NormalizeString(korisnikUsporedba.FIZICKA_STRUCNA_SPREMA);
					k.FIZICKA_ZVANJE = Utility.NormalizeString(korisnikUsporedba.FIZICKA_ZVANJE);
					k.FIZICKA_ZANIMANJE = Utility.NormalizeString(korisnikUsporedba.FIZICKA_ZANIMANJE);
					k.FIZICKA_PLANIRANA_GOD_ULAGANJA = Utility.NormalizeString(korisnikUsporedba.FIZICKA_PLANIRANA_GOD_ULAGANJA);
					k.FIZICKA_SREDSTVA_OSTVARENA = Utility.NormalizeString(korisnikUsporedba.FIZICKA_SREDSTVA_OSTVARENA);
					k.FIZICKA_POLITICKA_IZLOZENOST = Utility.NormalizeString(korisnikUsporedba.FIZICKA_POLITICKA_IZLOZENOST);
				}
				k.FIZICKA_DOKUMENT_TIP = Utility.NormalizeString(korisnikUsporedba.FIZICKA_DOKUMENT_TIP);
				k.FIZICKA_DOKUMENT_BROJ = Utility.NormalizeString(korisnikUsporedba.FIZICKA_DOKUMENT_BROJ);
				k.FIZICKA_DOKUMENT_IZDAVATELJ = Utility.NormalizeString(korisnikUsporedba.FIZICKA_DOKUMENT_IZDAVATELJ);
				k.FIZICKA_DOKUMENT_VRIJEDI_DO = korisnikUsporedba.FIZICKA_DOKUMENT_VRIJEDI_DO;
				//rođenje
				k.FIZICKA_DATUM_RODENJA = korisnikUsporedba.FIZICKA_DATUM_RODENJA;
				k.FIZICKA_MJESTO_RODENJA = Utility.NormalizeString(korisnikUsporedba.FIZICKA_MJESTO_RODENJA);
				k.FIZICKA_DRZAVA_RODENJA = Utility.NormalizeString(korisnikUsporedba.FIZICKA_DRZAVA_RODENJA);
				k.FIZICKA_DRZAVLJANSTVO = Utility.NormalizeString(korisnikUsporedba.FIZICKA_DRZAVLJANSTVO);
				//adresa za slanje
				k.ADRESA_SLANJE_ULICA = Utility.NormalizeString(korisnikUsporedba.ADRESA_SLANJE_ULICA);
				k.ADRESA_SLANJE_KUCNI_BROJ = Utility.NormalizeString(korisnikUsporedba.ADRESA_SLANJE_KUCNI_BROJ);
				k.ADRESA_SLANJE_POSTANSKI_BROJ = Utility.NormalizeString(korisnikUsporedba.ADRESA_SLANJE_POSTANSKI_BROJ);
				k.ADRESA_SLANJE_MJESTO = Utility.NormalizeString(korisnikUsporedba.ADRESA_SLANJE_MJESTO);
				k.ADRESA_SLANJE_DRZAVA = Utility.NormalizeString(korisnikUsporedba.ADRESA_SLANJE_DRZAVA);
				//ostalo
				k.RACUN_VBDI = Utility.NormalizeString(korisnikUsporedba.RACUN_VBDI);
				k.RACUN_BROJ = Utility.NormalizeString(korisnikUsporedba.RACUN_BROJ);

				context.SaveChanges();
			}

		}

	}
}
