<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondZahtjevRealizacija.aspx.cs" Inherits="InvestApp.Web.FondZahtjevRealizacija" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h1 id="formHeader" class="form_header bar" runat="server">Realizacija kupnje/prodaje</h1>

    <div class="form_body">

        <div class="form_item">
            <label class="form_item_label">Fond:</label>
            <asp:Label ID="lblFondNaziv" runat="server" CssClass="form_item_value" />
        </div>

        <div id="divKupnja" runat="server">

            <div class="form_item">
                <label class="form_item_label">Iznos:</label>
                <asp:Label ID="lblKupljenoIznos" runat="server" CssClass="form_item_value" />
            </div>

            <div class="form_item">
                <label class="form_item_label_edit" for="ddlFondovi">Broj udjela:</label>
                <asp:TextBox ID="txtKupljenoBrojUdjela" runat="server" CssClass="form_item_value_edit" />

                <asp:RequiredFieldValidator ID="valBrojUdjelaReq" ControlToValidate="txtKupljenoBrojUdjela" ErrorMessage="Broj udjela mora biti upisan" runat="server" Display="Dynamic" CssClass="validate_error_inline">
                </asp:RequiredFieldValidator>
            </div>

        </div>

        <div id="divProdaja" runat="server">

            <div class="form_item">
                <label class="form_item_label">Broj udjela:</label>
                <asp:Label ID="lblProdanoBrojUdjela" runat="server" CssClass="form_item_value" />
            </div>

            <div class="form_item">
                <label class="form_item_label_edit" for="ddlFondovi">Iznos (kn):</label>
                <asp:TextBox ID="txtProdanoIznos" runat="server" CssClass="form_item_value_edit" />

                <asp:RequiredFieldValidator ID="valIznosReq" ControlToValidate="txtProdanoIznos" ErrorMessage="Iznos mora biti upisan" runat="server" Display="Dynamic" CssClass="validate_error_inline">
                </asp:RequiredFieldValidator>
            </div>

        </div>

        <div class="form_item">
            <label class="form_item_label_edit">Potvrda:</label>
            <asp:FileUpload ID="fileDokument" runat="server" />
            <asp:RequiredFieldValidator ID="valPotvrdaDok" ControlToValidate="fileDokument" ErrorMessage="Potvrda mora biti spremljena" runat="server" Display="Dynamic" CssClass="validate_error_inline">
            </asp:RequiredFieldValidator>
        </div>

        <div class="btn_navigation_group">
            <asp:Button ID="btnUpdate" CssClass="btn_navigation save" runat="server" CausesValidation="True" CommandName="Update" Text="Spremi" OnClick="btnUpdate_Click" />&nbsp;
            <asp:Button ID="btnCancel" CssClass="btn_navigation cancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" OnClick="btnCancel_Click" />
        </div>

    </div>

</asp:Content>
