﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.Common;

namespace InvestApp.Web
{
	public partial class FondRealizacija : UIControls.InvestAppPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
                this.Page.Title = "Ručna realizacija | investiraj.net";

				if (Request.UrlReferrer != null)
					ViewState["PrevPage"] = Request.UrlReferrer;
			}
		}

		protected void fvPromet_DataBound(object sender, EventArgs e)
		{
			if (fvPromet.CurrentMode == FormViewMode.Insert)
			{
				(fvPromet.FindControl("txtDatum") as TextBox).Text = DateTime.Today.ToString("dd.MM.yyyy");
			}
		}

		protected void EntityDataSourcePromet_Inserting(object sender, EntityDataSourceChangingEventArgs e)
		{
			(e.Entity as DAL.FondPromet).KORISNIK_ID = KorisnikID;
		}

		private void _Povratak()
		{
			if (ViewState["PrevPage"] != null)
				Response.Redirect(ViewState["PrevPage"].ToString());
			else
				Response.Redirect(ResolveUrl("~/Fond/FondPortfeljPregled.aspx"));
		}

		protected void fvPromet_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
			_Povratak();
		}

		protected void fvPromet_ModeChanging(object sender, FormViewModeEventArgs e)
		{
			if (e.CancelingEdit)
				_Povratak();
		}

        protected void valBrojUdjela_ServerValidate(object source, ServerValidateEventArgs args)
        {
            decimal? brUdjela = Utility.StringToDecimal(args.Value);

            args.IsValid = false;

            if (!brUdjela.HasValue)
            {
                (fvPromet.FindControl("valBrojUdjela") as CustomValidator).ErrorMessage = "Broj mora biti u formatu 1234,0000";
                return;
            }
            else
                args.IsValid = true;
        }
	}
}