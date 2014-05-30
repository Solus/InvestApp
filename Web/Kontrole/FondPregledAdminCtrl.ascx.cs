using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
    public partial class FondPregledAdminCtrl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["fondID"] = null;
                gvFondovi.GroupBy(gvFondovi.Columns["KATEGORIJA_ID"]);
                gvFondovi.ExpandAll();
                gvFondovi.Settings.GroupFormat = "{1}";
            }
        }

        protected void gvFondovi_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            var fondID = gvFondovi.GetRowValues(e.VisibleIndex, "ID");

            if (e.ButtonID == btnEdit.ID)
            {
                Session["fondID"] = fondID;

                DevExpress.Web.ASPxClasses.ASPxWebControl.RedirectOnCallback("FondDokument.aspx");
            }
        }

        protected void btnNovi_Click(object sender, EventArgs e)
        {
            Response.Redirect("FondDokument.aspx");
        }

        protected void gvFondovi_CustomGroupDisplayText(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewColumnDisplayTextEventArgs e)
        {
            if (e.Column.FieldName == "KATEGORIJA_ID")
            {

                if (e.Value == null)
                    return;

                int id = (int)e.Value;

                DAL.Kategorija kat = DAL.FondDAC.VratiKategoriju(id);

                if (kat != null)
                {
                    e.DisplayText = kat.NAZIV;
                }
            }

        }
                   
    }
}