using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using InvestApp.Common;
using System.Web.UI.HtmlControls;
using System.IO;

namespace InvestApp.Web
{
	public partial class FondCijeneUdjelaUredjivanje : InvestApp.UIControls.InvestAppPage
	{
		#region Privatni članovi

		private int FondID
		{
			get
			{
				return ddlFondovi.SelectedValue.IsNullOrEmpty() ? -1 : Convert.ToInt32(ddlFondovi.SelectedValue);
			}
		}

		private string PrevPage
		{
			get { return ViewState["PrevPage"] == null ? null : ViewState["PrevPage"].ToString(); }
			set { ViewState["PrevPage"] = value; }
		}

		private List<int> IndeksniFondoviIDs
		{
			get { return ViewState["indeksnifonds"] == null ? null : (List<int>)ViewState["indeksnifonds"]; }
			set { ViewState["indeksnifonds"] = value; }
		}

		#endregion

		protected void Page_Load(object sender, EventArgs e)
		{
			lblUploadPoruka.Text = "";

			if (!IsPostBack)
			{
				if (Request.UrlReferrer != null)
					PrevPage = Request.UrlReferrer.AbsoluteUri;

				this.Page.Title = "Cijene udjela";
				//(this.Page.Master.FindControl("adminLink") as HtmlAnchor).Attributes["class"] = "current";

				if (FondID > 0)
					gvCijene.DataBind();
				else
					gvCijene.Visible = false;

				PopuniFondove();
			}

			EntityDataSourceCijene.WhereParameters["FOND_ID"] = new Parameter("FOND_ID", System.Data.DbType.Int32, FondID.ToString());
		}

		private void PopuniFondove()
		{
			var drustvoID = KorisnikDrustvoID;

			ICollection<DAL.Fond> fondovi = null;

			if(drustvoID.HasValue)
				fondovi = DAL.FondDAC.VratiFondove(true, "--Odaberite fond--", drustvoID: drustvoID);
			else if(KorisnikJeAdmin)
				fondovi = DAL.FondDAC.VratiFondove(true, "--Odaberite fond--");
			
			ddlFondovi.DataSource = fondovi;
			ddlFondovi.DataBind();
		}

		protected void ddlFondovi_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (FondID <= 0)
			{
				gvCijene.Visible = false;
				divCijeneUpload.Visible = false;
			}
			else
			{
				divCijeneUpload.Visible = true;

				btnUcitajCijene.OnClientClick = "return confirm('Postojeće cijene na učitane datume će biti zamijenjene novima. Želite li učitati cijene za fond \"" + ddlFondovi.SelectedItem.Text + "\"?');";

				gvCijene.Visible = true;
				gvCijene.DataBind();
			}
		}

		protected void gvCijene_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
		{
			//provjeri se datum
		}

		protected void gvCijene_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
		{
			if (FondID <= 0)
				return;

			var gridView = sender as DevExpress.Web.ASPxGridView.ASPxGridView;
			DateTime datum = (DateTime)e.NewValues["DATUM"];

			try
			{
				bool postoji = DAL.FondDAC.CijenaPostoji(FondID, datum);

				if (postoji)
					throw new Exception("Cijena je već upisana za taj datum");
				else
				{
					e.NewValues["FOND_ID"] = FondID;
					var cijena = (decimal?)e.NewValues["VRIJEDNOST"];

					DAL.FondDAC.UnesiCijenu(FondID, datum, cijena);

					gridView.CancelEdit();
					e.Cancel = true;
				}
			}
			catch (Exception ex)
			{
				Log("Greška kod unosa cijene: " + ex.Message);

				throw new Exception(ex.Message, ex);
			}
		}

		protected void gvCijene_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
		{
			var gridView = sender as DevExpress.Web.ASPxGridView.ASPxGridView;

			var id = (int)e.Values["ID"];

			DAL.FondDAC.ObrisiCijenu(id);

			e.Cancel = true;
		}

		protected void UpdateCancelButton_Click(object sender, EventArgs e)
		{
			_Povratak();
		}

		private void _Povratak()
		{
			if (!string.IsNullOrEmpty(PrevPage))
				Response.Redirect(PrevPage);
			else
				Response.Redirect(ResolveUrl("~/Fond/FondPregled.aspx"));
		}

		protected void gvCijene_CellEditorInitialize(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewEditorEventArgs e)
		{
			var gridView = sender as DevExpress.Web.ASPxGridView.ASPxGridView;

			if (gridView.IsNewRowEditing) //novi
			{
				if (e.Column.Name == "DATUM")
				{
					e.Editor.Value = Utility.PrethodniRadniDan();

					//var datum = DAL.FondDAC.VratiZadnjaCijenaDatum(FondID);
					//if (datum.HasValue)
					//	e.Editor.Value = datum.Value.AddDays(1);

				}
			}
			else //ažuriranje
				e.Editor.Enabled = e.Column.Name == "VRIJEDNOST";
		}

		protected void btnUcitajCijene_Click(object sender, EventArgs e)
		{
			if (uploadCijene.HasFile && FondID > 0)
			{
				//provjera ekstenzije
				if (Path.GetExtension(uploadCijene.FileName).ToLower() != ".csv")
				{
					AddClass(lblUploadPoruka, "error");
					lblUploadPoruka.Text = "Datoteka mora biti u .csv formatu";
					return;
				}

				try
				{
					string fileName = "cijene_" + FondID + ".csv";

					fileName = Server.MapPath(fileName);

					uploadCijene.SaveAs(fileName);

					Dictionary<DateTime, decimal> cijene = new Dictionary<DateTime, decimal>();

					//čitanje csv-a
					using (var sr = new StreamReader(fileName))
					{
						string line;

						while ((line = sr.ReadLine()) != null)
						{
							string[] values = line.Split(';');
							if (values.Length != 2 || string.IsNullOrEmpty(values[0]) || string.IsNullOrEmpty(values[0]))
								continue;

							DateTime datum = DateTime.ParseExact(values[0], "dd.MM.yyyy", null);
							decimal cijena = decimal.Parse(values[1]);

							if (cijene.ContainsKey(datum))
								cijene[datum] = cijena;
							else
								cijene.Add(datum, cijena);
						}
					}

					if (File.Exists(fileName))
						File.Delete(fileName);

					DAL.FondDAC.UnesiCijene(FondID, cijene);

					gvCijene.DataBind();

					RemoveClass(lblUploadPoruka, "error");
					lblUploadPoruka.Text = "Cijene su uspješno učitane";
				}
				catch (Exception ex)
				{
					AddClass(lblUploadPoruka, "error");
					lblUploadPoruka.Text = "Dogodila se greška kod učitavanja cijena: " + ex.Message;
					Log("Greška kod parsiranja csv-a: ", ex);
				}
			}
		}

		private void AddClass(Label label, string cssClass)
		{
			if (!label.CssClass.Contains(cssClass))
				label.CssClass  += " " + cssClass;
		}

		private void RemoveClass(Label label, string cssClass)
		{
			if (label.CssClass.Contains(cssClass))
				label.CssClass = label.CssClass.Replace(cssClass, "").Trim();
		}

		//protected void valCijeneUpload_ServerValidate(object source, ServerValidateEventArgs args)
		//{
		//	if (uploadCijene.HasFile)
		//		args.IsValid = System.IO.Path.GetExtension(uploadCijene.FileName).ToLower() == ".csv";
		//	else
		//		args.IsValid = true;
		//}
	}
}