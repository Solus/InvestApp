<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondPortfeljPregled.aspx.cs" Inherits="InvestApp.Web.FondPortfeljPregled" %>

<%@ Register Src="~/Kontrole/FondPortfeljPregledCtrl.ascx" TagPrefix="uc1" TagName="FondPortfeljPregledCtrl" %>
<%@ Register Src="~/Kontrole/FondPortfeljUdioGrafCtrl.ascx" TagPrefix="uc1" TagName="FondPortfeljUdioGrafCtrl" %>
<%@ Register Src="~/Kontrole/FondPortfeljVrijednostGrafCtrl.ascx" TagPrefix="uc1" TagName="FondPortfeljVrijednostGrafCtrl" %>




<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h1 class="form_header bar">Portfelj</h1>

    <div class="content_tall">

        <div class="form_body portfelj">

            <uc1:FondPortfeljPregledCtrl runat="server" ID="FondPortfeljPregledCtrl" />

        </div>

        <div class="form_body_extra body_left">
            <uc1:FondPortfeljVrijednostGrafCtrl runat="server" id="portfeljVrijednostiGraf"  Width="449px" Height="305px" />
        </div>

        <div class="form_body_extra body_right">
            <uc1:FondPortfeljUdioGrafCtrl runat="server" ID="portfeljUdioGraf" Width="449px" Height="305px" />
        </div>

    </div>

</asp:Content>
