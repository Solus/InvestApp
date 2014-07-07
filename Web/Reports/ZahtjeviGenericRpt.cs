using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using InvestApp.Common;

namespace InvestApp.Web.Reports
{
	public partial class ZahtjeviGenericRpt : DevExpress.XtraReports.UI.XtraReport
	{
		public ZahtjeviGenericRpt()
		{
			InitializeComponent();
		}

		public void BindDataSource(int ID)
		{
			var zahtjev = DAL.FondDAC.VratiZahtjev(ID);

			if (zahtjev != null)
			{
                pbLogo.ImageUrl = zahtjev.Fond.DRUSTVO_LOGO_URL;

				// KUPNJA ILI PRODAJA
				if (zahtjev.TIP_ZAHTJEVA == "K")
				{
                    if (zahtjev.PRAVNA == "P")
                        ghKupnjaUlagateljFizicka.Visible = false;
                    else
                        ghKupnjaUlagateljPravna.Visible = false;

					ghNaslovProdaja.Visible = false;
					ghProdajaUlagateljPravna.Visible =
                    ghProdajaUlagateljFizicka.Visible = false;
					ghIsplataPodaci.Visible = false;
					ghIsplataRacun.Visible = false;
					ghCEBA.Visible = false;
				}
				else if (zahtjev.TIP_ZAHTJEVA == "P")
				{
                    lblNaslov.Text = "Zahtjev za otkup udjela u otvorenom investicijskom fondu";

                    tcProdajaPotpis.Text = "Žig i potpis odgovorne osobe";

                    ghProdajaUlagateljFizicka.Visible = 
                    ghProdajaUlagateljPravna.Visible = false;

                    if (zahtjev.PRAVNA == "P")
                        ghKupnjaUlagateljFizicka.Visible = false;
                    else
                        ghKupnjaUlagateljPravna.Visible = false;

					//ghKupnjaZakonski.Visible = false;
					//ghAdresaKorespondencije.Visible = false;
					ghIzjavaUlagatelja.Visible = false;
					ghIzjava.Visible = false;

					ghPlacanje.Visible = false;
					//var promet = DAL.FondDAC.VratiPromet(zahtjev.ID);
					//if (promet != null)
					//	zahtjev.ZELJENI_IZNOS_UDJELA = promet.IZNOS_KN;
				}

				string ZakonskiTipDokumenta = "";

				if (zahtjev.PRAVNA == "P")
				{
					ghIzjavaFizicki.Visible = false;

					if (zahtjev.ZASTUPANJE_TIP == "S")
						ghKupnjaZakonskiDrugaOsoba.Visible = true;

					this.Parameters["parUlagateljNaziv"].Value = zahtjev.PRAVNA_IME;
					this.Parameters["parUlagateljOdgovornaOsoba"].Value = zahtjev.FIZICKA_IME + " " + zahtjev.FIZICKA_PREZIME;
					this.Parameters["parUlagateljMBG"].Value = zahtjev.PRAVNA_MB;

					this.Parameters["parUlagateljDokNazivBroj"].Value = "";
					this.Parameters["parUlagateljDokVrijediDo"].Value = "";
					this.Parameters["parUlagateljDokIzdavatelj"].Value = "";

					this.Parameters["parUlagateljUlicaBrojMjesto"].Value = zahtjev.PRAVNA_ADRESA_ULICA + " " + zahtjev.PRAVNA_ADRESA_KUCNI_BROJ + ", " + zahtjev.PRAVNA_ADRESA_MJESTO;
					this.Parameters["parUlagateljPostanskiBroj"].Value = zahtjev.PRAVNA_ADRESA_POSTANSKI_BROJ;
					this.Parameters["parUlagateljDrzava"].Value = zahtjev.PRAVNA_ADRESA_DRZAVA;

					this.Parameters["parUlagateljTelefon"].Value = zahtjev.PRAVNA_TELEFON;
					this.Parameters["parUlagateljFax"].Value = zahtjev.PRAVNA_FAX;
					this.Parameters["parUlagateljEmail"].Value = zahtjev.PRAVNA_EMAIL;

					if (!string.IsNullOrEmpty(zahtjev.ADRESA_SLANJE_ULICA))
						this.Parameters["parAdresaKorespondencije"].Value = zahtjev.ADRESA_SLANJE_ULICA + " " + zahtjev.ADRESA_SLANJE_KUCNI_BROJ + ", " + zahtjev.ADRESA_SLANJE_POSTANSKI_BROJ + " " + zahtjev.ADRESA_SLANJE_MJESTO + ", " + zahtjev.ADRESA_SLANJE_DRZAVA;
					else
						this.Parameters["parAdresaKorespondencije"].Value = zahtjev.PRAVNA_ADRESA_ULICA + " " + zahtjev.ADRESA_SLANJE_KUCNI_BROJ + ", " + zahtjev.PRAVNA_ADRESA_POSTANSKI_BROJ + " " + zahtjev.PRAVNA_ADRESA_MJESTO + ", " + zahtjev.PRAVNA_ADRESA_DRZAVA;

					this.Parameters["parPulagateljImePrezime"].Value = "";
					this.Parameters["parPulagateljNazivPravne"].Value = zahtjev.PRAVNA_IME;
					this.Parameters["parPulagateljOIB"].Value = zahtjev.PRAVNA_OIB;
					this.Parameters["parPulagateljOdgovornaOsoba"].Value = zahtjev.FIZICKA_IME + " " + zahtjev.FIZICKA_PREZIME;

					this.Parameters["parAdresa"].Value = zahtjev.PRAVNA_ADRESA_ULICA + " " + zahtjev.PRAVNA_ADRESA_KUCNI_BROJ + ", " + zahtjev.PRAVNA_ADRESA_POSTANSKI_BROJ + " " + zahtjev.PRAVNA_ADRESA_MJESTO;

					if (zahtjev.VLASNISTVO_PODIJELJENO == "D")
					{
						ghPravnaStvarniVlasnici.Visible = true;
						ghPravnaStvarniVlasniciFoot.Visible = true;

						if (zahtjev.PRAVNA_VLASNIK2_POSTOJI == true)
							ghPravnaStvarniVlasniciVl2.Visible = true;

						if (zahtjev.PRAVNA_VLASNIK3_POSTOJI == true)
							ghPravnaStvarniVlasniciVl3.Visible = true;

						if (zahtjev.VLASNIK1_POLITICKA_IZLOZENOST == "D")
							ghVlasnik1PolitickaIzlozenost.Visible = true;

						if (zahtjev.VLASNIK2_POLITICKA_IZLOZENOST == "D")
							ghVlasnik2PolitickaIzlozenost.Visible = true;

						if (zahtjev.VLASNIK3_POLITICKA_IZLOZENOST == "D")
							ghVlasnik3PolitickaIzlozenost.Visible = true;
					}
                    tcJMBG.Text = "JMBG / MB:";
                    tcPotpis.Text = "Žig i potpis odgovorne osobe";
				}
				else if (zahtjev.PRAVNA == "F")
				{
					ghIzjavaPravni.Visible = false;

					ghKupnjaZakonski.Visible = false;

					if (zahtjev.POLITICKA_IZLOZENOST == "D")
						ghFizickaPolitickiIzlozen.Visible = true;

					this.Parameters["parUlagateljNaziv"].Value = zahtjev.FIZICKA_IME + " " + zahtjev.FIZICKA_PREZIME;
					this.Parameters["parUlagateljOdgovornaOsoba"].Value = "";
					this.Parameters["parUlagateljMBG"].Value = zahtjev.FIZICKA_JMBG;

					ZakonskiTipDokumenta = "";
					if (zahtjev.FIZICKA_DOKUMENT_TIP == "o") ZakonskiTipDokumenta = "Osobna iskaznica";
					else if (zahtjev.FIZICKA_DOKUMENT_TIP == "p") ZakonskiTipDokumenta = "Putovnica";

					this.Parameters["parUlagateljDokNazivBroj"].Value = ZakonskiTipDokumenta + ", " + zahtjev.FIZICKA_DOKUMENT_BROJ;
					this.Parameters["parUlagateljDokVrijediDo"].Value = zahtjev.FIZICKA_DOKUMENT_VRIJEDI_DO;
					this.Parameters["parUlagateljDokIzdavatelj"].Value = zahtjev.FIZICKA_DOKUMENT_IZDAVATELJ;

					this.Parameters["parUlagateljUlicaBrojMjesto"].Value = zahtjev.FIZICKA_ADRESA_ULICA + " " + zahtjev.FIZICKA_ADRESA_KUCNI_BROJ + ", " + zahtjev.FIZICKA_ADRESA_MJESTO;
					this.Parameters["parUlagateljPostanskiBroj"].Value = zahtjev.FIZICKA_ADRESA_POSTANSKI_BROJ;
					this.Parameters["parUlagateljDrzava"].Value = zahtjev.FIZICKA_ADRESA_DRZAVA;

					this.Parameters["parUlagateljTelefon"].Value = zahtjev.FIZICKA_TELEFON;
					this.Parameters["parUlagateljFax"].Value = zahtjev.FIZICKA_FAX;
					this.Parameters["parUlagateljEmail"].Value = zahtjev.FIZICKA_EMAIL;

					if (!string.IsNullOrEmpty(zahtjev.ADRESA_SLANJE_ULICA))
						this.Parameters["parAdresaKorespondencije"].Value = zahtjev.ADRESA_SLANJE_ULICA + " " + zahtjev.ADRESA_SLANJE_KUCNI_BROJ + ", " + zahtjev.ADRESA_SLANJE_POSTANSKI_BROJ + " " + zahtjev.ADRESA_SLANJE_MJESTO + ", " + zahtjev.ADRESA_SLANJE_DRZAVA;
					else
						this.Parameters["parAdresaKorespondencije"].Value = zahtjev.FIZICKA_ADRESA_ULICA + ", " + zahtjev.FIZICKA_ADRESA_POSTANSKI_BROJ + " " + zahtjev.FIZICKA_ADRESA_MJESTO + ", " + zahtjev.FIZICKA_ADRESA_DRZAVA;

					this.Parameters["parPulagateljImePrezime"].Value = zahtjev.FIZICKA_IME + " " + zahtjev.FIZICKA_PREZIME;
					this.Parameters["parPulagateljNazivPravne"].Value = "";
					this.Parameters["parPulagateljOIB"].Value = zahtjev.FIZICKA_OIB;

					this.Parameters["parPulagateljOdgovornaOsoba"].Value = "";

					this.Parameters["parAdresa"].Value = string.Format("{0} {1}, {2} {3}", zahtjev.FIZICKA_ADRESA_ULICA, zahtjev.FIZICKA_ADRESA_KUCNI_BROJ, zahtjev.FIZICKA_ADRESA_POSTANSKI_BROJ, zahtjev.FIZICKA_ADRESA_MJESTO);
				}

				//ako je prodaja, neke stvari se ne prikazuju
				if (zahtjev.Tip == FondZahtjevHelper.Tip.Prodaja)
				{
					ghIzjavaPranjeNovca.Visible =
					ghIzjavaPravni.Visible = 
					ghIzjavaFizicki.Visible = 
					ghPravnaStvarniVlasnici.Visible =
					ghPravnaStvarniVlasniciVl2.Visible =
					ghPravnaStvarniVlasniciVl3.Visible =
					ghPravnaStvarniVlasniciFoot.Visible =
					ghVlasnik1PolitickaIzlozenost.Visible =
					ghVlasnik2PolitickaIzlozenost.Visible =
					ghVlasnik3PolitickaIzlozenost.Visible = false;
				}

				if (!string.IsNullOrEmpty(zahtjev.VBDI))
				{
					this.Parameters["parPulagateljBrojRacuna"].Value = zahtjev.VBDI + "-" + zahtjev.RACUN_BROJ;
				}
				else
				{
					this.Parameters["parPulagateljBrojRacuna"].Value = zahtjev.RACUN_BROJ;
				}

				if (!string.IsNullOrEmpty(zahtjev.FIZICKA_ADRESA_ULICA))
					this.Parameters["parZakonskiUlicaBrojMjesto"].Value = zahtjev.FIZICKA_ADRESA_ULICA + " " + zahtjev.FIZICKA_ADRESA_KUCNI_BROJ + ", " + zahtjev.FIZICKA_ADRESA_MJESTO;
				
				this.Parameters["parZakonskiImePrezime"].Value = zahtjev.FIZICKA_IME + " " + zahtjev.FIZICKA_PREZIME;

				string oib = zahtjev.FIZICKA_OIB;
				if(!string.IsNullOrEmpty(oib))
					oib = oib.Replace("HR", "");

				this.Parameters["parZakonskiJMBGOIB"].Value = zahtjev.FIZICKA_JMBG + "  OIB: " + oib;

				this.Parameters["parMjestoDatum"].Value = "Zagreb, " + DateTime.Today.ToString("dd.MM.yyyy");

				ZakonskiTipDokumenta = "";

				if (zahtjev.FIZICKA_DOKUMENT_TIP == "o")
					ZakonskiTipDokumenta = "Osobna iskaznica";
				else if (zahtjev.FIZICKA_DOKUMENT_TIP == "p")
					ZakonskiTipDokumenta = "Putovnica";

				if (!string.IsNullOrEmpty(zahtjev.FIZICKA_DOKUMENT_BROJ))
					this.Parameters["parZakonskiNazivBrojDok"].Value = ZakonskiTipDokumenta + ", " + zahtjev.FIZICKA_DOKUMENT_BROJ;

				if (zahtjev.ZASTUPANJE_TIP == "S")
				{
					string ZakonskiDrugaTipDokumenta = "";
					if (zahtjev.DRUGA_FIZICKA_DOKUMENT_TIP== "o")
						ZakonskiDrugaTipDokumenta = "Osobna iskaznica";
					else if (zahtjev.DRUGA_FIZICKA_DOKUMENT_TIP == "p")
						ZakonskiDrugaTipDokumenta = "Putovnica";

					if (!string.IsNullOrEmpty(zahtjev.DRUGA_FIZICKA_DOKUMENT_BROJ))
						this.Parameters["parZakonskiDrugaNazivBrojDok"].Value = ZakonskiDrugaTipDokumenta + ", " + zahtjev.DRUGA_FIZICKA_DOKUMENT_BROJ;

					if (!string.IsNullOrEmpty(zahtjev.DRUGA_FIZICKA_ADRESA_ULICA))
						this.Parameters["parZakonskiDrugaUlicaBrojMjesto"].Value = zahtjev.DRUGA_FIZICKA_ADRESA_ULICA + " " + zahtjev.DRUGA_FIZICKA_ADRESA_KUCNI_BROJ + ", " + zahtjev.DRUGA_FIZICKA_ADRESA_MJESTO;
				}

				#region Podaci o plaćanje

				parNalogOpisPlacanja.Value = Utility.StringNvl(zahtjev.NALOG_OPIS_PLACANJA, zahtjev.Fond.NALOG_OPIS_PLACANJA, zahtjev.Fond.Drustvo.NALOG_OPIS_PLACANJA);
				parNalogPBO.Value = Utility.StringNvl(zahtjev.NALOG_PBO, zahtjev.Fond.NALOG_PBO, zahtjev.Fond.Drustvo.NALOG_PBO);
				parNalogPBO_Model.Value = Utility.StringNvl(zahtjev.NALOG_MODEL, zahtjev.Fond.NALOG_PBO_MODEL, zahtjev.Fond.Drustvo.NALOG_PBO_MODEL);
				parNalogPrimateljAdresa.Value = Utility.StringNvl(zahtjev.NALOG_PRIMATELJ_ADRESA, zahtjev.Fond.Drustvo.ADRESA);
				parNalogPrimateljIme.Value = Utility.StringNvl(zahtjev.NALOG_PRIMATELJ_IME, zahtjev.Fond.Drustvo.NAZIV);
				parNalogRacun.Value = Utility.StringNvl(zahtjev.NALOG_BROJ_RACUNA, zahtjev.Fond.NALOG_PRIMATELJ_RACUN, zahtjev.Fond.Drustvo.NALOG_PRIMATELJ_RACUN);
				parNalogSifraNamjene.Value = Utility.StringNvl(zahtjev.NALOG_SIFRA_NAMJENE, zahtjev.Fond.NALOG_SIFRA_NAMJENE, zahtjev.Fond.Drustvo.NALOG_SIFRA_NAMJENE);

				#endregion
			}
			
			bindingSource1.DataSource = zahtjev;
		}

		private void ZahtjeviGenericRpt_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
		{
			DAL.FondZahtjev zahtjev = (GetCurrentRow() as DAL.FondZahtjev);

			if (zahtjev == null)
				return;

			cbZastupnikFizicka.Checked = true;
			xrCheckBox1.Checked = true;

			if (zahtjev.PRAVNA == "P")
			{
				cbPravna.Checked = cbPravna2.Checked = true;
				cbPulagateljPravna.Checked = cbPulagateljPravna2.Checked = true;

				if (zahtjev.VLASNISTVO_PODIJELJENO == "D")
					chkVlasnistvoPodijeljenoDA.Checked = true;
				else
					chkVlasnistvoPodijeljenoNE.Checked = true;

				switch (zahtjev.PRAVNA_PLANIRANA_GOD_ULAGANJA)
				{
					case "1":
						chkPravnaUlaganja100.Checked = true;
						break;
					case "2":
						chkPravnaUlaganja100_500.Checked = true;
						break;
					case "3":
						chkPravnaUlaganja500_1000.Checked = true;
						break;
					case "4":
						chkPravnaUlaganja1000_4000.Checked = true;
						break;
					case "5":
						chkPravnaUlaganja4000.Checked = true;
						break;
				}

			}
			else if (zahtjev.PRAVNA == "F")
			{
				cbFizicka.Checked = cbFizicka2.Checked = true;
				cbPulagateljFizicka.Checked = cbPulagateljFizicka2.Checked = true;

				switch(zahtjev.FIZICKA_STATUS_ODABIR)
				{
					case "z":
						chkFizickaStatusZaposlenik.Checked = true;
						break;
					case "p":
						chkFizickaStatusPoduzetnik.Checked = true;
						break;
					case "n":
						chkFizickaStatusNezaposlen.Checked = true;
						break;
					case "u":
						chkFizickaStatusUmirovljenik.Checked = true;
						break;
					case "s":
						chkFizickaStatusStudent.Checked = true;
						break;
				}

				switch (zahtjev.FIZICKA_VRSTA_POSLODAVCA)
				{
					case "ps":
						chkPoslodavacVrstaPrivatni.Checked = true;
						break;
					case "ds":
						chkPoslodavacVrstaDrzavna.Checked = true;
						break;
					case "td":
						chkPoslodavacVrstaTijela.Checked = true;
						break;
					case "dt":
						chkPoslodavacVrstaTrgovacka.Checked = true;
						break;
					case "os":
						chkPoslodavacVrstaOstalo.Checked = true;
						break;
				}

				switch (zahtjev.FIZICKA_PLANIRANA_GOD_ULAGANJA)
				{
					case "1":
						chkFizickaUlaganja50.Checked = true;
						break;
					case "2":
						chkFizickaUlaganja50_200.Checked = true;
						break;
					case "3":
						chkFizickaUlaganja200_500.Checked = true;
						break;
					case "4":
						chkFizickaUlaganja500_1000.Checked = true;
						break;
					case "5":
						chkFizickaUlaganja1000.Checked = true;
						break;
				}

				switch (zahtjev.FIZICKA_SREDSTVA_OSTVARENA)
				{
					case "1":
						chkFizickaSredstvaRedovno.Checked = true;
						break;
					case "2":
						chkFizickaSredstvaSamostalno.Checked = true;
						break;
					case "3":
						chkFizickaSredstvaImovina.Checked = true;
						break;
					case "4":
						chkFizickaSredstvaKapital.Checked = true;
						break;
					case "5":
						chkFizickaSredstvaIzvanredno.Checked = true;
						break;
					case "6":
						chkFizickaSredstvaOstalo.Checked = true;
						break;
				}

				if (zahtjev.POLITICKA_IZLOZENOST == "D")
					chkPolitickaIzlozenostDA.Checked = true;
				else
					chkPolitickaIzlozenostNE.Checked = true;
			}

			if (zahtjev.REZIDENTNOST == "R")
			{
				cbRezident.Checked = cbRezident2.Checked = true;
				cbZastupnikRezident.Checked = true;
				cbPulagateljRezident.Checked = cbPulagateljRezident2.Checked = true;
			}
			else
			{
				cbNerezident.Checked = cbNerezident2.Checked = true;
				cbZastupnikNerezident.Checked = true;
				cbPulagateljNerezident.Checked = cbPulagateljNerezident2.Checked = true;
			}

			//if (zahtjev.ZELJENI_BROJ_UDJELA.HasValue)
			//	cbIsplataBroj.Checked = true;
			//else if (zahtjev.ZELJENI_IZNOS_UDJELA.HasValue)
			//	cbIsplataIznos.Checked = true;
		}

	}
}
