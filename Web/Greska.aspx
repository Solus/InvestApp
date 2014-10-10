<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="Greska.aspx.cs" Inherits="InvestApp.Web.Greska" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="error_body error">
        <div class="error_body_text panel">
            <h1>Greška</h1>
            <p>
                Kao što vidite, nešto nepredviđeno se dogodilo.
           Administratori su obaviješteni i pokušat će ukloniti grešku u što kraćem roku. U međuvremenu, slobodno nastavite koristiti aplikaciju.
            </p>
        </div>
    </div>
</asp:Content>
