using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.DAL;

namespace InvestApp.Web
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			Response.Redirect("Fond/FondPregled.aspx");
        }
    }
}