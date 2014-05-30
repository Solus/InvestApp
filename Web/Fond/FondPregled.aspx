<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondPregled.aspx.cs" Inherits="InvestApp.Web.FondPregled" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register src="~/Kontrole/FondPregledCtrl.ascx" tagname="FondPregledCtrl" tagprefix="uc1" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dxe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="form_header bar">Pregled fondova</div>

    <div class="form_body extra_wide">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <asp:Label ID="lblLog" runat="server"></asp:Label>

            </ContentTemplate>
        </asp:UpdatePanel>

        <uc1:FondPregledCtrl ID="fondPregledControl" runat="server" />

    </div>

</asp:Content>