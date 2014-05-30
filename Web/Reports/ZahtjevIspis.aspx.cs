using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web.Reports
{
	public partial class ZahtjevIspis : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Request.QueryString == null || Request.QueryString["ID"] == null)
				return;

			int zahtjevID = Convert.ToInt32(Request.QueryString["ID"]);

			Reports.ZahtjeviGenericRpt rpt = new Reports.ZahtjeviGenericRpt();
			rpt.BindDataSource(zahtjevID);

			System.IO.MemoryStream stream = new System.IO.MemoryStream();
			rpt.ExportToPdf(stream);
			stream.Seek(0, System.IO.SeekOrigin.Begin);
			stream.CopyTo(Response.OutputStream);

			Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
			Response.ContentType = "application/pdf";
			Response.AddHeader("Content-Disposition", String.Format("attachment; filename=zahtjev.pdf"));
			Response.End();
		}
	}
}