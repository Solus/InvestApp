using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Security;
using DevExpress.Web.ASPxGridView;

namespace InvestApp.Web
{
    public partial class FondPregledCtrl : System.Web.UI.UserControl
    {
		DateTime vrijemeFondovi;

		public UIControls.InvestAppPage Roditelj
		{
			get
			{
				return (this.Page as UIControls.InvestAppPage);
			}
		}

        protected void Page_Load(object sender, EventArgs e)
        {
			vrijemeFondovi = DateTime.Now;

            if (!IsPostBack)
            {
				////dodaj includove
				//LiteralControl jsResource1 = new LiteralControl();
				//jsResource1.Text = @"<script src=""../includes/jquery-1.11.0.min.js""></script>";
				//Page.Header.Controls.Add(jsResource1);

				//LiteralControl jsResource2 = new LiteralControl();
				//jsResource2.Text = @"<script src=""../includes/jquery-migrate-1.2.1.min.js""></script>";
				//Page.Header.Controls.Add(jsResource2);

				//LiteralControl jsResource3 = new LiteralControl();
				//jsResource3.Text = @"<script src=""../includes/thickbox.js""></script>";
				//Page.Header.Controls.Add(jsResource3);

				//LiteralControl cssResource = new LiteralControl();
				//cssResource.Text = @"<link href=""../includes/thickbox.css"" rel=""stylesheet"" />";
				//Page.Header.Controls.Add(cssResource);

                Session["fondID"] = null;
                gvFondovi.Columns["PTG"].Caption = DateTime.Today.Year.ToString() + ".";
                gvFondovi.DataBind();
            }

			gvFondovi.Columns["Portfelj"].Visible =
			gvFondovi.Columns["Ispravka"].Visible = Roditelj.KorisnikJeAdmin || Roditelj.KorisnikJeDrustvo;
			gvFondovi.Columns["Brisanje"].Visible =
            gvFondovi.Columns["Sakriveni"].Visible = Roditelj.KorisnikJeAdmin;
			gvFondovi.Columns["FavoritOznaka"].Visible = HttpContext.Current.User.Identity.IsAuthenticated;
        }

		protected void gvFondovi_DataBinding(object sender, EventArgs e)
		{
			//logiranje
			vrijemeFondovi = DateTime.Now;

			//odredi odabranu kategoriju
			int? kategorijaID = null, regijaID = null, ulaganjeID = null, upravljanjeID = null, ciljPrinosaID = null, sektorID = null, trzisteID = null, profilRizicnostiID = null;

			if (menuKat.SelectedItem != null)
				kategorijaID = Common.Utility.StringToInt(menuKat.SelectedItem.Value);

			if (rblRegija.SelectedItem != null)
				regijaID = Common.Utility.StringToInt(rblRegija.SelectedItem.Value);

			if (rblUlaganje.SelectedItem != null)
				ulaganjeID = Common.Utility.StringToInt(rblUlaganje.SelectedItem.Value);

			if (rblUpravljanje.SelectedItem != null)
				upravljanjeID = Common.Utility.StringToInt(rblUpravljanje.SelectedItem.Value);

			if (rblCiljPrinosa.SelectedItem != null)
				ciljPrinosaID = Common.Utility.StringToInt(rblCiljPrinosa.SelectedItem.Value);

			if (rblProfilRizicnosti.SelectedItem != null)
				profilRizicnostiID= Common.Utility.StringToInt(rblProfilRizicnosti.SelectedItem.Value);

			if (rblSektor.SelectedItem != null)
				sektorID= Common.Utility.StringToInt(rblSektor.SelectedItem.Value);

			if (rblTrziste.SelectedItem != null)
				trzisteID = Common.Utility.StringToInt(rblTrziste.SelectedItem.Value);

            bool prikaziSakrivene = Roditelj.KorisnikJeAdmin;

			var fondovi = DAL.FondDAC.TraziFondove(kategorijaID, regijaID, ulaganjeID, upravljanjeID, ciljPrinosaID, sektorID, trzisteID, profilRizicnostiID, Roditelj.KorisnikID, prikaziSakrivene);
			
			gvFondovi.DataSource = fondovi;

			//grupiraju se favoriti samo za logirane
			if (HttpContext.Current.User.Identity.IsAuthenticated)
			{
				(gvFondovi.Columns["FAVORIT"] as GridViewDataColumn).GroupIndex = 0;
				(gvFondovi.Columns["FAVORIT"] as GridViewDataColumn).SortOrder = DevExpress.Data.ColumnSortOrder.Descending;
			}

			(gvFondovi.Columns["KATEGORIJA_ID"] as GridViewDataColumn).GroupIndex = 1;
			gvFondovi.ExpandAll();

			(gvFondovi.Columns["PTG"] as GridViewDataColumn).SortOrder = DevExpress.Data.ColumnSortOrder.Descending;

			TimeSpan tsFondovi = DateTime.Now - vrijemeFondovi;
			//lblLog.Text = "Fondovi: " + (int)tsFondovi.TotalMilliseconds + " ms";
		}

        protected void gvFondovi_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            var fond = (gvFondovi.GetRow(e.VisibleIndex) as DAL.TraziFondove_Result);

            if (fond == null)
                return;

            if (e.ButtonID == "cbFondNaziv") //odabir fonda
            {
                Session["fondID"] = fond.ID;

                DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Fond/FondDokument.aspx");
            }
            else if (e.ButtonID == "cbFondVlasnik") //odabir društva
            {
                Session["drustvoID"] = fond.DRUSTVA_ID;

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Fond/DrustvoDokument.aspx");
            }
            else if (e.ButtonID == "cbCijeneDetalji")
            {
                Session["fondID"] = fond.ID;

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Fond/FondCijenePregled.aspx");
            }
			else if (e.ButtonID == "cbKupi")
			{
				Session["fondID"] = fond.ID;

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Fond/FondKupnja.aspx");
			}
			else if (e.ButtonID == btnEdit.ID)
			{
				Session["fondID"] = fond.ID;

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Admin/FondUredjivanje.aspx");
			}
			else if (e.ButtonID == btnDelete.ID)
			{
				if (FondObrisi(fond.ID))
					gvFondovi.DataBind();
			}
			else if (e.ButtonID == btnFondPortfelj.ID)
			{
				Session["fondID"] = fond.ID;

				DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("../Admin/FondStrukturaUredjivanje.aspx");
			}
			else if (e.ButtonID == "btnFavorit")
			{
				DAL.KorisnikDAC.ToggleFondFavorit(Roditelj.KorisnikID, fond.ID);
				gvFondovi.DataBind();

			}
        }

		private bool FondObrisi(int fondID)
		{
			bool uspjeh = DAL.FondDAC.ObrisiFond(fondID);
			return uspjeh;
		}

        protected void gvFondovi_CustomGroupDisplayText(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "KATEGORIJA_ID")
            {

                if (e.Value == null)
                    return;

                int? id = (int?)e.Value;

                if (!id.HasValue) return;

                DAL.Kategorija kat = DAL.FondDAC.VratiKategoriju(id.Value);

                if (kat != null)
                {
                    e.DisplayText = kat.NAZIV.ToUpper();
                }
            }
			else if (e.Column.FieldName == "FAVORIT")
			{
				if (e.Value == null)
					return;

				bool izdvojeno = (int)e.Value == 1;

				e.DisplayText = izdvojeno ? "Izdvojeni" : "---";
			}

        }

        protected void gvFondovi_CustomColumnDisplayText(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs e)
        {
			DAL.TraziFondove_Result fond = (gvFondovi.GetRow(e.VisibleRowIndex) as DAL.TraziFondove_Result);

			if (fond == null)
				return;

			if (e.Column.Name == "VRIJEDNOST_UDJELA")
			{
				if (fond == null) return;

				var postotak = fond.POSTOTAK;
				var zadnjaCijena = fond.VRIJEDNOST;

				if (zadnjaCijena.HasValue && fond.VRIJEDNOST_DATUM.HasValue)
				{

					string datum = Common.Utility.DateTimeToString(fond.VRIJEDNOST_DATUM);

					string img = "";

					if (postotak.HasValue)
					{
						img =
							postotak == 0 ? "jednako.png" :
							postotak > 0 ? "gore_green.png" :
							"dolje_red.png";
					}

					DateTime prethodniRadniDan = Common.Utility.PrethodniRadniDan();

					string klasa = fond.VRIJEDNOST_DATUM < prethodniRadniDan ? "class='stara_cijena'" : "";

					e.DisplayText = string.Format(@"<span {0} title='{1}'>{2}</span>&nbsp;<img src='../Images/{3}' />", klasa, datum, zadnjaCijena.Value.ToString("n4"), img);
				}

			}
			else if (e.Column.Name == "FOND_NAZIV")
			{
				if (fond != null)
                    e.DisplayText = String.Format("<a class='thickbox' href='../Fond/FondDokumentStandalone.aspx?ID={0}&usporedba=1&KeepThis=true&TB_iframe=true&width=800' >{1}</a>", fond.ID, fond.NAZIV);
			}
			else if (e.Column.Name == "FOND_USPOREDI2")
			{
				if (fond != null)
				{
					FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);
					string dodatnaKlasa = "";
					string tekst = "Dodaj";

					if (container.SadrziFond(fond.ID))
					{
						dodatnaKlasa = " remove";
						tekst = "Ukloni";
					}
					else if (container.IsFull)
						dodatnaKlasa = " disabled";

					e.DisplayText = String.Format("<a class='updateCart{0}' href='javascript:void(0)' data-id='{1}' ></a>", dodatnaKlasa, fond.ID);
				}
			}
            else if (e.Column.Name == "Sakriveni")
            {
                if (fond != null)
                {
                    string klasa = fond.SAKRIVENI == true ? " blacklisted" : "";

                    e.DisplayText = String.Format("<a class='blacklist{0}' href='javascript:void(0)' data-id='{1}' ></a>", klasa, fond.ID);
                }
            }
			else if (e.Column.Name == "CijeneDetalji")
			{
				string img = "../Images/graf.png";
				string url = "../Fond/FondCijenePregledStandalone.aspx";
                //&KeepThis=true&TB_iframe=true&height=825&width=900
                e.DisplayText = string.Format(@"<a class='thickbox' href='{0}?ID={1}&KeepThis=true&TB_iframe=true&width=900'><img title='Detalji cijena udjela' src='{2}' /></a>", url, fond.ID, img);
			}
            else if (e.Column.Name == "PRINOS_1M" && fond.PRINOS_1M == 100)
            {
                e.DisplayText = "-";
            }
            else if (e.Column.Name == "PRINOS_3M" && fond.PRINOS_3M == 100)
            {
                e.DisplayText = "-";
            }
            else if (e.Column.Name == "PRINOS_1G" && fond.PRINOS_1G == 100)
            {
                e.DisplayText = "-";
            }
            else if (e.Column.Name == "PRINOS_3G" && fond.PRINOS_3G == 100)
            {
                e.DisplayText = "-";
            }
        }
        
        protected void gvFondovi_CustomButtonInitialize(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonEventArgs e)
        {
			DAL.TraziFondove_Result fond = (gvFondovi.GetRow(e.VisibleIndex) as DAL.TraziFondove_Result);
			if (fond == null)
				return;

            if (e.ButtonID == "cbFondNaziv")
            {
				e.Text = fond.NAZIV;
            }
            else if (e.ButtonID == "cbFondVlasnik")
            {
				e.Text = fond.NAZIV_VLASNIKA;
            }
			else if (e.ButtonID == "btnFavorit")
			{
				string url = fond.FAVORIT == 1 ? "star_check.png" : "star_uncheck.png";
				url = "../Images/" + url;

				e.Image.Url = url;
				e.Image.ToolTip = fond.FAVORIT == 1 ? "Ukloni iz izdvojenih" : "Dodaj u izdvojene";
			}
			else if (e.ButtonID == "btnFondPortfelj" || e.ButtonID == "btnEdit" || e.ButtonID == "btnDelete")
			{
				//samo za admin i društvo
				if(Roditelj.KorisnikJeAdmin)
					return;
				else if(Roditelj.KorisnikDrustvoID != fond.DRUSTVA_ID)
				{
					e.Visible = DevExpress.Utils.DefaultBoolean.False;
				}
			}
        }

		protected void _Trazi(object sender, EventArgs e)
		{
			gvFondovi.DataBind();
		}

        protected void btnTrazi_Click(object sender, EventArgs e)
        {
            //menuRegija.SelectedItem = menuRegija.Items[0];
            //menuUlaganje.SelectedItem = menuUlaganje.Items[0];
            //menuUpravljanje.SelectedItem = menuUpravljanje.Items[0];
        }

		protected void menuKat_MenuItemClick(object sender, MenuEventArgs e)
		{
			if (e.Item.Value == "NULL")
			{
				//resetiraju se svi filtri
				rblUpravljanje.SelectedValue =
				rblCiljPrinosa.SelectedValue =
				rblUlaganje.SelectedValue =
				rblRegija.SelectedValue =
				rblSektor.SelectedValue =
				rblTrziste.SelectedValue =
				rblProfilRizicnosti.SelectedValue = "NULL";
			}

			gvFondovi.DataBind();
		}

		protected void btnNovi_Click(object sender, EventArgs e)
		{
			Session["fonddokmod"] = Common.DokumentMod.Novi;
			Response.Redirect(ResolveUrl("~/Admin/FondUredjivanje.aspx"));
		}
                   
    }
}