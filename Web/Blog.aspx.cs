using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InvestApp.Web
{
	public partial class Novosti : UIControls.InvestAppPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
				this.Page.Title = "Blog";

				//var novosti = (new DAL.FondEntities()).Novosti.OrderByDescending(n => n.VRIJEME_KREIRANJA).ToList();
				//repeaterNovosti.DataSource = novosti;
				//repeaterNovosti.DataBind();

				btnNovi.Visible = KorisnikJeAdmin;
			}

			lblNoviPoruka.Text = "";
		}

		protected void repeaterNovosti_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				var novost = e.Item.DataItem as DAL.Novost;

				if(novost == null)
					return;

				EntityDataSource ds = e.Item.FindControl("EntityDataSourceNovost") as EntityDataSource;

				ds.WhereParameters["ID"] = new Parameter("ID", System.Data.DbType.Int32, novost.ID.ToString());

				var btnEdit = e.Item.FindControl("btnEdit") as LinkButton;
				var btnDelete = e.Item.FindControl("btnDelete") as LinkButton;

				btnEdit.Visible = btnDelete.Visible = KorisnikJeAdmin;
			}
		}

		protected void repeaterNovosti_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			if (e.CommandName == "EditBlog")
			{
				FormView fv = e.Item.FindControl("fvBlog") as FormView;
				fv.ChangeMode(FormViewMode.Edit);
			}
			else if (e.CommandName == "DeleteBlog")
			{
				FormView fv = e.Item.FindControl("fvBlog") as FormView;
				fv.DeleteItem();
				repeaterNovosti.DataBind();
			}
		}

		protected void fvBlog_ItemUpdating(object sender, FormViewUpdateEventArgs e)
		{
			e.NewValues["KORISNIK_PROMJENA_ID"] = KorisnikID;
			e.NewValues["VRIJEME_PROMJENE"] = DateTime.Now;
		}

		protected void btnNovi_Click(object sender, EventArgs e)
		{
			divNovi.Visible = true;
		}

		protected void fvBlogNovi_ModeChanging(object sender, FormViewModeEventArgs e)
		{
			if (e.CancelingEdit)
				divNovi.Visible = false;
		}

		protected void fvBlogNovi_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
			if (e.Exception == null)
			{
				divNovi.Visible = false;
				lblNoviPoruka.Text = "";

				Response.Redirect("Blog.aspx");
			}
			else
			{
				lblNoviPoruka.Text = "Dogodila se greška pri unosu: " + e.Exception.Message;

				Log("Greška pri unosu bloga:", e.Exception);
			}
		}

		protected void fvBlogNovi_ItemInserting(object sender, FormViewInsertEventArgs e)
		{
			e.Values["KORISNIK_ID"] = KorisnikID;
		}
	}
}