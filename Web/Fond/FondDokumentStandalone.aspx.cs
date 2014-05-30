using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.DAL;
using InvestApp.Common;
using System.Web.UI.HtmlControls;

namespace InvestApp.Web
{
	public partial class FondDokumentStandalone : InvestApp.UIControls.InvestAppPage
    {
		DateTime vrijemePoc, vrijemeFond;

        public int FondID {
            get
            {
                //return Session["fondID"] == null ? -1 : (int)Session["fondID"];
				return Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"]);
			}
        }

		protected void Page_Load(object sender, EventArgs e)
		{
			vrijemePoc = DateTime.Now;

			Page.Header.DataBind(); 

			EntityDataSource1.AutoGenerateWhereClause = true;

			if (!IsPostBack)
			{
				ViewState["PrevPage"] = Request.UrlReferrer;

				//FormView1.ChangeMode(FormViewMode.Edit);
				
				EntityDataSource1.WhereParameters["ID"] = new Parameter("ID", System.Data.DbType.Int32, FondID.ToString());

				formHeader.InnerText = DAL.FondDAC.VratiFondNaziv(FondID);

				//gumb za kupnju
				Button btnKupi = FormView1.FindControl("btnKupi") as Button;
				btnKupi.OnClientClick = string.Format("window.parent.location = '{0}?fondID={1}&mod=K'; return false;", ResolveClientUrl("~/Fond/FondKupnja.aspx"), FondID);
			}

			PostaviTablicu();
			PostaviGraf();
			PostaviUsporedbaGumb();
			PostaviStruktureUlaganja();

			//ClientScript.RegisterClientScriptBlock(this.GetType(), "RedirectScript", "window.parent.location = 'http://yoursite.com'", true);
		}

		protected void Page_PreRenderComplete(object sender, EventArgs e)
		{
			TimeSpan vrijemeTotal = DateTime.Now - vrijemePoc;
			TimeSpan tsFondovi = DateTime.Now - vrijemeFond;

			//lblLog.Text = "Stranica: " + (int)vrijemeTotal.TotalMilliseconds + " ms" + "<br/>" + "Fond: " + (int)tsFondovi.TotalMilliseconds + " ms";
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
		
		//protected void btnDodajUsporedba_Click(object sender, EventArgs e)
		//{
		//	FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

		//	container.AddFond(FondID);
		//}

		protected void FormView1_DataBound(object sender, EventArgs e)
		{
			if ((sender as FormView).DataItem != null)
			{
				DAL.Fond fond = ((sender as FormView).DataItem as DAL.Fond);

				if (fond != null)
				{

					//sakrij dodatne podatke ako nije popunjeno
					//if(fond.DODATNI_PODACI.IsNullOrEmpty())
					//	(FormView1.FindControl("divDodatniPodaci") as System.Web.UI.HtmlControls.HtmlGenericControl).Visible = false;
				}
			}
		}

		private void PostaviTablicu()
		{
			FondPrinosiTablicaCtrl prinosiTable = FormView1.FindControl("tablePrinosi") as FondPrinosiTablicaCtrl;
			prinosiTable.FondIDs = new List<int>() { FondID };
			prinosiTable.DataBind();
		}

		private void PostaviStruktureUlaganja()
		{
			FondStruktureUlaganjaCtrl struktUlaganjaTop10 = FormView1.FindControl("struktUlaganjaTop10") as FondStruktureUlaganjaCtrl;
			FondStruktureUlaganjaCtrl struktUlaganjaGeo = FormView1.FindControl("struktUlaganjaGeo") as FondStruktureUlaganjaCtrl;
			FondStruktureUlaganjaCtrl struktUlaganjaSek = FormView1.FindControl("struktUlaganjaSek") as FondStruktureUlaganjaCtrl;
			FondStruktureUlaganjaCtrl struktUlaganjaVal = FormView1.FindControl("struktUlaganjaVal") as FondStruktureUlaganjaCtrl;

			struktUlaganjaTop10.FondID = struktUlaganjaGeo.FondID = struktUlaganjaSek.FondID = struktUlaganjaVal.FondID = FondID;
			struktUlaganjaTop10.DataBind();
			struktUlaganjaGeo.DataBind();
			struktUlaganjaSek.DataBind();
			struktUlaganjaVal.DataBind();
		}

		private void PostaviGraf()
		{
			FondPrinosiGrafCtrl prinosiGraf = FormView1.FindControl("chartPrinosi") as FondPrinosiGrafCtrl;
			prinosiGraf.FondID = FondID;
			prinosiGraf.DatumPoc = DateTime.Today.AddYears(-1);
			prinosiGraf.DataBind();
		}

		protected void EntityDataSource1_Selecting(object sender, EntityDataSourceSelectingEventArgs e)
		{
			if (FondID <= 0)
				e.Cancel = true;

			vrijemeFond = DateTime.Now;
		}

		protected void btnKupi_Click(object sender, EventArgs e)
		{
			//Session["fondID"] = FondID;
			//Response.Write(string.Format("<script>window.parent.location = '{0}'</script>", ResolveClientUrl("~/Fond/FondKupnja.aspx")));
		}

		private void PostaviUsporedbaGumb()
		{
			//gumb za usporedbu se sakrije ako nije naznačeno u querystringu
			if (Request.QueryString == null ||
				Request.QueryString["usporedba"] == null ||
				Request.QueryString["usporedba"].ToString() != "1")
			{
				btnGrupa.Visible = false;
				return;
			}

			PostaviUsporedbaKlase(btnUsporedba, FondID);

			//FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

			//string strClass = btnUsporedba.Attributes["class"];

			//if (container.SadrziFond(FondID)) //ako sadrži taj fond, onda se može ukloniti
			//{
			//	string dodatnaKlasa = " remove";

			//	if (!strClass.Contains(dodatnaKlasa))
			//		btnUsporedba.Attributes["class"] = strClass + dodatnaKlasa;

			//	btnUsporedba.InnerText = "Ukloni";
			//}
			//else if (container.IsFull) //ako je puno, ne može se dodati
			//	btnUsporedba.Attributes["class"] = strClass + " disabled";


			btnUsporedba.Attributes["data-id"] = FondID.ToString();
		}

		protected void fondoviSlicniRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			var fond = e.Item.DataItem as DAL.Fond;

			if (fond == null)
				return;

			var btnSlicanUsporedba = e.Item.FindControl("btnSlicanUsporedba") as HtmlAnchor;

			PostaviUsporedbaKlase(btnSlicanUsporedba, fond.ID);

		}

		private void PostaviUsporedbaKlase(HtmlAnchor button, int fondID)
		{
			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(Session);

			string strClass = button.Attributes["class"];

			if (container.SadrziFond(fondID)) //ako sadrži taj fond, onda se može ukloniti
			{
				string dodatnaKlasa = " remove";

				if (!strClass.Contains(dodatnaKlasa))
					button.Attributes["class"] = strClass + dodatnaKlasa;

				button.InnerText = "Ukloni";
			}
			else if (container.IsFull) //ako je puno, ne može se dodati
				button.Attributes["class"] = strClass + " disabled";
		}
    }
}