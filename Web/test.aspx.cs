using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class test : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            lblPoruka.Text = "";
		}

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string[] cc = txtCC.Text.Split(',');
            var uspjeh = Common.Email.PosaljiEmail(txtAddress.Text, txtSubject.Text, txtBody.Text, cc);

            lblPoruka.Text = "E-mail " + (uspjeh ? "je" : "nije") + " uspješno poslan";
        }
	}
}