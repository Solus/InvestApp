using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Web;
using InvestApp.Common;

namespace InvestApp.Web
{
	public partial class FondCijenePregledStandalone : InvestApp.UIControls.InvestAppPage
    {
        public int FondID
        {
            get
            {
				return Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"]);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (FondID < 0)
                    return;

				string fondNaziv = DAL.FondDAC.VratiFondNaziv(FondID);

				if (!fondNaziv.IsNullOrEmpty())
					lblFondNaziv.Text = fondNaziv + " - ";

				tablePrinosi.FondIDs = new List<int>() { FondID };

				chartPrinos.FondID = FondID;
				PostaviGraf();

				tablePrinosi.DataBind();
            }

        }

		private void PostaviGraf()
		{
			DateTime datumPoc;

			switch (menuPeriod.SelectedValue)
			{
				case "1M":
					datumPoc = DateTime.Today.AddMonths(-1);
					break;
				case "3M":
					datumPoc = DateTime.Today.AddMonths(-3);
					break;
				case "6M":
					datumPoc = DateTime.Today.AddMonths(-6);
					break;
				case "1G":
					datumPoc = DateTime.Today.AddYears(-1);
					break;
				case "3G":
					datumPoc = DateTime.Today.AddYears(-3);
					break;
				case "5G":
					datumPoc = DateTime.Today.AddYears(-5);
					break;
				default:
					datumPoc = DateTime.MinValue;
					break;
			}

			chartPrinos.DatumPoc = datumPoc;
			chartPrinos.DataBind();
		}

		protected void menuPeriod_MenuItemClick(object sender, MenuEventArgs e)
		{
			PostaviGraf();
		}
    }
}