using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace InvestApp.Web
{
	public partial class FondPortfeljPregled : UIControls.InvestAppPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				this.Page.Title = "Portfelj";
				//(this.Page.Master.FindControl("portfeljLink") as HtmlAnchor).Attributes["class"] = "current";

				portfeljUdioGraf.DataBind();
				portfeljVrijednostiGraf.DataBind();
			}
		}

		protected void Page_Init(object sender, EventArgs e)
		{
			(Master.FindControl("lblLog") as Label).Text = "";
		}
	}
}