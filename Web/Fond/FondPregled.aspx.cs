﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.UI.HtmlControls;

namespace InvestApp.Web
{
	public partial class FondPregled : InvestApp.UIControls.InvestAppPage
    {
		DateTime vrijemePoc;

        protected void Page_Load(object sender, EventArgs e)
        {
			vrijemePoc = DateTime.Now;

			this.Page.Title = "Pregled fondova";
			//(this.Page.Master.FindControl("fondoviLink") as HtmlAnchor).Attributes["class"] = "current";
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

		protected void Page_PreRenderComplete(object sender, EventArgs e)
		{
			TimeSpan vrijemeTotal = DateTime.Now - vrijemePoc;

			//lblLog.Text = "Stranica: " + (int)vrijemeTotal.TotalMilliseconds + " ms";
		}

		//ajax
		[WebMethod]
		[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
		public static Common.UpdateCartResult UpdateCart(int ID)
		{
			var result = new Common.UpdateCartResult();

			FondUsporedbaContainer container = FondUsporedbaContainer.GetContainer(HttpContext.Current.Session);

			if (container.SadrziFond(ID))
			{
				result.Success = container.RemoveFond(ID);
				result.Removed = true;
			}
			else
				result.Success = container.AddFond(ID);

			result.Count = container.BrojFondova;
			result.IsFull = container.IsFull;

			return result;
		}
    }
}