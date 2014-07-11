using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using InvestApp.Common;
using System.Data.Objects;
using System.Data.Objects.DataClasses;

namespace InvestApp.DAL
{

    public partial class Fond
    {
        public string REGIJA_NAZIV
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
					return this.FOND_REGIJA == null ? "" : this.FOND_REGIJA.NAZIV;
                }
            }
        }

        public string DRUSTVO_NAZIV
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
					return this.Drustvo != null ? this.Drustvo.NAZIV : "";
                }
            }
        }

        public string KATEGORIJA_NAZIV
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
					return this.Kategorija == null ? "" : this.Kategorija.NAZIV;
                }
            }
        }

        public string ULAGANJE_NAZIV
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
					return this.FOND_TIP_ULAGANJA == null ? "" : this.FOND_TIP_ULAGANJA.NAZIV;
                }
            }
        }

        public string UPRAVLJANJE_NAZIV
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
					return this.FOND_TIP_UPRAVLJANJA == null ? "" : this.FOND_TIP_UPRAVLJANJA.NAZIV;
                }
            }
        }

		public string CILJ_PRINOSA_NAZIV
		{
			get
			{
				using (FondEntities context = new FondEntities())
				{
					return this.FOND_CILJ_PRINOSA == null ? "" : this.FOND_CILJ_PRINOSA.NAZIV;
				}
			}
		}

		public string SEKTOR_NAZIV
		{
			get
			{
				using (FondEntities context = new FondEntities())
				{
					return this.FOND_SEKTOR == null ? "" : this.FOND_SEKTOR.NAZIV;
				}
			}
		}

		public string TRZISTE_NAZIV
		{
			get
			{
				using (FondEntities context = new FondEntities())
				{
					return this.FOND_TRZISTE == null ? "" : this.FOND_TRZISTE.NAZIV;
				}
			}
		}

		public string PROFIL_RIZICNOSTI_NAZIV
		{
			get
			{
				using (FondEntities context = new FondEntities())
				{
					return this.FOND_PROFIL_RIZICNOSTI == null ? "" : this.FOND_PROFIL_RIZICNOSTI.NAZIV;
				}
			}
		}



        public string RIZICNOST_NAZIV
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
                    switch (this.RIZICNOST)
                    {
                        case "VN": return "Vrlo niska";
                        case "NN": return "Niska";
                        case "UU": return "Umjerena";
                        case "VS": return "Visoka";
                        case "VV": return "Vrlo visoka";
                        default: return "";
                    }
                }
            }
        }

        public string VALUTA
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
					return this.VALUTA_REF == null ? "" : this.VALUTA_REF.OZNAKA;
                }
            }
        }

		public string DRUSTVO_LOGO_URL
		{
			get
			{
				using (FondEntities context = new FondEntities())
				{

					return this.Drustvo.LOGO_URL;
				}
			}
		}

		public decimal? VRIJEDNOST_DANAS
		{
			get
			{
				var vrijednost = this.FOND_VRIJEDNOST_UDJELA.SingleOrDefault(v => v.DATUM <= DateTime.Today && (!v.VRIJEDI_DO.HasValue || v.VRIJEDI_DO >= DateTime.Today));

				if (vrijednost == null)
					return null;
				else
					return vrijednost.VRIJEDNOST;
			}
		}



		public ICollection<Fond> SlicniFondovi
		{
			get
			{
				if (this.GRUPE.IsNullOrEmpty())
					return null;
				else
				{
					return FondDAC.VratiSlicneFondove(this.ID);
				}
			}

		}
    }

    public partial class TraziFondove_Result
    {
        public decimal? PGP
        {
            get
			{
				return FondDAC.VratiPGP(this.ID, this.VRIJEDNOST, this.VRIJEDNOST_DATUM);
            }
        }

        public decimal? PTG
        {
            get
            {
                using (FondEntities context = new FondEntities())
                {
					decimal? tekucaCijena, prethodnaCijena;
                    DateTime? datumTekuceCijene;

                    //System.Data.Objects.ObjectParameter tekucaCijenaParam = new System.Data.Objects.ObjectParameter("outZadnjaCijena", typeof(decimal?));
                    //System.Data.Objects.ObjectParameter prethodnaCijenaParam = new System.Data.Objects.ObjectParameter("outPredzadnjaCijena", typeof(decimal?));
                    //System.Data.Objects.ObjectParameter datumTekuceCijeneParam = new System.Data.Objects.ObjectParameter("outDatumZadnjeCijene", typeof(DateTime?));

                    //context.ZadnjaCijena(this.ID, new DateTime(DateTime.Today.Year, 1, 1), tekucaCijenaParam, datumTekuceCijeneParam, prethodnaCijenaParam);
					DAL.FondDAC.ZadnjaCijena(this.ID, new DateTime(DateTime.Today.Year, 1, 1), out tekucaCijena, out datumTekuceCijene, out prethodnaCijena);

                    //decimal? tekucaCijena = (decimal?)tekucaCijenaParam.Value,
                    //    prethodnaCijena = (decimal?)prethodnaCijenaParam.Value;
                    //DateTime? datumTekuceCijene = (DateTime?)datumTekuceCijeneParam.Value;
                    decimal? ptg, zadnjaCijena = VRIJEDNOST;

                    if (!tekucaCijena.HasValue || tekucaCijena.Value == 0)
                        ptg = 0;
                    else
                        ptg = (zadnjaCijena - tekucaCijena) * 100M / tekucaCijena;

                    return ptg;
                }
            }
        }

		public decimal? PRINOS_1M
		{
			get
			{
				return FondDAC.VratiPrinos(this.ID, this.VRIJEDNOST, DateTime.Today.AddMonths(-1));
			}
		}

		public decimal? PRINOS_3M
		{
			get
			{
				return FondDAC.VratiPrinos(this.ID, this.VRIJEDNOST, DateTime.Today.AddMonths(-3));
			}
		}

		public decimal? PRINOS_6M
		{
			get
			{
				return FondDAC.VratiPrinos(this.ID, this.VRIJEDNOST, DateTime.Today.AddMonths(-6));
			}
		}

		public decimal? PRINOS_1G
		{
			get
			{
				return FondDAC.VratiPrinos(this.ID, this.VRIJEDNOST, DateTime.Today.AddYears(-1));
			}
		}

		public decimal? PRINOS_3G
		{
			get
			{
				return FondDAC.VratiPrinos(this.ID, this.VRIJEDNOST, DateTime.Today.AddYears(-3));
			}
		}

		public decimal? PRINOS_5G
		{
			get
			{
				return FondDAC.VratiPrinos(this.ID, this.VRIJEDNOST, DateTime.Today.AddYears(-5));
			}
		}

        public decimal? POSTOTAK
        {
            get
            {
                var zadnjaCijena = this.VRIJEDNOST;
                var predzadnjaCijena = this.PROSLA_VRIJEDNOST;

                if (zadnjaCijena.HasValue && predzadnjaCijena.HasValue && predzadnjaCijena != 0)
                    return (zadnjaCijena.Value - predzadnjaCijena.Value) / predzadnjaCijena.Value * 100;
                else if (zadnjaCijena.HasValue)
                    return 0;

                return null;
            }
        }

    }

    public partial class DohvatiCijene_Result
    {
        public decimal? POSTOTAK
        {
            get;
            set;
        }

        public decimal? PROMJENA
        {
            get;
            set;
        }
    }

	public partial class Korisnik
	{
		public bool IsPravna
		{
			get { return PRAVNA == "P"; }
		}

		public string PRAVNA_PLANIRANA_GOD_ULAGANJA_NAZIV
		{
			get
			{
				return FondoviHelper.PravnaPlaniranaGodUlaganjaNaziv(PRAVNA_PLANIRANA_GOD_ULAGANJA);
			}
		}

		public string FIZICKA_PLANIRANA_GOD_ULAGANJA_NAZIV
		{
			get
			{
				return FondoviHelper.FizickaPlaniranaGodUlaganja(FIZICKA_PLANIRANA_GOD_ULAGANJA);
			}
		}

		public string FIZICKA_DOKUMENT_TIP_NAZIV
		{
			get
			{
				return FondoviHelper.DokumentTipNaziv(FIZICKA_DOKUMENT_TIP);
			}
		}

		public string FIZICKA_STATUS_ODABIR_NAZIV
		{
			get
			{
				return FondoviHelper.FizickaStatusNaziv(FIZICKA_STATUS_ODABIR);
			}
		}

		public string FIZICKA_VRSTA_POSLODAVCA_NAZIV
		{
			get
			{
				return FondoviHelper.FizickaVrstaPoslodavcaNaziv(FIZICKA_VRSTA_POSLODAVCA);
			}
		}

		public string FIZICKA_STRUCNA_SPREMA_NAZIV
		{
			get
			{
				return FondoviHelper.FizickaStrucnaSpremaNaziv(FIZICKA_STRUCNA_SPREMA);
			}
		}

		public string FIZICKA_SREDSTVA_OSTVARENA_NAZIV
		{
			get
			{
				return FondoviHelper.FizickaSredstvaOstvarenaNaziv(FIZICKA_SREDSTVA_OSTVARENA);
			}
		}

		public string SLIKA_OSOBNE_THUMB_URL
		{
			get
			{
				if (string.IsNullOrEmpty(_SLIKA_OSOBNE_URL))
					return "";
				else
					return Common.Utility.VratiDatotekaIkonaUrl(SLIKA_OSOBNE_URL);
			}
		}

        public string SLIKA_OSOBNE_DRUGI_THUMB_URL
        {
            get
            {
                if (string.IsNullOrEmpty(_SLIKA_OSOBNE_DRUGI_URL))
                    return "";
                else
                    return Common.Utility.VratiDatotekaIkonaUrl(SLIKA_OSOBNE_DRUGI_URL);
            }
        }

		public string KARTICA_RACUNA_THUMB_URL
		{
			get
			{
				if (string.IsNullOrEmpty(KARTICA_RACUNA_URL))
					return "";
				else
					return Common.Utility.VratiDatotekaIkonaUrl(KARTICA_RACUNA_URL);
			}
		}

        public string IZVOD_SCAN_THUMB_URL
        {
            get
            {
                if (string.IsNullOrEmpty(IZVOD_SCAN_URL))
                    return "";
                else
                    return Common.Utility.VratiDatotekaIkonaUrl(IZVOD_SCAN_URL);
            }
        }

        public string POTPISNI_KARTON_SCAN_THUMB_URL
        {
            get
            {
                if (string.IsNullOrEmpty(POTPISNI_KARTON_SCAN_URL))
                    return "";
                else
                    return Common.Utility.VratiDatotekaIkonaUrl(POTPISNI_KARTON_SCAN_URL);
            }
        }

	}

	public partial class FondZahtjev
	{
		public FondZahtjev()
		{
			this.PODNOSENJE_DATUM = DateTime.Today;
			this.STATUS = Common.FondZahtjevHelper.StatusOznaka(Common.FondZahtjevHelper.Status.Podnesen);
		}

		partial void OnFOND_IDChanged()
		{
			//čitanje podataka naloga iz fonda ili društva
			if (FOND_ID.HasValue)
			{
				using (FondEntities context = new FondEntities())
				{
					var fond = context.Fondovi.Include("Drustvo").FirstOrDefault(f => f.ID == FOND_ID);

					if (fond != null && fond.Drustvo != null)
					{
						NALOG_PRIMATELJ_IME = fond.Drustvo.NAZIV;
						NALOG_PRIMATELJ_ADRESA = fond.Drustvo.ADRESA;

						NALOG_VBDI = Utility.StringNvl(fond.NALOG_PRIMATELJ_VBDI, fond.Drustvo.NALOG_PRIMATELJ_VBDI);
						NALOG_BROJ_RACUNA = Utility.StringNvl(fond.NALOG_PRIMATELJ_RACUN, fond.Drustvo.NALOG_PRIMATELJ_RACUN);
						NALOG_OPIS_PLACANJA = Utility.StringNvl(fond.NALOG_OPIS_PLACANJA, fond.Drustvo.NALOG_OPIS_PLACANJA);
						NALOG_PBO = Utility.StringNvl(fond.NALOG_PBO, fond.Drustvo.NALOG_PBO);
						NALOG_MODEL = Utility.StringNvl(fond.NALOG_PBO_MODEL, fond.Drustvo.NALOG_PBO_MODEL);
						NALOG_SIFRA_NAMJENE = Utility.StringNvl(fond.NALOG_SIFRA_NAMJENE, fond.Drustvo.NALOG_SIFRA_NAMJENE);
					}
				}
			}

		}

		public string FOND_NAZIV
		{ 
			get
			{
				return this.Fond.NAZIV;
			}
		}

		public string TIP_ZAHTJEVA_NAZIV
		{
			get
			{
				return Common.FondZahtjevHelper.TipNaziv(this.TIP_ZAHTJEVA);
			}
		}

		public Common.FondZahtjevHelper.Tip Tip
		{
			get
			{
				return Common.FondZahtjevHelper.TipIzOznake(this.TIP_ZAHTJEVA);
			}
		}

		public string STATUS_NAZIV
		{
			get
			{
				return Common.FondZahtjevHelper.StatusNaziv(this.STATUS);
			}
		}

		public FondZahtjevHelper.Status StatusTip
		{
			get
			{
				return Common.FondZahtjevHelper.StatusIzOznake(this.STATUS);
			}
		}
	}

	public partial class DohvatiPortfelj_Result
	{
		public decimal? CIJENA { get; set; }
		public decimal? PREDZADNJA_CIJENA { get; set; }
		public DateTime? DATUM_ZADNJE_CIJENE { get; set; }
		public decimal? CIJENA_KN { get; set; }
		public decimal? VRIJEDNOST_UDJELA { get; set; }
		public decimal? VRIJEDNOST_UDJELA_KN { get; set; }
		public decimal? UDIO { get; set; }
		public decimal? DOBIT_KN { get; set; }
		public decimal? PRINOS { get; set; }

		public decimal? POSTOTAK
		{
			get
			{
				if (this.CIJENA.HasValue && this.PREDZADNJA_CIJENA.HasValue && this.PREDZADNJA_CIJENA != 0)
					return (this.CIJENA.Value - this.PREDZADNJA_CIJENA.Value) / this.PREDZADNJA_CIJENA.Value * 100;
				else if (this.CIJENA.HasValue)
					return 0;
				else
					return null;
			}
		}

		public string RIZICNOST_NAZIV
		{
			get
			{
				switch (RIZICNOST)
				{
					case "VN": return "Vrlo niska";
					case "NN": return "Niska";
					case "UU": return "Umjerena";
					case "VS": return "Visoka";
					case "VV": return "VrloVisoka";
					default: return "";
				}
			}
		}
	}

	public partial class Novost
	{
		public Novost()
		{
			this.VRIJEME_KREIRANJA = DateTime.Now;
		}
	}

	public class FondCijene
	{
		public int ID { get; set; }
		public string Naziv { get; set; }
		public ICollection<DohvatiCijene_Result> Cijene { get; set; }
	} 
}
