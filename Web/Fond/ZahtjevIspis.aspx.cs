using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DevExpress.XtraRichEdit;
using DevExpress.XtraRichEdit.API.Native;
using System.IO;
using System.Net;
using System.Drawing;

namespace InvestApp.Web
{
	public partial class ZahtjevIspis : InvestApp.UIControls.InvestAppPage
	{
		//RichEditDocumentServer docServer = null;

		protected void Page_Load(object sender, EventArgs e)
		{
		}

		protected void btnIspis_Click(object sender, EventArgs e)
		{
			//MemoryStream stream = new MemoryStream();
			//docServer = CreateDocumentServer();

			//DocumentImageCollection images = docServer.Document.GetImages(docServer.Document.Range);

			//ReplaceText("#CHECKED#", "☐");
			//ReplaceText("#UNCHECKED#", "☒");
			//ReplaceText("#PLACEHOLDER#", "TESTTTTTT");
			

			//Image newImg = Image.FromFile(@"C:\Users\mario.BIOS\Downloads\sabor_grb_rh_220.jpg");

			//ReplaceImage(newImg);

			//docServer.ExportToPdf(stream);

			//stream.Seek(0, SeekOrigin.Begin);
			//stream.CopyTo(Response.OutputStream);

			//Response.StatusCode = (int)HttpStatusCode.OK;
			//Response.ContentType = "application/msword";
			//Response.AddHeader("Content-Disposition", String.Format("attachment; filename=Search.pdf"));
			//Response.End();
		}

		//private void ReplaceText(string input, string output)
		//{
		//	//☐ ☒
		//	DocumentRange[] ranges = docServer.Document.FindAll(input, SearchOptions.None, docServer.Document.Range);

		//	foreach (DocumentRange range in ranges)
		//	{
		//		docServer.Document.Replace(range, output);
		//	}
		//}

		//private void ReplaceImage(Image newImg)
		//{
		//	DocumentImageCollection images = docServer.Document.GetImages(docServer.Document.Range);

		//	foreach (DocumentImage img in images)
		//	{
		//		DocumentPosition pos = img.Range.Start;
		//		docServer.Document.Delete(img.Range);
		//		docServer.Document.InsertImage(pos, newImg);
		//	}
		//}

		//RichEditDocumentServer CreateDocumentServer()
		//{
		//	RichEditDocumentServer documentServer = new RichEditDocumentServer();
		//	documentServer.LoadDocument(@"C:\Projekti\InvestApp\Web\bin\Testni tekst.docx");
		//	return documentServer;
		//}
	}
}