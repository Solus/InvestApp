<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="InvestApp.Web._404" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="error_body">
        <div class="error_body_text box">
            <h1>404</h1>
            <p>
                Nažalost, tražena stranica nije pronađena, vjerojatno zato što je URL pogrešno upisan. Odaberite neki od linkova u meniju, ili se vratite na <a href="http://investiraj.net">početnu stranicu</a>.
            </p>
            <div class="pic"></div>
        </div>
    </div>
</asp:Content>
