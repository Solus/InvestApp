using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class FondStrukturaUredjivanje : System.Web.UI.Page
	{
		#region Privatni članovi
		
		private int FondID
		{
			get
			{
				return Session["fondID"] == null ? -1 : (int)Session["fondID"];
			}
			set
			{
				Session["fondID"] = value;
			}
		}

		private int? ZaglavljeIDTop10
		{
			get { return ViewState["struktZagID_T"] == null ? (int?)null : (int)ViewState["struktZagID_T"]; }
			set { ViewState["struktZagID_T"] = value; }
		}

		private int? ZaglavljeIDGeo
		{
			get { return ViewState["struktZagID_G"] == null ? (int?)null : (int)ViewState["struktZagID_G"]; }
			set { ViewState["struktZagID_G"] = value; }
		}

		private int? ZaglavljeIDSek
		{
			get { return ViewState["struktZagID_S"] == null ? (int?)null : (int)ViewState["struktZagID_S"]; }
			set { ViewState["struktZagID_S"] = value; }
		}

		private int? ZaglavljeIDVal
		{
			get { return ViewState["struktZagID_V"] == null ? (int?)null : (int)ViewState["struktZagID_V"]; }
			set { ViewState["struktZagID_V"] = value; }
		}

		private string PrevPage
		{
			get { return ViewState["PrevPage"] == null ? null : ViewState["PrevPage"].ToString(); }
			set { ViewState["PrevPage"] = value; }
		}

		#endregion

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				if (Request.UrlReferrer != null)
					PrevPage = Request.UrlReferrer.AbsoluteUri;

				var fond = DAL.FondDAC.VratiFond(FondID);

				if (fond == null)
					return;

				formHeader.InnerText = fond.NAZIV + " - Portfelj";
				this.Page.Title = fond.NAZIV + " - Portfelj";

				ZaglavljeIDTop10 = DAL.FondDAC.VratiIliKreirajFondStruktura(FondID, Common.FondoviHelper.StrukturaUlaganjaTip.Top10, DateTime.Today);
				ZaglavljeIDGeo = DAL.FondDAC.VratiIliKreirajFondStruktura(FondID, Common.FondoviHelper.StrukturaUlaganjaTip.GeografskaIzlozenost, DateTime.Today);
				ZaglavljeIDSek= DAL.FondDAC.VratiIliKreirajFondStruktura(FondID, Common.FondoviHelper.StrukturaUlaganjaTip.SektorskaIzlozenost, DateTime.Today);
				ZaglavljeIDVal= DAL.FondDAC.VratiIliKreirajFondStruktura(FondID, Common.FondoviHelper.StrukturaUlaganjaTip.ValutnaIzlozenost, DateTime.Today);
			}



			EntityDataSourceStrukturaTop10.WhereParameters["ZAGLAVLJE_ID"] = new Parameter("ZAGLAVLJE_ID", System.Data.DbType.Int32, ZaglavljeIDTop10.ToString());
			EntityDataSourceStrukturaGeo.WhereParameters["ZAGLAVLJE_ID"] = new Parameter("ZAGLAVLJE_ID", System.Data.DbType.Int32, ZaglavljeIDGeo.ToString());
			EntityDataSourceStrukturaSekt.WhereParameters["ZAGLAVLJE_ID"] = new Parameter("ZAGLAVLJE_ID", System.Data.DbType.Int32, ZaglavljeIDSek.ToString());
			EntityDataSourceStrukturaVal.WhereParameters["ZAGLAVLJE_ID"] = new Parameter("ZAGLAVLJE_ID", System.Data.DbType.Int32, ZaglavljeIDVal.ToString());
		}

		#region Dorada pri spremanju
		protected void EntityDataSourceStrukturaTop10_Inserting(object sender, EntityDataSourceChangingEventArgs e)
		{
			if (!ZaglavljeIDTop10.HasValue)
			{
				e.Cancel = true;
				return;
			}

			var strukt = e.Entity as DAL.StrukturaUlaganjaDetalji;
			strukt.ZAGLAVLJE_ID = ZaglavljeIDTop10.Value;
		}

		protected void EntityDataSourceStrukturaGeo_Inserting(object sender, EntityDataSourceChangingEventArgs e)
		{
			if (!ZaglavljeIDGeo.HasValue)
			{
				e.Cancel = true;
				return;
			}

			var strukt = e.Entity as DAL.StrukturaUlaganjaDetalji;
			strukt.ZAGLAVLJE_ID = ZaglavljeIDGeo.Value;
		}

		protected void EntityDataSourceStrukturaSekt_Inserting(object sender, EntityDataSourceChangingEventArgs e)
		{
			if (!ZaglavljeIDSek.HasValue)
			{
				e.Cancel = true;
				return;
			}

			var strukt = e.Entity as DAL.StrukturaUlaganjaDetalji;
			strukt.ZAGLAVLJE_ID = ZaglavljeIDSek.Value;
		}

		protected void EntityDataSourceStrukturaVal_Inserting(object sender, EntityDataSourceChangingEventArgs e)
		{
			if (!ZaglavljeIDVal.HasValue)
			{
				e.Cancel = true;
				return;
			}

			var strukt = e.Entity as DAL.StrukturaUlaganjaDetalji;
			strukt.ZAGLAVLJE_ID = ZaglavljeIDVal.Value;
		} 
		#endregion

		protected void UpdateCancelButton_Click(object sender, EventArgs e)
		{
			_Povratak();
		}

		private void _Povratak()
		{
			if (!string.IsNullOrEmpty(PrevPage))
				Response.Redirect(PrevPage);
			else
				Response.Redirect(ResolveUrl("~/Fond/FondPregled.aspx"));
		}
	}
}