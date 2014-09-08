using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using InvestApp.Common;

namespace InvestApp.DAL
{
    public class FondDAC
    {
		public static List<Drustvo> VratiDrustva()
		{
			using (var context = new FondEntities())
			{
				return context.Drustva.OrderBy(d=>d.NAZIV).ToList();
			}
		}

        public static ICollection<Fond> VratiFondove(bool dodatniZapisZaSve = false, string dodatniZapisText = null, int? drustvoID = null, bool prikaziSakrivene = false)
        {
            using (var context = new FondEntities())
            {
                var fondovi = context.Fondovi
                    .Where(f =>
                        (!drustvoID.HasValue || f.DRUSTVA_ID == drustvoID) &&
                        (!f.SAKRIVENI.HasValue || f.SAKRIVENI == false || prikaziSakrivene)
                        )
                    .OrderBy(f => f.NAZIV).ToList();

                if (dodatniZapisZaSve)
                {
                    var fondSvi = new DAL.Fond();
                    fondSvi.NAZIV = dodatniZapisText ?? "--Svi--";
                    fondSvi.ID = -1;
                    fondovi.Insert(0, fondSvi);
                }

                return fondovi;
            }
        }

		public static ICollection<Fond> VratiSlicneFondove(int fondID)
		{
			using (var context = new FondEntities())
			{
				var fond = context.Fondovi.Single(f => f.ID == fondID);

				if (fond.GRUPE.IsNullOrEmpty())
					return null;
				else
				{
					char[] grupe = fond.GRUPE.ToCharArray();

					var fondovi = context.Fondovi.Where(f => f.ID != fondID).ToList();
					var slicniFondovi = fondovi.FindAll(f => !string.IsNullOrEmpty(f.GRUPE) && f.GRUPE.IndexOfAny(grupe) != -1);

					return slicniFondovi;
				}
			}
		}

        public static Fond VratiFond(int id)
        {
            using (var context = new FondEntities())
            {
                return context.Fondovi.Include("Kategorija").Include("Drustvo").FirstOrDefault(f => f.ID == id);
            }
        }

		public static string VratiFondNaziv(int id)
		{
			using (var context = new FondEntities())
			{
				var fond = context.Fondovi.FirstOrDefault(f => f.ID == id);

				return fond == null ? "" : fond.NAZIV;
			}
		}

        public static IEnumerable<TraziFondove_Result> TraziFondove(int? kategorijaID, int? regijaID, int? ulaganjeTipID, int? upravljanjeTipID, int? ciljPrinosaID, int? sektorID, int? trzisteID, int? profilRizicnostiID, int? korisnikID, bool prikaziSakrivene, bool? prikaziIndeksni)
        {
            using (var context = new FondEntities())
            {
                var fondovi = context.TraziFondove(null, DateTime.Today, null, kategorijaID, null, null, regijaID, ulaganjeTipID, upravljanjeTipID, ciljPrinosaID, sektorID, trzisteID, profilRizicnostiID, korisnikID, prikaziSakrivene, prikaziIndeksni);

                return fondovi.ToList();
            }
        }

		public static IEnumerable<TraziFondove_Result> VratiFondPrinose(List<int> fondIDs)
		{
			var fondovi = new List<TraziFondove_Result>();

			using (var context = new FondEntities())
			{
				foreach (int id in fondIDs)
				{
					var fond = context.TraziFondove(id, DateTime.Today, null, null, null, null, null, null, null, null, null, null, null, null, null, null).ToList();

					if (fond != null && fond.Count == 1)
						fondovi.Add(fond[0]);
				}

				return fondovi.Any() ? fondovi.OrderBy(f=>f.NAZIV) : null;
			}
		}

		public static DAL.StrukturaUlaganjaZaglavlje VratiFondStrukturaUlaganja(int fondID, FondoviHelper.StrukturaUlaganjaTip tip, DateTime datum)
		{
			using (var context = new FondEntities())
			{
				string tipOznaka = FondoviHelper.StrukturaUlaganjaOznaka(tip);

				return context.StruktureUlaganjaZaglavlje.Include("Detalji")
					.SingleOrDefault(s => 
						s.FOND_ID == fondID && 
						s.TIP == tipOznaka &&
						s.DATUM_OD <= datum &&
						(!s.DATUM_DO.HasValue || s.DATUM_DO >= datum)
						);

			}
		}

		public static int? VratiIliKreirajFondStruktura(int fondID, FondoviHelper.StrukturaUlaganjaTip tip, DateTime datum)
		{
			int? struktID = VratiFondStrukturaUlaganjaID(fondID, tip, datum);

			if (!struktID.HasValue)
				struktID = KreirajFondStrukturaUlaganja(fondID, tip, datum);

			return struktID;
		}

		private static int? VratiFondStrukturaUlaganjaID(int fondID, FondoviHelper.StrukturaUlaganjaTip tip, DateTime datum)
		{
			using (var context = new FondEntities())
			{
				string tipOznaka = FondoviHelper.StrukturaUlaganjaOznaka(tip);

				var strukt = context.StruktureUlaganjaZaglavlje.Include("Detalji")
					.SingleOrDefault(s =>
						s.FOND_ID == fondID &&
						s.TIP == tipOznaka &&
						s.DATUM_OD <= datum &&
						(!s.DATUM_DO.HasValue || s.DATUM_DO >= datum)
						);

				return strukt == null ? (int?)null : strukt.ID;

			}
		}

		private static int KreirajFondStrukturaUlaganja(int fondID, FondoviHelper.StrukturaUlaganjaTip tip, DateTime datum)
		{
			using (var context = new FondEntities())
			{
				string tipOznaka = FondoviHelper.StrukturaUlaganjaOznaka(tip);

				DAL.StrukturaUlaganjaZaglavlje zag = new StrukturaUlaganjaZaglavlje();
				zag.FOND_ID = fondID;
				zag.DATUM_OD = datum;
				zag.TIP = tipOznaka;

				context.StruktureUlaganjaZaglavlje.AddObject(zag);
				context.SaveChanges();

				return zag.ID;
			}
		}

        public static void AzurirajFond(int id, string naziv, string valutaSifra, DateTime? datumOsnivanja)
        {
            using (var context = new FondEntities())
            {
                if (id > 0) //ažuriranje
                {
                    Fond fondDok = context.Fondovi.FirstOrDefault(f => f.ID == id);

                    if (fondDok != null)
                    {
                        fondDok.NAZIV = naziv;
                        fondDok.VALUTA_SIFRA = valutaSifra;
                        fondDok.DATUM_OSNIVANJA = datumOsnivanja;

                        context.SaveChanges();
                    }
                }
                else //novi
                {
                    Fond fondNew = new Fond();
                    fondNew.NAZIV = naziv;
                    fondNew.VALUTA_SIFRA = valutaSifra;
                    fondNew.DATUM_OSNIVANJA = datumOsnivanja;

                    context.AddToFondovi(fondNew);

                    context.SaveChanges();
                }
            }
        }

        public static bool FondToggleBlacklist(int id)
        {
            using (var context = new FondEntities())
            {
                try
                {
                    var fond = context.Fondovi.Single(f => f.ID == id);

                    if (fond.SAKRIVENI.HasValue && fond.SAKRIVENI.Value)
                        fond.SAKRIVENI = null;
                    else
                        fond.SAKRIVENI = true;

                    return context.SaveChanges() > 0;
                }
                catch (Exception ex)
                {
                    DAC.Logiraj("Greška kod mijenjanja blackliste: FondID = " + id, ex);
                    return false;
                }
            }
        }

        public static Kategorija VratiKategoriju(int id)
        {
            using (var context = new FondEntities())
            {
                return context.Kategorije.FirstOrDefault(k => k.ID == id);
            }
        }

		public static List<FondCijene> DohvatiCijeneIndeksni(int fondID, DateTime? inDatumOd, DateTime? inDatumDo)
		{
			using (var context = new FondEntities())
			{
				var fondoviCijene = new List<FondCijene>();

				var indeksni = context.Fondovi.Single(f=>f.ID == fondID).FondUsporedba;
				
				//foreach(var ind in indeksni)
                if(indeksni != null)
				{
					FondCijene fondCijene = new FondCijene();

                    fondCijene.Cijene = DohvatiCijeneProsireno(indeksni.ID, inDatumOd, inDatumDo);
                    fondCijene.ID = indeksni.ID;
                    fondCijene.Naziv = indeksni.NAZIV;

					fondoviCijene.Add(fondCijene);
				}

				return fondoviCijene;
			}
		}

        public static ICollection<DohvatiCijene_Result> DohvatiCijeneProsireno(int? inFondId, DateTime? inDatumOd, DateTime? inDatumDo)
        {
            using (var context = new FondEntities())
            {
                var cijene = context.DohvatiCijene(inFondId, inDatumOd, inDatumDo).ToList();

                if (!cijene.Any())
                    return cijene;

                decimal?
                    prvaVrijednost = cijene.Last().VRIJEDNOST,
                    proslaVrijednost = 0;


                for (int i = cijene.Count - 1; i >= 0; i--)
                {
                    DohvatiCijene_Result cijena = cijene[i];

                    //računanje postotka
                    decimal? razlika = cijena.VRIJEDNOST - prvaVrijednost;
                    decimal? postotak = prvaVrijednost.HasValue && prvaVrijednost != 0 ? (razlika * 100) / prvaVrijednost : 0;
                    cijena.POSTOTAK = Math.Round(postotak.Value, 2);

                    //računanje promjene
                    if (i == cijene.Count - 1)
                        cijena.PROMJENA = 0;
                    else
                    {
                        if (proslaVrijednost == 0)
                            cijena.PROMJENA = 0;
                        else
                            cijena.PROMJENA = (cijena.VRIJEDNOST - proslaVrijednost) / proslaVrijednost * 100;
                    }

                    proslaVrijednost = cijena.VRIJEDNOST;
                }

                return cijene;
            }
        }

		public static ICollection<DohvatiPortfelj_Result> DohvatiPortfeljProsireno(int KorisnikID, DateTime inDatumOd, out decimal outUkupno, out decimal outPrinosKnUkupno, out decimal outDobitUkupno)
		{
			using (var context = new FondEntities())
			{
				var portfeljSet = context.DohvatiPortfelj(KorisnikID, inDatumOd).ToList();

				decimal tecaj = 1; //u budućnosti će se možda implementirati
				decimal nabavnaVrijednostKnUkupno = 0;
				outDobitUkupno = outPrinosKnUkupno = outUkupno = 0;

				foreach(var portfelj in portfeljSet)
				{
					decimal? zadnjaCijena, predzadnjaCijena;
					DateTime? datumZadnjeCijene;

					ZadnjaCijena(portfelj.FOND_ID.Value, DateTime.Today, out zadnjaCijena, out datumZadnjeCijene, out predzadnjaCijena);

					portfelj.CIJENA = zadnjaCijena;
					portfelj.PREDZADNJA_CIJENA = predzadnjaCijena;
					portfelj.CIJENA_KN = zadnjaCijena * tecaj;
					portfelj.DATUM_ZADNJE_CIJENE = datumZadnjeCijene;

					portfelj.VRIJEDNOST_UDJELA = zadnjaCijena * portfelj.BR_UDJELA;
					portfelj.VRIJEDNOST_UDJELA_KN = zadnjaCijena * tecaj * portfelj.BR_UDJELA;

					portfelj.DOBIT_KN = (zadnjaCijena * tecaj * portfelj.BR_UDJELA) - portfelj.NABAVNA_VRIJEDNOST_KN;

					portfelj.PRINOS = portfelj.NABAVNA_VRIJEDNOST_KN == 0 ? 0 :
						portfelj.DOBIT_KN / portfelj.NABAVNA_VRIJEDNOST_KN * 100;

					outUkupno += portfelj.VRIJEDNOST_UDJELA_KN.Value;
					nabavnaVrijednostKnUkupno += portfelj.NABAVNA_VRIJEDNOST_KN.Value;
					outDobitUkupno += portfelj.DOBIT_KN.Value;
				}

				foreach (var portfelj in portfeljSet)
				{
					if (outUkupno == 0)
						portfelj.UDIO = 0;
					else
						portfelj.UDIO = portfelj.VRIJEDNOST_UDJELA_KN / outUkupno * 100;
				}

				outPrinosKnUkupno = nabavnaVrijednostKnUkupno == 0 ? 0 :
					outDobitUkupno / nabavnaVrijednostKnUkupno * 100;

				return portfeljSet;
			}
		}

		public static List<PortfeljStruktura> DohvatiPortfeljStruktura(int korisnikID, DateTime datum, string kategorija)
		{
			using (var context = new FondEntities())
			{
				decimal outUkupno, outPrinosKnUkupno, outDobitKnUkupno;

				var portfeljSet = DohvatiPortfeljProsireno(korisnikID, datum, out outUkupno, out outPrinosKnUkupno, out outDobitKnUkupno);

				var struktura = new List<PortfeljStruktura>();

				switch (kategorija)
				{
					case "D":
						struktura = portfeljSet.GroupBy(p => p.DRUSTVO).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "K":
						struktura = portfeljSet.GroupBy(p => p.KATEGORIJA).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "R":
						struktura = portfeljSet.GroupBy(p => p.RIZICNOST_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "V":
						struktura = portfeljSet.GroupBy(p => p.VALUTA).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "UP":
						struktura = portfeljSet.GroupBy(p => p.UPRAVLJANJE_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "C":
						struktura = portfeljSet.GroupBy(p => p.CILJ_PRINOSA_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "UL":
						struktura = portfeljSet.GroupBy(p => p.ULAGANJE_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "G":
						struktura = portfeljSet.GroupBy(p => p.REGIJA_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "S":
						struktura = portfeljSet.GroupBy(p => p.SEKTOR_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "T":
						struktura = portfeljSet.GroupBy(p => p.TRZISTE_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
					case "P":
						struktura = portfeljSet.GroupBy(p => p.PROFIL_RIZICNOSTI_NAZIV).Select(g => new PortfeljStruktura(g.Key, g.Sum(p => p.VRIJEDNOST_UDJELA_KN).Value)).ToList();
						break;
				}

				foreach (var s in struktura)
				{
					s.POSTOTAK = Math.Round((s.VRIJEDNOST * 100 / outUkupno), 2);
				}

				return struktura;
			}
		}

		private static decimal VrijednostPortfelja(int korisnikID, DateTime datum)
		{
			using (var context = new DAL.FondEntities())
			{
				var portfeljSet = context.DohvatiPortfelj(korisnikID, datum);
				decimal ukupno = 0;

				foreach (var p in portfeljSet)
				{
					decimal? zadnjaCijena = VratiZadnjuCijenu(p.FOND_ID.Value, datum);

					decimal vrijednostUdjelaKn = (zadnjaCijena ?? 0) * p.BR_UDJELA.Value;

					ukupno += vrijednostUdjelaKn;
				}

				return ukupno;
			}
		}

		public static List<PortfeljVrijednost> VrijednostiPortfelja(int korisnikID, DateTime datumOd, DateTime datumDo, int brojDatuma)
		{
			using (var context = new DAL.FondEntities())
			{
				var vrijednosti = new List<PortfeljVrijednost>();

				TimeSpan span = TimeSpan.MinValue;
				if (datumDo >= datumOd)
					span = datumDo - datumOd;

				int brojDana = span.Days;
				int i = 1;

				if (brojDana > brojDatuma)
				{
					i = brojDana / brojDatuma;
				}

				DateTime dan;

				for (dan = datumDo; dan >= datumOd; dan = dan.AddDays(-i))
				{
					decimal vrijednost = VrijednostPortfelja(korisnikID, dan);

					if (vrijednost == 0)
						continue;

					vrijednosti.Add(new PortfeljVrijednost(dan, Math.Round(vrijednost, 2)));
				}

				// Ako nema zadnjeg datuma, dodaj ga u datatable
				if (dan > datumOd)
				{
					dan = datumOd;

					var vrijednost = VrijednostPortfelja(korisnikID, dan);

					vrijednosti.Add(new PortfeljVrijednost(dan, Math.Round(vrijednost)));
				}

				decimal proslaVrijednost = 0;
				for (int j = vrijednosti.Count - 1; j >= 0; j--)
				{
					if (j == vrijednosti.Count - 1) vrijednosti.ElementAt(j).POSTOTAK = 0;
					else
					{
						if (proslaVrijednost == 0)
							vrijednosti.ElementAt(j).POSTOTAK = 0;
						else
							vrijednosti.ElementAt(j).POSTOTAK = Math.Round(((vrijednosti.ElementAt(j).VRIJEDNOST - proslaVrijednost) / proslaVrijednost * 100), 2);
					}

					proslaVrijednost = vrijednosti.ElementAt(j).VRIJEDNOST;
				}

				return vrijednosti;
			}
		}

		public static decimal? VratiZadnjuCijenu(int fondID, DateTime datum)
		{
			using (FondEntities context = new FondEntities())
			{
				//System.Data.Objects.ObjectParameter outZadnjaCijena = new System.Data.Objects.ObjectParameter("outZadnjaCijena", typeof(decimal?));
				//System.Data.Objects.ObjectParameter outPredzadnjaCijena = new System.Data.Objects.ObjectParameter("outPredzadnjaCijena", typeof(decimal?));
				//System.Data.Objects.ObjectParameter outDatumZadnjeCijene = new System.Data.Objects.ObjectParameter("outDatumZadnjeCijene", typeof(DateTime?));

				decimal? outZadnjaCijena, outPredzadnjaCijena;
				DateTime? outDatumZadnjeCijene;

				ZadnjaCijena(fondID, datum, out outZadnjaCijena, out outDatumZadnjeCijene, out outPredzadnjaCijena);

				//if (outZadnjaCijena.Value == DBNull.Value)
				//	return null;
				//else
					return outZadnjaCijena;
			}
		}

		public static void ZadnjaCijena(int fondId, DateTime datum, out decimal? zadnjaCijena, out DateTime? datumZadnjeCijene, out decimal? predzadnjaCijena)
		{
			using (var context = new FondEntities())
			{
				zadnjaCijena = predzadnjaCijena = 0;
				datumZadnjeCijene = null;

				var zadnja = (from v in context.FondVrijednosti
							 where v.FOND_ID == fondId
							 && v.DATUM <= datum
							 && (!v.VRIJEDI_DO.HasValue || v.VRIJEDI_DO >= datum)
							 select v).FirstOrDefault();

				if (zadnja != null)
				{
					DateTime predzadnjiDatum = zadnja.DATUM.Value.AddDays(-1);

					var predzadnja = (from v in context.FondVrijednosti
									  where v.FOND_ID == fondId
									  && v.VRIJEDI_DO == predzadnjiDatum
									  select v).FirstOrDefault();

					zadnjaCijena = zadnja.VRIJEDNOST;
					datumZadnjeCijene = zadnja.DATUM;

					if (predzadnja != null)
						predzadnjaCijena = predzadnja.VRIJEDNOST;
				}
			}
		}

		public static DateTime? VratiZadnjaCijenaDatum(int fondID)
		{
			using (var context = new FondEntities())
			{
				var datum = (from v in context.FondVrijednosti
							 where v.FOND_ID == fondID
							 orderby v.DATUM descending
							 select v.DATUM).FirstOrDefault();

				return datum;
			}
		}

		public static bool CijenaPostoji(int fondID, DateTime datum)
		{
			using (var context = new FondEntities())
			{
				var cijena = (from v in context.FondVrijednosti
							 where v.FOND_ID == fondID
							 && v.DATUM == datum
							 select v).SingleOrDefault();

				return cijena != null;
			}
		}

		public static int UnesiCijenu(int fondID, DateTime datum, decimal? vrijednost)
		{
			using (var context = new FondEntities())
			{
				DateTime? vrijediDo = null;

				var prethodnaCijena = (from v in context.FondVrijednosti
									   where v.FOND_ID == fondID
									   && v.DATUM <= datum
									   && (!v.VRIJEDI_DO.HasValue || v.VRIJEDI_DO >= datum)
									   select v).SingleOrDefault();

				//ako nema prethodne cijene, pronađi slijedeću
				if (prethodnaCijena == null)
				{
					vrijediDo = (from v in context.FondVrijednosti
								 where v.FOND_ID == fondID
								 select v.DATUM).Min();

					if (vrijediDo.HasValue)
						vrijediDo = vrijediDo.Value.AddDays(-1);
				}
				else
					vrijediDo = prethodnaCijena.VRIJEDI_DO;

				FondVrijednost newCijena = new FondVrijednost();
				newCijena.DATUM = datum;
				newCijena.FOND_ID = fondID;
				newCijena.VRIJEDNOST = vrijednost;
				newCijena.VRIJEDI_DO = vrijediDo;

				context.FondVrijednosti.AddObject(newCijena);

				//postavljanje vrijedi_do prošle cijene
				if(prethodnaCijena != null)
					prethodnaCijena.VRIJEDI_DO = datum.AddDays(-1);

				return context.SaveChanges();
			}
		}

		public static void UnesiCijene(int fondID, Dictionary<DateTime,decimal> noveCijene)
		{
			using (var context = new FondEntities())
			{
				foreach (var c in noveCijene)
				{
					DateTime datum = c.Key;
					decimal vrijednost = c.Value;


					var postojecaCijena = context.FondVrijednosti.SingleOrDefault(v => v.FOND_ID == fondID && v.DATUM == datum);

					//ako je datum postojeći
					if (postojecaCijena != null)
						postojecaCijena.VRIJEDNOST = vrijednost;
					else
					{
						FondVrijednost novaCijena = new FondVrijednost();
						novaCijena.DATUM = datum;
						novaCijena.FOND_ID = fondID;
						novaCijena.VRIJEDNOST = vrijednost;

						context.FondVrijednosti.AddObject(novaCijena);
					}
				}

				context.SaveChanges();

				//podesi vrijedi_do datume
				var uneseneCijene = context.FondVrijednosti.Where(v => v.FOND_ID == fondID).OrderBy(v=>v.DATUM).ToList();

				int broj = uneseneCijene.Count();

				for (int i = 0; i < broj; i++)
				{
					if (i == broj - 1) //ako je zadnji
						uneseneCijene.ElementAt(i).VRIJEDI_DO = null;
					else
					{
						uneseneCijene.ElementAt(i).VRIJEDI_DO = uneseneCijene.ElementAt(i + 1).DATUM.Value.AddDays(-1);
					}
				}

				context.SaveChanges();
			}
		}

		public static int ObrisiCijenu(int id)
		{
			using (var context = new FondEntities())
			{
				var cijena = context.FondVrijednosti.Single(v => v.ID == id);

				var prethodniDatum = cijena.DATUM.Value.AddDays(-1);
				var prethodnaCijena = context.FondVrijednosti.SingleOrDefault(v => v.FOND_ID == cijena.FOND_ID && v.VRIJEDI_DO == prethodniDatum);

				if (prethodnaCijena != null)
					prethodnaCijena.VRIJEDI_DO = cijena.VRIJEDI_DO;

				context.FondVrijednosti.DeleteObject(cijena);

				return context.SaveChanges();
			}
		}

		/// <summary>
		/// Vraća sve banke, plus jedan prazan zapis na početku
		/// </summary>
		/// <returns></returns>
		public static ICollection<BankaDomaca> VratiBankeDS()
		{
			using (var context = new FondEntities())
			{
				var banke = context.BankeDomace.OrderBy(b=>b.NAZIV).ToList();
				banke.Insert(0, new BankaDomaca());

				return banke;
			}
		}

		public static void BrisiZahtjev(int id)
		{
			using (var context = new FondEntities())
			{
				var zahtjev = context.FondZahtjevi.SingleOrDefault(z => z.ID == id);

				if (zahtjev != null)
					context.FondZahtjevi.DeleteObject(zahtjev);

				int num = context.SaveChanges();
			}
		}

		public static FondZahtjev VratiZahtjev(int id)
		{
			using (var context = new FondEntities())
			{
				return context.FondZahtjevi.Include("Fond").Include("Fond.Drustvo").SingleOrDefault(z => z.ID == id);
			}
		}

		public static ICollection<FondZahtjev> TraziZahtjeve(int korisnikID, DateTime? datumOd, DateTime? datumDo, string tip, string status, int? fondID)
		{
			using (var context = new FondEntities())
			{
				var zahtjevi = context.FondZahtjevi.Include("Fond").Include("Promet")
					.Where(z =>
						z.PODNOSENJE_KORISNIK_ID == korisnikID &&
						(!fondID.HasValue || z.FOND_ID == fondID) &&
						(!datumOd.HasValue || z.PODNOSENJE_DATUM >= datumOd) &&
						(!datumDo.HasValue || z.PODNOSENJE_DATUM <= datumDo) &&
						(tip == null || tip == "" || z.TIP_ZAHTJEVA == tip) &&
						(status == null || status == "" || z.STATUS == status)
						)
					.ToList();

				//veza na promet, da se pročita realizirani iznos/broj udjela
				foreach (var z in zahtjevi)
				{
					if (z.Promet != null && z.Promet.Any())
					{
						if (!z.ZELJENI_IZNOS_UDJELA.HasValue)
							z.ZELJENI_IZNOS_UDJELA = z.Promet.Single().IZNOS_KN;

						if (!z.ZELJENI_BROJ_UDJELA.HasValue)
							z.ZELJENI_BROJ_UDJELA = z.Promet.Single().BROJ_UDJELA;
					}
				}

				return zahtjevi;
			}
		}

		#region Prinosi

		public static decimal? VratiPrinos(int ID, decimal? VRIJEDNOST, DateTime datum)
		{
			decimal? prinos;
			decimal? zadnjaCijena = VratiZadnjuCijenu(ID, datum);

			if (!VRIJEDNOST.HasValue || VRIJEDNOST.Value == 0)
				prinos = 0;
			else if (zadnjaCijena == 0)
				prinos = 100;
			else
				prinos = (VRIJEDNOST - zadnjaCijena) * 100M / zadnjaCijena;

			return prinos;
		}

		public static decimal VratiPGP(int ID, decimal? VRIJEDNOST, DateTime? VRIJEDNOST_DATUM)
		{
			using (FondEntities context = new FondEntities())
			{
				if (!VRIJEDNOST.HasValue || !VRIJEDNOST_DATUM.HasValue)
					return 0;

				var cijene = context.DohvatiCijene(ID, null, null).ToList();

				decimal? zadnjaCijena = VRIJEDNOST;
				DateTime? datumZadnjeCijene = VRIJEDNOST_DATUM;

				decimal? prvaCijena = 0;
				DateTime? datumPrveCijene = null;

				if (cijene.Any())
				{
					prvaCijena = cijene.Last().VRIJEDNOST;
					datumPrveCijene = cijene.Last().DATUM;
				}

				TimeSpan span = TimeSpan.MinValue;

				if (datumZadnjeCijene.Value >= datumPrveCijene.Value)
					span = datumZadnjeCijene.Value.Subtract(datumPrveCijene.Value);

				double starost = span.TotalDays / 365.242199;

				decimal? prinosOdOsnutka = null;

				if (!prvaCijena.HasValue || prvaCijena.Value == 0)
					prinosOdOsnutka = 0;
				else
					prinosOdOsnutka = (zadnjaCijena.Value - prvaCijena.Value) / prvaCijena.Value;

				double x = Math.Pow(1 + (double)prinosOdOsnutka.Value, 1 / starost) - 1;

				return (decimal)x * 100;
			}
		}

		public static decimal VratiBrojUdjela(int korisnikID, int fondID, DateTime datum)
		{
			using (FondEntities context = new FondEntities())
			{
				var udjeli = from p in context.FondPrometi
							  where p.FOND_ID == fondID
							  && p.KORISNIK_ID == korisnikID
							  && p.DATUM <= datum
							  let brUdjela = (p.TIP_TRANSAKCIJE == "K" ? p.BROJ_UDJELA :
											  p.TIP_TRANSAKCIJE == "P" ? -p.BROJ_UDJELA :
											   0)
							  select brUdjela;

				if (udjeli == null)
					return 0;
				else
					return udjeli.Sum(p => (decimal?)p) ?? 0;
			}
		}

		#endregion Prinosi

		public static int? UnesiPromet(int korisnikID, int zahtjevID, string dokumentUrl, decimal? iznosUdjela = null, decimal? brojUdjela = null)
		{
			using (FondEntities context = new FondEntities())
			{
				var zahtjev = context.FondZahtjevi.SingleOrDefault(z => z.ID == zahtjevID);

				if (zahtjev == null)
					return null;

				FondPromet promet = new FondPromet();
				promet.ZAHTJEV_ID = zahtjev.ID;
				promet.FOND_ID = zahtjev.FOND_ID.Value;
				promet.KORISNIK_ID = korisnikID;
				promet.TIP_TRANSAKCIJE = zahtjev.TIP_ZAHTJEVA;
				promet.VRIJEME = DateTime.Now;
				promet.DATUM = DateTime.Today;

				if (zahtjev.Tip == FondZahtjevHelper.Tip.Prodaja)
				{
					promet.IZNOS_KN = iznosUdjela.Value;
					promet.BROJ_UDJELA = zahtjev.ZELJENI_BROJ_UDJELA.Value;
				}
				else if (zahtjev.Tip == FondZahtjevHelper.Tip.Kupnja)
				{
					promet.BROJ_UDJELA = brojUdjela.Value;
					promet.IZNOS_KN = zahtjev.ZELJENI_IZNOS_UDJELA.Value;
				}

				zahtjev.DOKUMENT_URL = dokumentUrl;
				zahtjev.STATUS = FondZahtjevHelper.StatusOznaka(FondZahtjevHelper.Status.Realiziran);
				zahtjev.OBRADA_DATUM = DateTime.Today;

				context.FondPrometi.AddObject(promet);

				return context.SaveChanges();
			}
		}

		public static FondPromet VratiPromet(int zahtjevID)
		{
			using (FondEntities context = new FondEntities())
			{
				var promet = context.FondPrometi.SingleOrDefault(p=>p.ZAHTJEV_ID == zahtjevID);

				return promet;
			}
		}

		public static void UnesiFondDokumente(int fondID, string kiidDokURL, string pravilaDokURL, string prospektDokURL, string osobnaDokURL)
		{
			using (var context = new FondEntities())
			{
				var fond = context.Fondovi.Single(f => f.ID == fondID);

                if (!string.IsNullOrEmpty(kiidDokURL))
                    fond.KIID_URL = kiidDokURL;

                if (!string.IsNullOrEmpty(pravilaDokURL))
                    fond.PRAVILA_URL = pravilaDokURL;

                if (!string.IsNullOrEmpty(prospektDokURL))
                    fond.PROSPEKT_URL = prospektDokURL;

                if (!string.IsNullOrEmpty(osobnaDokURL))
                    fond.OSOBNA_ISKAZNICA_URL = osobnaDokURL;

				context.SaveChanges();

			}
		}

		public static bool ObrisiFond(int fondID)
		{
			try
			{
				using (var context = new FondEntities())
				{
					var fond = context.Fondovi.Single(f => f.ID == fondID);

					context.Fondovi.DeleteObject(fond);
					context.SaveChanges();
					return true;
				}
			}
			catch (Exception ex)
			{
				DAC.Logiraj("Greška pri brisanju fonda " + fondID, ex);
				return false;
			}
		}

        public static decimal KorisnikNovac(int korisnikID)
        {
            using (var context = new FondEntities())
            {
                var korisnik = context.Korisnici.Single(k => k.ID == korisnikID);

                return korisnik.NOVAC ?? 0;
            }
        }

        public static bool AzurirajNovac(decimal novac, int korisnikID)
        {
            try
            {
                using (var context = new FondEntities())
                {
                    var korisnik = context.Korisnici.Single(k => k.ID == korisnikID);

                    korisnik.NOVAC = novac;

                    return context.SaveChanges() > 0;
                }
            }
            catch (Exception ex)
            {
                DAC.Logiraj("Greška pri unosu novca", ex);
                return false;
            }
        }

        //public static List<int> VratiFondoveUsporedbene(int fondID)
        //{
        //    if (fondID <= 0)
        //        return null;

        //    using (var context = new FondEntities())
        //    {
        //        return context.Fondovi.Single(f => f.ID == fondID).FondoviUsporedba.Select(u => u.ID).ToList();
        //    }
        //}

        //public static void PostaviFondUsporedbene(int fondID, List<int> usporedbeFondIDs)
        //{
        //    try
        //    {
        //        using (var context = new FondEntities())
        //        {
        //            var fond = context.Fondovi.Single(f => f.ID == fondID);

        //            fond.FondoviUsporedba.Clear();

        //            foreach (int id in usporedbeFondIDs)
        //            {
        //                var fondUsporedba = context.Fondovi.Single(f => f.ID == id);

        //                fond.FondoviUsporedba.Add(fondUsporedba);
        //            }

        //            context.SaveChanges();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        DAC.Logiraj("Greška pri spremanju fondova za usporedbu. Fond ID: " + fondID, ex);
        //    }
        //}

	}
}
