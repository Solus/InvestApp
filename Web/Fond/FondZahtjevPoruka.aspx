<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondZahtjevPoruka.aspx.cs" Inherits="InvestApp.Web.FondZahtjevPoruka" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="form_body">

        <asp:Label ID="lblStatusPoruka" runat="server" CssClass="poruka">Zahtjev za kupnju je unesen.</asp:Label>

        <div class="btn_navigation_group center_buttons">
            <asp:Button ID="btnZahtjev" runat="server" CssClass="btn_navigation" Text="Preuzmi pristupnu izjavu" OnClick="btnZahtjev_Click" />
            <asp:Button ID="btnDokumenti" runat="server" CssClass="btn_navigation" Text="Predaj pristupnu izjavu" ToolTip="Predavanje potpisanog i skeniranog zahtjeva" OnClick="btnDokumenti_Click" />
        </div>


    </div>

</asp:Content>
