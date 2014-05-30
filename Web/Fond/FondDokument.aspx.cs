using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.DAL;

namespace InvestApp.Web
{
	public partial class FondDokument : InvestApp.UIControls.InvestAppPage
    {

        public int FondID {
            get
            {
                //return Session["fondID"] == null ? -1 : (int)Session["fondID"];
				return Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"]);
			}
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            EntityDataSource1.AutoGenerateWhereClause = true;

            if (!IsPostBack)
            {
                ViewState["PrevPage"] = Request.UrlReferrer;

                //FormView1.ChangeMode(FormViewMode.Edit);

                if (FondID < 0)
                    return;

                EntityDataSource1.WhereParameters.Add("ID", System.Data.DbType.Int32, FondID.ToString());

                //Fond fond = DAL.FondDAC.VratiFond(FondID);

                //punjenje podataka
                //if (fond != null)
                //{
                //    tbNazivFonda.Text = fond.NAZIV;
                //    tbValuta.Text = fond.VALUTA_SIFRA;
                //    if(fond.DATUM_OSNIVANJA.HasValue)
                //        tbDatumOsnivanja.Date = fond.DATUM_OSNIVANJA.Value;

                //    tbKategorija.Text = fond.Kategorija.NAZIV;
                //    tbNazivDrustva.Text = fond.Drustvo.NAZIV;
                //    tbRizicnost.Text = fond.RIZICNOST;
                //    if(fond.MINIMALNA_POCETNA_UPLATA.HasValue)
                //        tbMinimalnaPocetna.Text = fond.MINIMALNA_POCETNA_UPLATA.Value.ToString("n");
                //    if(fond.MINIMALNE_OSTALE_UPLATE.HasValue)
                //        tbMinimalnaOstale.Text = fond.MINIMALNE_OSTALE_UPLATE.Value.ToString("n");
                //    if(fond.POCETNA_CIJENA_UDJELA.HasValue)
                //        tbPocetnaCijena.Text = fond.POCETNA_CIJENA_UDJELA.Value.ToString("n");
                //    if(fond.IMOVINA_FONDA.HasValue)
                //        tbImovinaFonda.Text = fond.IMOVINA_FONDA.Value.ToString("n");
                //    lblNaknadaUlazna.Text = fond.NAKNADA_ULAZNA;
                //    lblNaknadaIzlazna.Text = fond.NAKNADA_IZLAZNA;
                //    lblNaknadaZaUpravljanjem.Text = fond.NAKNADA_ZA_UPRAVLJANJEM_FONDA;
                //    lblNaknadaDepozitarnoj.Text = fond.NAKNADA_DEPOZITARNOJ_BANCI;
                //    lblNaknadaBanka.Text = "";
                //    lblNapomenaKupnja.Text = fond.NAPOMENA_ZA_KUPNJU;
                //    lblNapomenaProdaja.Text = fond.NAPOMENA_ZA_PRODAJU;
                //    lblNapomenaRegistracija.Text = fond.NAPOMENA_ZA_REGISTRACIJU;
                //    lblNapomenaOdregistracija.Text = fond.NAPOMENA_ZA_ODREGISTRACIJU;
                //    lblDodatno.Text = fond.DODATNI_PODACI;

                //    tbVBDI.Text = fond.NALOG_PRIMATELJ_VBDI;
                //    tbBrojRacuna.Text = fond.NALOG_PRIMATELJ_RACUN;
                //    tbPBOmodel.Text = fond.NALOG_PBO_MODEL;
                //    tbPBO.Text = fond.NALOG_PBO;

                //}
            }
        }

        protected void btnSpremi_Click(object sender, EventArgs e)
        {
            Povratak();
        }

        private void Povratak()
        {
            if (ViewState["PrevPage"] != null)
                Response.Redirect(ViewState["PrevPage"].ToString());
        }

        protected void btnPovratak_Click(object sender, EventArgs e)
        {
            Povratak();
        }

        protected void EntityDataSource1_Updated(object sender, EntityDataSourceChangedEventArgs e)
        {
            Povratak();
        }

        protected void FormView1_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            //if (e.CancelingEdit)
            //    Povratak();
        }

        protected void btnPovratak_Click1(object sender, EventArgs e)
        {
            Povratak();
        }
    }
}