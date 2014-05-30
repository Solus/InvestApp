using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.DAL;

namespace InvestApp.Web
{
	public partial class DrustvoDokument : InvestApp.UIControls.InvestAppPage
    {
        public int DrustvoID
        {
            get
            {
                return Session["drustvoID"] == null ? -1 : (int)Session["drustvoID"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            EntityDataSourceDrustva.AutoGenerateWhereClause = true;

            if (!IsPostBack)
            {
                ViewState["PrevPage"] = Request.UrlReferrer;

                if (DrustvoID < 0)
                    return;

                EntityDataSourceDrustva.WhereParameters.Add("ID", System.Data.DbType.Int32, DrustvoID.ToString());
            }
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
    }
}