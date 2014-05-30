using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using InvestApp.Common;

namespace InvestApp.Web
{
	public partial class FondKupnja : UIControls.InvestAppPage
	{
		private enum Korak
		{
			A_Uvod = 0,
			B_OsobniPodaci = 1,
			B2_PodaciDrugeOsobe = 2,
			C_Placanje = 3,
			D_PranjeNovcaFizickaPravna = 4,
			E_PolitIzl_Vlasnistvno_FizickaPravna = 5,
			F_PolitIzlozenostFizicka = 6,
			G_StvarniVlasniciPravna = 7,
			G1_Vlasnik1PolitIzlozenost =8,
			G2_Vlasnik2PoliitIzlozenost = 9,
			G3_Vlasnik3PolitIzlozenost = 10,
			Z_Zadnje = 11
		}

		private const int PREV_STEP = -1;
		private const int NEXT_STEP = +1;

		#region Privatna svojstva
		
		private int FondID
		{
			get { return Session["fondID"] == null ? -1 : (int)Session["fondID"]; }
			set { Session["fondID"] = value; }
		}

		private bool Pravna
		{
			get { return ViewState["pravna"] == null ? false : (bool)ViewState["pravna"]; }
			set { ViewState["pravna"] = value; }
		}

		private bool Rezident
		{
			get { return ViewState["rezdnt"] == null ? false : (bool)ViewState["rezdnt"]; }
			set { ViewState["rezdnt"] = value; }
		}

		private bool Kupnja
		{
			get { return ViewState["zahtkup"] == null ? true : (bool)ViewState["zahtkup"]; }
			set { ViewState["zahtkup"] = value; }
		}

		private bool Korak1Init
		{
			get{ return ViewState["kor1init"] == null ? false : (bool)ViewState["kor1init"]; }
			set{ ViewState["kor1init"] = value; }
		}

		private bool Korak2Init
		{
			get { return ViewState["kor2init"] == null ? false : (bool)ViewState["kor2init"]; }
			set { ViewState["kor2init"] = value; }
		}

		private bool Korak2aInit
		{
			get { return ViewState["kor2ainit"] == null ? false : (bool)ViewState["kor2ainit"]; }
			set { ViewState["kor2ainit"] = value; }
		}

		private bool Korak3Init
		{
			get { return ViewState["kor3init"] == null ? false : (bool)ViewState["kor3init"]; }
			set { ViewState["kor3init"] = value; }
		}

		private bool Korak4Init
		{
			get { return ViewState["kor4init"] == null ? false : (bool)ViewState["kor4init"]; }
			set { ViewState["kor4init"] = value; }
		}

		private bool Korak5Init
		{
			get { return ViewState["kor5init"] == null ? false : (bool)ViewState["kor5init"]; }
			set { ViewState["kor5init"] = value; }
		}

		private bool IsFinalStep
		{
			get { return ViewState["korFinal"] == null ? false : (bool)ViewState["korFinal"]; }
			set { ViewState["korFinal"] = value; }
		}

		private DAL.Korisnik KorisnikUneseniPodaci
		{
			get { return ViewState["korpodaci"] == null ? new DAL.Korisnik() : (DAL.Korisnik)ViewState["korpodaci"]; }
			set { ViewState["korpodaci"] = value; }
		}

		private Korak TrenutniKorak
		{
			get { return ViewState["trenKorak"] == null ? Korak.A_Uvod  : (Korak)ViewState["trenKorak"]; }
			set { ViewState["trenKorak"] = value; }
		}

		private bool SkupnoZastupanje
		{
			get { return ViewState["ovlpravSkup"] == null ? false : (bool)ViewState["ovlpravSkup"]; }
			set { ViewState["ovlpravSkup"] = value; }
		}

		private bool FizickaPolitickiIzlozen
		{
			get { return ViewState["fizpolitizl"] == null ? false : (bool)ViewState["fizpolitizl"]; }
			set { ViewState["fizpolitizl"] = value; }
		}

		private bool PravnaVlasnistvoPodijeljeno25Posto
		{
			get { return ViewState["pravvlasn25posto"] == null ? false : (bool)ViewState["pravvlasn25posto"]; }
			set { ViewState["pravvlasn25posto"] = value; }
		}

		private bool PravnaVlasnik2Postoji
		{
			get { return ViewState["pravvlasnik2postoji"] == null ? false : (bool)ViewState["pravvlasnik2postoji"]; }
			set { ViewState["pravvlasnik2postoji"] = value; }
		}

		private bool PravnaVlasnik3Postoji
		{
			get { return ViewState["pravvlasnik3postoji"] == null ? false : (bool)ViewState["pravvlasnik3postoji"]; }
			set { ViewState["pravvlasnik3postoji"] = value; }
		}

		private bool PravnaVlasnik1PolitickiIzlozen
		{
			get { return ViewState["pravvlasnik1politizl"] == null ? false : (bool)ViewState["pravvlasnik1politizl"]; }
			set { ViewState["pravvlasnik1politizl"] = value; }
		}

		private bool PravnaVlasnik2PolitickiIzlozen
		{
			get { return ViewState["pravvlasnik2politizl"] == null ? false : (bool)ViewState["pravvlasnik2politizl"]; }
			set { ViewState["pravvlasnik2politizl"] = value; }
		}

		private bool PravnaVlasnik3PolitickiIzlozen
		{
			get { return ViewState["pravvlasnik3politizl"] == null ? false : (bool)ViewState["pravvlasnik3politizl"]; }
			set { ViewState["pravvlasnik3politizl"] = value; }
		}

		public string PravnaVlasnik1ImePrezime
		{
			get { return ViewState["pravvlasnik1ime"] == null ? "" : (string)ViewState["pravvlasnik1ime"]; }
			set { ViewState["pravvlasnik1ime"] = value; }
		}

		public string PravnaVlasnik2ImePrezime
		{
			get { return ViewState["pravvlasnik2ime"] == null ? "" : (string)ViewState["pravvlasnik2ime"]; }
			set { ViewState["pravvlasnik2ime"] = value; }
		}

		public string PravnaVlasnik3ImePrezime
		{
			get { return ViewState["pravvlasnik3ime"] == null ? "" : (string)ViewState["pravvlasnik3ime"]; }
			set { ViewState["pravvlasnik3ime"] = value; }
		}

		//private int ZahtjevID
		//{
		//	get
		//	{
		//		return Session["fondzahtjevID"] == null ? -1 : (int)Session["fondzahtjevID"];
		//	}
		//	set
		//	{
		//		Session["fondzahtjevID"] = value;
		//	}
		//}

		#endregion

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				IsFinalStep = false;

				if (Request.QueryString != null && Request.QueryString["fondID"] != null)
					FondID = Convert.ToInt32(Request.QueryString["fondID"]);

				//kupnja ili prodaja
				if (Session["zahtjevMod"] != null)
				{
					Kupnja = Session["zahtjevMod"].ToString() == "K";
					Session["zahtjevMod"] = null;
				}
				else if (Request.QueryString != null && Request.QueryString["mod"] != null)
					Kupnja = Request.QueryString["mod"].ToString() == "K";

				KontrolaMv().ActiveViewIndex = 0;

				KontrolaRbl("rblTipZahtjeva").SelectedValue = Kupnja ? "K" : "P";

				PostaviHeader();
			}
		}

		protected void btnNextStep_Click(object sender, EventArgs e)
		{
			PromijeniKorak(NEXT_STEP);
		}

		protected void btnPrevStep_Click(object sender, EventArgs e)
		{
			PromijeniKorak(PREV_STEP);
		}

		protected void mvFondKupnja_ActiveViewChanged(object sender, EventArgs e)
		{
			MultiView mv = (sender as MultiView);

			//btnNextStep.ValidationGroup = valSummaryKupnja.ValidationGroup = "Step" + mv.ActiveViewIndex;

			//ako je prvi korak, gumb nije vidljiv
			btnPrevStep.Visible = mv.ActiveViewIndex > 0;

			TrenutniKorak = (Korak)mv.ActiveViewIndex;

			if (IsZadnjiKorak()) //ako je zadnji korak
			{
				btnNextStep.Text = "Završi";
				//btnNextStep.OnClientClick = "if (typeof Page_ClientValidate !== 'function' || Page_ClientValidate()){ return confirm('Želite li unijeti zahtjev?')}";
				//btnNextStep.CausesValidation = false;
				btnNextStep.CssClass = "btn_navigation finish";
			}
			else
			{
				btnNextStep.Text = "Sljedeći korak";
				btnNextStep.OnClientClick = "";
				btnNextStep.CausesValidation = true;
				btnNextStep.CssClass = "btn_navigation next";
			}

			//označi trenutni korak
			if (mv.ActiveViewIndex >= 0)
			{
				//menu.Items[mv.ActiveViewIndex].Selected = true;
				KontrolaHTML("liStep0").Attributes["class"] = 
				KontrolaHTML("liStep1").Attributes["class"] = 
				KontrolaHTML("liStep2").Attributes["class"] = 
				KontrolaHTML("liStep3").Attributes["class"] = 
				KontrolaHTML("liStep4").Attributes["class"] =
				KontrolaHTML("liStep5").Attributes["class"] =
				KontrolaHTML("liStep6").Attributes["class"] =
				KontrolaHTML("liStep7").Attributes["class"] =
				KontrolaHTML("liStep8").Attributes["class"] =
				KontrolaHTML("liStep9").Attributes["class"] =
				KontrolaHTML("liStep10").Attributes["class"] = 
				KontrolaHTML("liStep11").Attributes["class"] = "";

				KontrolaHTML("liStep" + mv.ActiveViewIndex).Attributes["class"] = "selected";

				KontrolaHTML("liStep4").Visible =
				KontrolaHTML("liStep5").Visible = Kupnja;

				if (!Pravna)
				{
					KontrolaHTML("liStep2").Visible =
					KontrolaHTML("liStep7").Visible =
					KontrolaHTML("liStep8").Visible =
					KontrolaHTML("liStep9").Visible =
					KontrolaHTML("liStep10").Visible = false;

					KontrolaHTML("liStep6").Visible = FizickaPolitickiIzlozen;
				}
				else
				{
					KontrolaHTML("liStep6").Visible = false;

					KontrolaHTML("liStep2").Visible = SkupnoZastupanje;
					KontrolaHTML("liStep7").Visible = PravnaVlasnistvoPodijeljeno25Posto;
					KontrolaHTML("liStep8").Visible = PravnaVlasnik1PolitickiIzlozen;
					KontrolaHTML("liStep9").Visible = PravnaVlasnik2PolitickiIzlozen;
					KontrolaHTML("liStep10").Visible = PravnaVlasnik3PolitickiIzlozen;
				}
			}

			divKorisnikSpremanje.Visible = false;

			switch (mv.ActiveViewIndex)
			{
				case 0: InitKorak1(); break;
				case 1: InitKorak2(); break;
				case 2: InitKorak2a(); break;
				case 3: InitKorak3(); break;
				case 4: InitKorak4(); break;
				case 5: InitKorak5(); break;
				case 11: InitKorakZadnji(); break;
				default:
					break;
			}
		}

		private bool IsZadnjiKorak()
		{
			return TrenutniKorak == Korak.Z_Zadnje;

			/*if ( (TrenutniKorak == Korak.E_PolitIzl_Vlasnistvno_FizickaPravna && !FizickaPolitickiIzlozen) ||
				 (TrenutniKorak == Korak.F_PolitIzlozenostFizicka)
				)
				return true;

			return false;*/
		}

		private void PromijeniKorak(int korakDelta)
		{
			MultiView mv = KontrolaMv();

			SpremanjeUnesenihPodatakaKorisnika();

			SpremiOdabirUnutarKoraka();

			if (korakDelta > 0) //korak naprijed
			{
				
					switch (TrenutniKorak)
					{
						case Korak.A_Uvod:
							mv.ActiveViewIndex = (int)Korak.B_OsobniPodaci;
							break;
						case Korak.B_OsobniPodaci:
							mv.ActiveViewIndex = SkupnoZastupanje ? (int)Korak.B2_PodaciDrugeOsobe : (int)Korak.C_Placanje;
							break;
						case Korak.B2_PodaciDrugeOsobe:
							mv.ActiveViewIndex = (int)Korak.C_Placanje;
							break;
						case Korak.C_Placanje:
							if(!Kupnja)
								mv.ActiveViewIndex = (int)Korak.Z_Zadnje;
							else
								mv.ActiveViewIndex = (int)Korak.D_PranjeNovcaFizickaPravna;
							break;
						case Korak.D_PranjeNovcaFizickaPravna:
							mv.ActiveViewIndex = (int)Korak.E_PolitIzl_Vlasnistvno_FizickaPravna;
							break;
						case Korak.E_PolitIzl_Vlasnistvno_FizickaPravna:
							if (!Pravna)
								mv.ActiveViewIndex = FizickaPolitickiIzlozen ? (int)Korak.F_PolitIzlozenostFizicka : (int)Korak.Z_Zadnje;
							else
							{
								mv.ActiveViewIndex = PravnaVlasnistvoPodijeljeno25Posto ? (int)Korak.G_StvarniVlasniciPravna : (int)Korak.Z_Zadnje;
							}
							break;
						case Korak.F_PolitIzlozenostFizicka:
							mv.ActiveViewIndex = (int)Korak.Z_Zadnje;
							break;
						case Korak.G_StvarniVlasniciPravna:
							if (PravnaVlasnik1PolitickiIzlozen)
								mv.ActiveViewIndex = (int)Korak.G1_Vlasnik1PolitIzlozenost;
							else if (PravnaVlasnik2PolitickiIzlozen)
								mv.ActiveViewIndex = (int)Korak.G2_Vlasnik2PoliitIzlozenost;
							else if (PravnaVlasnik3PolitickiIzlozen)
								mv.ActiveViewIndex = (int)Korak.G3_Vlasnik3PolitIzlozenost;
							else
								mv.ActiveViewIndex = (int)Korak.Z_Zadnje;
							break;
						case Korak.G1_Vlasnik1PolitIzlozenost:
							if (PravnaVlasnik2PolitickiIzlozen)
								mv.ActiveViewIndex = (int)Korak.G2_Vlasnik2PoliitIzlozenost;
							else if (PravnaVlasnik3PolitickiIzlozen)
								mv.ActiveViewIndex = (int)Korak.G3_Vlasnik3PolitIzlozenost;
							else
								mv.ActiveViewIndex = (int)Korak.Z_Zadnje;
							break;
						case Korak.G2_Vlasnik2PoliitIzlozenost:
							if (PravnaVlasnik3PolitickiIzlozen)
								mv.ActiveViewIndex = (int)Korak.G3_Vlasnik3PolitIzlozenost;
							else
								mv.ActiveViewIndex = (int)Korak.Z_Zadnje;
							break;
						case Korak.G3_Vlasnik3PolitIzlozenost:
							mv.ActiveViewIndex = (int)Korak.Z_Zadnje;
							break;
						case Korak.Z_Zadnje:
							FormView1.InsertItem(true);
							break;
					}
			}
			else //korak nazad
			{
				switch (TrenutniKorak)
				{
					case Korak.A_Uvod:
						break;
					case Korak.B_OsobniPodaci:
						mv.ActiveViewIndex = (int)Korak.A_Uvod;
						break;
					case Korak.B2_PodaciDrugeOsobe:
						mv.ActiveViewIndex = (int)Korak.B_OsobniPodaci;
						break;
					case Korak.C_Placanje:
						mv.ActiveViewIndex = SkupnoZastupanje ? (int)Korak.B2_PodaciDrugeOsobe : (int)Korak.B_OsobniPodaci;
						break;
					case Korak.D_PranjeNovcaFizickaPravna:
						mv.ActiveViewIndex = (int)Korak.C_Placanje;
						break;
					case Korak.E_PolitIzl_Vlasnistvno_FizickaPravna:
						mv.ActiveViewIndex = (int)Korak.D_PranjeNovcaFizickaPravna;
						break;
					case Korak.F_PolitIzlozenostFizicka:
						mv.ActiveViewIndex = (int)Korak.E_PolitIzl_Vlasnistvno_FizickaPravna;
						break;
					case Korak.G_StvarniVlasniciPravna:
						mv.ActiveViewIndex = (int)Korak.E_PolitIzl_Vlasnistvno_FizickaPravna;
						break;
					case Korak.G1_Vlasnik1PolitIzlozenost:
						mv.ActiveViewIndex = (int)Korak.G_StvarniVlasniciPravna;
						break;
					case Korak.G2_Vlasnik2PoliitIzlozenost:
						if(PravnaVlasnik1PolitickiIzlozen)
							mv.ActiveViewIndex = (int)Korak.G1_Vlasnik1PolitIzlozenost;
						else
							mv.ActiveViewIndex = (int)Korak.G_StvarniVlasniciPravna;
						break;
					case Korak.G3_Vlasnik3PolitIzlozenost:
						if(PravnaVlasnik2PolitickiIzlozen)
							mv.ActiveViewIndex = (int)Korak.G2_Vlasnik2PoliitIzlozenost;
						else if (PravnaVlasnik1PolitickiIzlozen)
							mv.ActiveViewIndex = (int)Korak.G1_Vlasnik1PolitIzlozenost;
						else
							mv.ActiveViewIndex = (int)Korak.G_StvarniVlasniciPravna;
						break;
					case Korak.Z_Zadnje:
						if (Kupnja)
						{
							if (!Pravna)
								mv.ActiveViewIndex = FizickaPolitickiIzlozen ? (int)Korak.F_PolitIzlozenostFizicka : (int)Korak.E_PolitIzl_Vlasnistvno_FizickaPravna;
							else
							{
								if (!PravnaVlasnistvoPodijeljeno25Posto)
									mv.ActiveViewIndex = (int)Korak.E_PolitIzl_Vlasnistvno_FizickaPravna;
								else if (PravnaVlasnik3PolitickiIzlozen)
									mv.ActiveViewIndex = (int)Korak.G3_Vlasnik3PolitIzlozenost;
								else if (PravnaVlasnik2PolitickiIzlozen)
									mv.ActiveViewIndex = (int)Korak.G2_Vlasnik2PoliitIzlozenost;
								else if (PravnaVlasnik1PolitickiIzlozen)
									mv.ActiveViewIndex = (int)Korak.G1_Vlasnik1PolitIzlozenost;
								else
									mv.ActiveViewIndex = (int)Korak.G_StvarniVlasniciPravna;
							}
						}
						else
							mv.ActiveViewIndex = (int)Korak.C_Placanje;
						break;
				}
			}
		}

		/// <summary>
		/// Spremanje odabira unutar trenutnog koraka
		/// </summary>
		private void SpremiOdabirUnutarKoraka()
		{
			if (TrenutniKorak == Korak.A_Uvod)
			{
				DropDownList ddlFond = KontrolaDdl("ddlfondovi");

				Pravna = KontrolaRbl("rblPravna").SelectedValue == "P";
				Rezident = KontrolaRbl("rblRezident").SelectedValue == "R";
				FondID = Convert.ToInt32(ddlFond.SelectedValue);

				Kupnja = KontrolaRbl("rblTipZahtjeva").SelectedValue == "K";

				PostaviHeader(ddlFond.SelectedItem.Text);
			}
			else if (TrenutniKorak == Korak.B_OsobniPodaci)
			{
				SkupnoZastupanje = Pravna && KontrolaRbl("rblPravnaZastupanjePojedinacno").SelectedValue == "S";
			}
			else if (TrenutniKorak == Korak.E_PolitIzl_Vlasnistvno_FizickaPravna)
			{
				PravnaVlasnistvoPodijeljeno25Posto = Pravna && KontrolaRbl("VLASNISTVO_PODIJELJENORbl").SelectedValue == "D";
				FizickaPolitickiIzlozen = !Pravna && KontrolaRbl("POLITICKA_IZLOZENOSTRbl").SelectedValue == "D";
			}
			else if (TrenutniKorak == Korak.G_StvarniVlasniciPravna)
			{
				PravnaVlasnik2Postoji = KontrolaCb("chkVlasnik2").Checked;
				PravnaVlasnik3Postoji = KontrolaCb("chkVlasnik3").Checked;
				PravnaVlasnik1PolitickiIzlozen = KontrolaRbl("rblVlasnik1PolitickiIzlozen").SelectedValue == "D";
				PravnaVlasnik2PolitickiIzlozen = PravnaVlasnik2Postoji && KontrolaRbl("rblVlasnik2PolitickiIzlozen").SelectedValue == "D";
				PravnaVlasnik3PolitickiIzlozen = PravnaVlasnik3Postoji && KontrolaRbl("rblVlasnik3PolitickiIzlozen").SelectedValue == "D";

				PravnaVlasnik1ImePrezime = KontrolaTxt("txtPravnaVlasnik1ImePRezime").Text;
				PravnaVlasnik2ImePrezime = PravnaVlasnik2Postoji ? KontrolaTxt("txtPravnaVlasnik2ImePRezime").Text : null;
				PravnaVlasnik3ImePrezime = PravnaVlasnik3Postoji ? KontrolaTxt("txtPravnaVlasnik3ImePRezime").Text : null;
			}
		}

		private void SpremanjeUnesenihPodatakaKorisnika()
		{
			var k = KorisnikUneseniPodaci;

			if (TrenutniKorak == Korak.A_Uvod)
			{
				k.PRAVNA = KontrolaRbl("rblPravna").SelectedValue;
				k.REZIDENTNOST = KontrolaRbl("rblRezident").SelectedValue;
			}
			else if (TrenutniKorak == Korak.B_OsobniPodaci)
			{
				if (Pravna)
				{
					//osnovni podaci
					k.IME = KontrolaTxt("PRAVNA_IMETextBox").Text;
					k.MB = KontrolaTxt("PRAVNA_MBTextBox").Text;
					k.OIB = KontrolaTxt("PRAVNA_OIBTextBox").Text;
					k.ADRESA_ULICA = KontrolaTxt("PRAVNA_ADRESA_ULICATextBox").Text;
					k.ADRESA_KUCNI_BROJ = KontrolaTxt("PRAVNA_ADRESA_KUCNI_BROJTextBox").Text;
					k.ADRESA_POSTANSKI_BROJ = KontrolaTxt("PRAVNA_ADRESA_POSTANSKI_BROJTextBox").Text;
					k.ADRESA_MJESTO = KontrolaTxt("PRAVNA_ADRESA_MJESTOTextBox").Text;
					k.ADRESA_DRZAVA = KontrolaTxt("PRAVNA_ADRESA_DRZAVATextBox").Text;

					//kontakt
					k.TELEFON = KontrolaTxt("PRAVNA_TELEFONTextBox").Text;
					k.MOBITEL = KontrolaTxt("PRAVNA_MOBITELTextBox").Text;
					k.FAX = KontrolaTxt("PRAVNA_FAXTextBox").Text;
					k.KONTAKT_EMAIL = KontrolaTxt("PRAVNA_EMAILTextBox").Text;

					//podaci fizičke osobe
					k.ZASTUPNIK_IME = KontrolaTxt("FIZICKA_IMETextBox").Text;
					k.ZASTUPNIK_PREZIME = KontrolaTxt("FIZICKA_PREZIMETextBox").Text;
					k.ZASTUPNIK_JMBG = KontrolaTxt("FIZICKA_JMBGTextBox").Text;
					k.ZASTUPNIK_OIB = KontrolaTxt("FIZICKA_OIBTextBox").Text;

					//prebivalište
					k.ZASTUPNIK_ADRESA_ULICA = KontrolaTxt("FIZICKA_ADRESA_ULICATextBox").Text;
					k.ZASTUPNIK_ADRESA_KUCNI_BROJ = KontrolaTxt("FIZICKA_ADRESA_KUCNI_BROJTextBox").Text;
					k.ZASTUPNIK_ADRESA_P_BROJ = KontrolaTxt("FIZICKA_ADRESA_POSTANSKI_BROJTextBox").Text;
					k.ZASTUPNIK_ADRESA_MJESTO = KontrolaTxt("FIZICKA_ADRESA_MJESTOTextBox").Text;
					k.ZASTUPNIK_ADRESA_DRZAVA = KontrolaTxt("FIZICKA_ADRESA_DRZAVATextBox").Text;

					//kontakt
					k.ZASTUPNIK_TELEFON = KontrolaTxt("FIZICKA_TELEFONTextBox").Text;
					k.ZASTUPNIK_MOBITEL = KontrolaTxt("FIZICKA_MOBITELTextBox").Text;
					k.ZASTUPNIK_FAX = KontrolaTxt("FIZICKA_FAXTextBox").Text;
					k.ZASTUPNIK_EMAIL = KontrolaTxt("FIZICKA_EMAILTextBox").Text;
				}
				else
				{
					//podaci fizičke osobe
					k.IME = KontrolaTxt("FIZICKA_IMETextBox").Text;
					k.PREZIME = KontrolaTxt("FIZICKA_PREZIMETextBox").Text;
					k.MB = KontrolaTxt("FIZICKA_JMBGTextBox").Text;
					k.OIB = KontrolaTxt("FIZICKA_OIBTextBox").Text;

					//prebivalište
					k.ADRESA_ULICA = KontrolaTxt("FIZICKA_ADRESA_ULICATextBox").Text;
					k.ADRESA_KUCNI_BROJ = KontrolaTxt("FIZICKA_ADRESA_KUCNI_BROJTextBox").Text;
					k.ADRESA_POSTANSKI_BROJ = KontrolaTxt("FIZICKA_ADRESA_POSTANSKI_BROJTextBox").Text;
					k.ADRESA_MJESTO = KontrolaTxt("FIZICKA_ADRESA_MJESTOTextBox").Text;
					k.ADRESA_DRZAVA = KontrolaTxt("FIZICKA_ADRESA_DRZAVATextBox").Text;

					//kontakt
					k.TELEFON = KontrolaTxt("FIZICKA_TELEFONTextBox").Text;
					k.MOBITEL = KontrolaTxt("FIZICKA_MOBITELTextBox").Text;
					k.FAX = KontrolaTxt("FIZICKA_FAXTextBox").Text;
					k.KONTAKT_EMAIL = KontrolaTxt("FIZICKA_EMAILTextBox").Text;
				}

				k.FIZICKA_DOKUMENT_TIP = KontrolaDdl("FIZICKA_DOKUMENT_TIP").SelectedValue;
				k.FIZICKA_DOKUMENT_BROJ = KontrolaTxt("FIZICKA_DOKUMENT_BROJTextBox").Text;
				k.FIZICKA_DOKUMENT_IZDAVATELJ = KontrolaTxt("FIZICKA_DOKUMENT_IZDAVATELJTextBox").Text;
				k.FIZICKA_DOKUMENT_VRIJEDI_DO = Utility.StringToDateTime(KontrolaTxt("FIZICKA_DOKUMENT_VRIJEDI_DOTextBox").Text);

				//rođenje
				k.FIZICKA_DATUM_RODENJA = Utility.StringToDateTime(KontrolaTxt("FIZICKA_DATUM_RODENJATextBox").Text);
				k.FIZICKA_MJESTO_RODENJA = KontrolaTxt("FIZICKA_MJESTO_RODENJATextBox").Text;
				k.FIZICKA_DRZAVA_RODENJA = KontrolaTxt("FIZICKA_DRZAVA_RODENJATextBox").Text;
				k.FIZICKA_DRZAVLJANSTVO = KontrolaTxt("FIZICKA_DRZAVLJANSTVOTextBox").Text;

				//adresa za slanje
				k.ADRESA_SLANJE_ULICA = KontrolaTxt("ADRESA_SLANJE_ULICATextBox").Text;
				k.ADRESA_SLANJE_KUCNI_BROJ = KontrolaTxt("ADRESA_SLANJE_KUCNI_BROJTextBox").Text;
				k.ADRESA_SLANJE_POSTANSKI_BROJ = KontrolaTxt("ADRESA_SLANJE_POSTANSKI_BROJTextBox").Text;
				k.ADRESA_SLANJE_MJESTO = KontrolaTxt("ADRESA_SLANJE_MJESTOTextBox").Text;
				k.ADRESA_SLANJE_DRZAVA = KontrolaTxt("ADRESA_SLANJE_DRZAVATextBox").Text;
			}
			else if (TrenutniKorak == Korak.C_Placanje)
			{
				//k.RACUN_VBDI = KontrolaTxt("VBDITextBox").Text;
				k.RACUN_BROJ = KontrolaTxt("RACUN_BROJTextBox").Text;
			}
			else if (TrenutniKorak == Korak.D_PranjeNovcaFizickaPravna)
			{
				if (Pravna)
				{
					k.PRAVNA_PLANIRANA_GOD_ULAGANJA = KontrolaDdl("PRAVNA_PLANIRANA_GOD_ULAGANJA").SelectedValue;
				}
				else
				{
					k.FIZICKA_STATUS_ODABIR = KontrolaDdl("DropDownList1FIZICKA_STATUS_ODABIR").SelectedValue;
					k.FIZICKA_VRSTA_POSLODAVCA = KontrolaDdl("FIZICKA_VRSTA_POSLODAVCA").SelectedValue;
					k.FIZICKA_STRUCNA_SPREMA = KontrolaDdl("FIZICKA_STRUCNA_SPREMA").SelectedValue;
					k.FIZICKA_ZVANJE = KontrolaTxt("FIZICKA_ZVANJETextBox").Text;
					k.FIZICKA_ZANIMANJE = KontrolaTxt("FIZICKA_ZANIMANJETextBox").Text;
					k.FIZICKA_PLANIRANA_GOD_ULAGANJA = KontrolaDdl("FIZICKA_PLANIRANA_GOD_ULAGANJA").SelectedValue;
					k.FIZICKA_SREDSTVA_OSTVARENA = KontrolaDdl("FIZICKA_SREDSTVA_OSTVARENA").SelectedValue;
				}
			}
			else if (TrenutniKorak == Korak.E_PolitIzl_Vlasnistvno_FizickaPravna)
			{
				if(Pravna)
					k.PRAVNA_VLASNISTVO_PODIJELJENO = KontrolaRbl("VLASNISTVO_PODIJELJENORbl").SelectedValue;
				else
					k.FIZICKA_POLITICKA_IZLOZENOST = KontrolaRbl("POLITICKA_IZLOZENOSTRbl").SelectedValue;
			}

			KorisnikUneseniPodaci = k;
		}

		private void PostaviHeader(string fondNaziv = "")
		{
			formHeader.InnerText = (Kupnja ? "Kupnja" : "Prodaja") + " udjela u fondu" + (fondNaziv.IsNullOrEmpty() ? "" : " " + fondNaziv);
			this.Page.Title = formHeader.InnerText + " | InvestApp";
		}

		#region Init korakâ

		private void InitKorak1()
		{
			if (!Korak1Init)
			{
				if (FondID > 0)
					KontrolaDdl("ddlFondovi").SelectedValue = FondID.ToString();

				////kupnja ili prodaja
				//if (Session["zahtjevMod"] != null)
				//{
				//	Kupnja = (Request.QueryString != null && Request.QueryString["mod"] != null && Request.QueryString["mod"].ToString() == "K") || Session["zahtjevMod"].ToString() == "K";
				//	KontrolaRbl("rblTipZahtjeva").SelectedValue = Session["zahtjevMod"].ToString();
				//	KontrolaHTML("divTipZahtjeva").Visible = false;
				//	Session["zahtjevMod"] = null;
				//}

				//PostaviHeader();

				DAL.Korisnik kor = DAL.FondDAC.VratiKorisnika(KorisnikID);

				if (kor != null)
				{
					//postavi pravna / rezidentnost
					KontrolaRbl("rblPravna").SelectedValue = kor.PRAVNA;
					KontrolaRbl("rblRezident").SelectedValue = kor.REZIDENTNOST;
				}

				Korak1Init = true;
			}

			KorisnikUneseniPodaci = null;
			Korak2Init = Korak2aInit = Korak3Init = Korak4Init = Korak5Init = false;
			SkupnoZastupanje = false;
			FizickaPolitickiIzlozen =
			PravnaVlasnistvoPodijeljeno25Posto =
			PravnaVlasnik2Postoji =
			PravnaVlasnik3Postoji =
			PravnaVlasnik1PolitickiIzlozen =
			PravnaVlasnik2PolitickiIzlozen =
			PravnaVlasnik3PolitickiIzlozen = false;

			PravnaVlasnik1ImePrezime = PravnaVlasnik2ImePrezime = PravnaVlasnik3ImePrezime = null;

		}

		private void InitKorak2()
		{
			HtmlGenericControl divPravna = FormView1.FindControl("pravnaPodaci") as HtmlGenericControl;
			divPravna.Visible = Pravna;
			KontrolaHTML("divPravnaZastupanjePojedinacno").Visible = Pravna;

			DAL.Korisnik k = DAL.FondDAC.VratiKorisnika(KorisnikID);

			if (k != null && !Korak2Init)
			{
				if (Pravna)
				{

					//osnovni podaci
					KontrolaTxt("PRAVNA_IMETextBox").Text = k.IME;
					KontrolaTxt("PRAVNA_MBTextBox").Text = k.MB;
					KontrolaTxt("PRAVNA_OIBTextBox").Text = k.OIB;
					KontrolaTxt("PRAVNA_ADRESA_ULICATextBox").Text = k.ADRESA_ULICA;
					KontrolaTxt("PRAVNA_ADRESA_KUCNI_BROJTextBox").Text = k.ADRESA_KUCNI_BROJ;
					KontrolaTxt("PRAVNA_ADRESA_POSTANSKI_BROJTextBox").Text = k.ADRESA_POSTANSKI_BROJ;
					KontrolaTxt("PRAVNA_ADRESA_MJESTOTextBox").Text = k.ADRESA_MJESTO;
					KontrolaTxt("PRAVNA_ADRESA_DRZAVATextBox").Text = k.ADRESA_DRZAVA;

					//kontakt
					KontrolaTxt("PRAVNA_TELEFONTextBox").Text = k.TELEFON;
					KontrolaTxt("PRAVNA_MOBITELTextBox").Text = k.MOBITEL;
					KontrolaTxt("PRAVNA_FAXTextBox").Text = k.FAX;
					KontrolaTxt("PRAVNA_EMAILTextBox").Text = k.KONTAKT_EMAIL;

					//KontrolaRbl("rblPravnaZastupanjePojedinacno").SelectedValue
				}

				//nerezidenti ne trebaju unijeti JMBG i OIB
				if (!Rezident)
				{
					KontrolaVal("reqValJMBG").Enabled = false;
					KontrolaVal("reqValOIB").Enabled = false;
				}
				else
				{
					KontrolaVal("reqValJMBG").Enabled = true;
					KontrolaVal("reqValOIB").Enabled = true;
				}

				//podaci fizičke osobe
				KontrolaTxt("FIZICKA_IMETextBox").Text = Pravna ? k.ZASTUPNIK_IME : k.IME;
				KontrolaTxt("FIZICKA_PREZIMETextBox").Text = Pravna ? k.ZASTUPNIK_PREZIME : k.PREZIME;
				KontrolaTxt("FIZICKA_JMBGTextBox").Text = Pravna ? k.ZASTUPNIK_JMBG : k.MB;
				KontrolaTxt("FIZICKA_OIBTextBox").Text = Pravna ? k.ZASTUPNIK_OIB : k.OIB;
				KontrolaDdl("FIZICKA_DOKUMENT_TIP").SelectedValue = k.FIZICKA_DOKUMENT_TIP;
				KontrolaTxt("FIZICKA_DOKUMENT_BROJTextBox").Text = k.FIZICKA_DOKUMENT_BROJ;
				KontrolaTxt("FIZICKA_DOKUMENT_IZDAVATELJTextBox").Text = k.FIZICKA_DOKUMENT_IZDAVATELJ;
				KontrolaTxt("FIZICKA_DOKUMENT_VRIJEDI_DOTextBox").Text = Utility.DateTimeToString(k.FIZICKA_DOKUMENT_VRIJEDI_DO);

				//prebivalište
				KontrolaTxt("FIZICKA_ADRESA_ULICATextBox").Text = Pravna ? k.ZASTUPNIK_ADRESA_ULICA : k.ADRESA_ULICA;
				KontrolaTxt("FIZICKA_ADRESA_KUCNI_BROJTextBox").Text = Pravna ? k.ZASTUPNIK_ADRESA_KUCNI_BROJ : k.ADRESA_KUCNI_BROJ;
				KontrolaTxt("FIZICKA_ADRESA_POSTANSKI_BROJTextBox").Text = Pravna ? k.ZASTUPNIK_ADRESA_P_BROJ : k.ADRESA_POSTANSKI_BROJ;
				KontrolaTxt("FIZICKA_ADRESA_MJESTOTextBox").Text = Pravna ? k.ZASTUPNIK_ADRESA_MJESTO : k.ADRESA_MJESTO;
				KontrolaTxt("FIZICKA_ADRESA_DRZAVATextBox").Text = Pravna ? k.ZASTUPNIK_ADRESA_DRZAVA : k.ADRESA_DRZAVA;

				//rođenje
				KontrolaTxt("FIZICKA_DATUM_RODENJATextBox").Text = Utility.DateTimeToString(k.FIZICKA_DATUM_RODENJA);
				KontrolaTxt("FIZICKA_MJESTO_RODENJATextBox").Text = k.FIZICKA_MJESTO_RODENJA;
				KontrolaTxt("FIZICKA_DRZAVA_RODENJATextBox").Text = k.FIZICKA_DRZAVA_RODENJA;
				KontrolaTxt("FIZICKA_DRZAVLJANSTVOTextBox").Text = k.FIZICKA_DRZAVLJANSTVO;

				//kontakt
				KontrolaTxt("FIZICKA_TELEFONTextBox").Text = Pravna ? k.ZASTUPNIK_TELEFON : k.TELEFON;
				KontrolaTxt("FIZICKA_MOBITELTextBox").Text = Pravna ? k.ZASTUPNIK_MOBITEL : k.MOBITEL;
				KontrolaTxt("FIZICKA_FAXTextBox").Text = Pravna ? k.ZASTUPNIK_FAX : k.FAX;
				KontrolaTxt("FIZICKA_EMAILTextBox").Text = Pravna ? k.ZASTUPNIK_EMAIL : k.KONTAKT_EMAIL;

				//adresa za slanje
				KontrolaTxt("ADRESA_SLANJE_ULICATextBox").Text = k.ADRESA_SLANJE_ULICA;
				KontrolaTxt("ADRESA_SLANJE_KUCNI_BROJTextBox").Text = k.ADRESA_SLANJE_KUCNI_BROJ;
				KontrolaTxt("ADRESA_SLANJE_POSTANSKI_BROJTextBox").Text = k.ADRESA_SLANJE_POSTANSKI_BROJ;
				KontrolaTxt("ADRESA_SLANJE_MJESTOTextBox").Text = k.ADRESA_SLANJE_MJESTO;
				KontrolaTxt("ADRESA_SLANJE_DRZAVATextBox").Text = k.ADRESA_SLANJE_DRZAVA;

				Korak2Init = true;
			}
		}

		/// <summary>
		/// Podaci druge osobe skupnog zastupanja
		/// </summary>
		private void InitKorak2a()
		{
			DAL.Korisnik k = DAL.FondDAC.VratiKorisnika(KorisnikID);

			if (k != null && !Korak2aInit)
			{

				Korak2aInit = true;
			}
		}

		private void InitKorak3()
		{
			if (!Korak3Init)
			{
				////dohvati banke
				//DropDownList ddlBanke = KontrolaDdl("ddlBanke");
				//ddlBanke.DataSource = DAL.FondDAC.VratiBankeDS();
				//ddlBanke.DataBind();

				DAL.Korisnik k = DAL.FondDAC.VratiKorisnika(KorisnikID);

				if (k != null)
				{
					//ddlBanke.SelectedValue = k.RACUN_VBDI;
					//KontrolaTxt("VBDITextBox").Text = k.RACUN_VBDI;
					KontrolaTxt("RACUN_BROJTextBox").Text = k.RACUN_BROJ;
				}

				Korak3Init = true;
			}

			if (Kupnja)
			{
				KontrolaHTML("divIznos").Visible = true;
				KontrolaHTML("divBrojUdjela").Visible = false;
			}
			else
			{
				KontrolaHTML("divIznos").Visible = false;
				KontrolaHTML("divBrojUdjela").Visible = true;

				decimal maxBrUdjela = DAL.FondDAC.VratiBrojUdjela(KorisnikID, FondID, DateTime.Today);
				KontrolaValRange("valBrUdjelaMax").MaximumValue = ((int)maxBrUdjela).ToString();
				KontrolaValRange("valBrUdjelaMax").ErrorMessage = "Max broj udjela: " + ((int)maxBrUdjela).ToString("n0");

				KontrolaTxt("ZELJENI_BROJ_UDJELATextBox").Text = ((int)maxBrUdjela).ToString();
			}

		}

		private void InitKorak4()
		{
			DAL.Korisnik k = DAL.FondDAC.VratiKorisnika(KorisnikID);

			if (Pravna)
			{
				KontrolaHTML("divOstaloFizicka").Visible = false;
				KontrolaHTML("ostaloPravna").Visible = true;
			}
			else
			{
				KontrolaHTML("divOstaloFizicka").Visible = true;
				KontrolaHTML("ostaloPravna").Visible = false;
			}

			if (!Korak4Init && k != null)
			{
				if (!Pravna)
				{
					KontrolaDdl("DropDownList1FIZICKA_STATUS_ODABIR").SelectedValue = k.FIZICKA_STATUS_ODABIR;
					KontrolaDdl("FIZICKA_VRSTA_POSLODAVCA").SelectedValue = k.FIZICKA_VRSTA_POSLODAVCA;
					KontrolaDdl("FIZICKA_STRUCNA_SPREMA").SelectedValue = k.FIZICKA_STRUCNA_SPREMA;
					KontrolaTxt("FIZICKA_ZVANJETextBox").Text = k.FIZICKA_ZVANJE;
					KontrolaTxt("FIZICKA_ZANIMANJETextBox").Text = k.FIZICKA_ZANIMANJE;
					KontrolaDdl("FIZICKA_PLANIRANA_GOD_ULAGANJA").SelectedValue = k.FIZICKA_PLANIRANA_GOD_ULAGANJA;
					KontrolaDdl("FIZICKA_SREDSTVA_OSTVARENA").SelectedValue = k.FIZICKA_SREDSTVA_OSTVARENA;
					//KontrolaRbl("POLITICKA_IZLOZENOSTRbl").SelectedValue = k.FIZICKA_POLITICKA_IZLOZENOST;
				}
				else
				{
					KontrolaDdl("PRAVNA_PLANIRANA_GOD_ULAGANJA").SelectedValue = k.PRAVNA_PLANIRANA_GOD_ULAGANJA;
					//KontrolaRbl("VLASNISTVO_PODIJELJENORbl").SelectedValue = k.PRAVNA_VLASNISTVO_PODIJELJENO;
				}

				Korak4Init = true;
			}
		}

		private void InitKorak5()
		{
			DAL.Korisnik k = DAL.FondDAC.VratiKorisnika(KorisnikID);

			if (Pravna)
			{
				KontrolaHTML("divPravnaZadnje").Visible = true;
				KontrolaHTML("divFizickaZadnje").Visible = false;
			}
			else
			{
				KontrolaHTML("divPravnaZadnje").Visible = false;
				KontrolaHTML("divFizickaZadnje").Visible = true;
			}

			if (!Korak5Init && k != null)
			{
				if (Pravna)
				{
					KontrolaRbl("VLASNISTVO_PODIJELJENORbl").SelectedValue = k.PRAVNA_VLASNISTVO_PODIJELJENO;
				}
				else
				{
					KontrolaRbl("POLITICKA_IZLOZENOSTRbl").SelectedValue = k.FIZICKA_POLITICKA_IZLOZENOST;
				}

				Korak5Init = true;
			}
		}
		
		private void InitKorakZadnji()
		{
			if (KorisnikID > 0)
			{
				bool promijenjeno = DAL.KorisnikDAC.KorisnikPromijenjeniPodaci(KorisnikID, KorisnikUneseniPodaci);

				if (promijenjeno)
				{
					divKorisnikSpremanje.Visible = true;
					return;
				}
			}

			//FormView1.InsertItem(true);
		}
		
		#endregion Init korakâ

		#region Dohvat kontrolâ

		private Control Kontrola(string kontrolaID)
		{
			return FormView1.FindControl(kontrolaID);
		}

		private MultiView KontrolaMv()
		{
			return Kontrola("mvFondKupnja") as MultiView;
		}

		private TextBox KontrolaTxt(string kontrolaID)
		{
			return Kontrola(kontrolaID) as TextBox;
		}

		private DropDownList KontrolaDdl(string kontrolaID)
		{
			return Kontrola(kontrolaID) as DropDownList;
		}

		private RadioButtonList KontrolaRbl(string kontrolaID)
		{
			return Kontrola(kontrolaID) as RadioButtonList;
		}

		private CheckBox KontrolaCb(string kontrolaID)
		{
			return Kontrola(kontrolaID) as CheckBox;
		}

		private HtmlGenericControl KontrolaHTML(string kontrolaID)
		{
			return Kontrola(kontrolaID) as HtmlGenericControl;
		}

		private RequiredFieldValidator KontrolaVal(string kontrolaID)
		{
			return Kontrola(kontrolaID) as RequiredFieldValidator;
		}

		private RangeValidator KontrolaValRange(string kontrolaID)
		{
			return Kontrola(kontrolaID) as RangeValidator;
		}
		
		#endregion Dohvat kontrolâ

		protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
			
		}

		protected void EntityDataSourceZahtjev_Inserted(object sender, EntityDataSourceChangedEventArgs e)
		{
			string akcija = Kupnja ? "kupnju" : "prodaju";

			if (e.Exception == null)
			{
				PorukaText = "Zahtjev je uspješno unesen.";

				var zahtjev = (e.Entity as DAL.FondZahtjev);

				Session["fondzahtjevID"] = zahtjev.ID;

				Log("Podnesen zahtjev za " + akcija + ". ID=" + zahtjev.ID);

				//spremanje promijenjenih podataka korisnika
				if (rblKorisnikPodaciSpremi.SelectedValue == "D")
					DAL.KorisnikDAC.KorisnikAzuriraj(KorisnikID, KorisnikUneseniPodaci);
			}
			else
			{
				PorukaText = "Dogodila se greška pri unosu zahtjeva. " + e.Exception.Message;

				if (e.Exception.InnerException != null)
					PorukaText += ". " + e.Exception.InnerException.Message;

				Log( string.Format("Greška pri zahtjevu za {0}. Greška: {1}\n{2}", akcija, e.Exception.Message, e.Exception.StackTrace));
			}

			Response.Redirect(ResolveUrl("~/Fond/FondZahtjevPoruka.aspx"));

		}

		protected void EntityDataSourceZahtjev_Inserting(object sender, EntityDataSourceChangingEventArgs e)
		{
			(e.Entity as DAL.FondZahtjev).PODNOSENJE_KORISNIK_ID = KorisnikID;
		}


	}
}