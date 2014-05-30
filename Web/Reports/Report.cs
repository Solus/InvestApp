using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InvestApp.Web.Reports
{
	public class Report
	{
		public static void IspisiZahtjev(int zahtjevID)
		{
			Reports.ZahtjeviGenericRpt rpt = new Reports.ZahtjeviGenericRpt();
			rpt.BindDataSource(zahtjevID);

			System.IO.MemoryStream stream = new System.IO.MemoryStream();
			rpt.ExportToPdf(stream);
			stream.Seek(0, System.IO.SeekOrigin.Begin);
			stream.CopyTo(HttpContext.Current.Response.OutputStream);

			HttpContext.Current.Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
			HttpContext.Current.Response.ContentType = "application/pdf";
			HttpContext.Current.Response.AddHeader("Content-Disposition", String.Format("attachment; filename=zahtjev.pdf"));
			HttpContext.Current.Response.End();
		}
	}
}