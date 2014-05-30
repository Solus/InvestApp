<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="FondCijenePregledStandalone.aspx.cs" Inherits="InvestApp.Web.FondCijenePregledStandalone" %>

<%@ Register Assembly="DevExpress.XtraCharts.v13.2.Web, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register Src="~/Kontrole/FondPrinosiGrafCtrl.ascx" TagPrefix="uc1" TagName="FondPrinosiGrafCtrl" %>
<%@ Register Src="~/Kontrole/FondPrinosiTablicaCtrl.ascx" TagPrefix="uc1" TagName="FondPrinosiTablicaCtrl" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Detalji cijena udjela</title>

    <link href="~/Content/Site.css" rel="stylesheet" />
    <script src="<%# ResolveUrl("../Scripts/jquery-2.1.0.min.js")%>"></script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <h1 class="form_header bar"><asp:Label ID="lblFondNaziv" runat="server" Text=""></asp:Label>Prinos</h1>

        <div class="form_body wide">

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <asp:Menu ID="menuPeriod" runat="server" CssClass="search_list items7" RenderingMode="List" IncludeStyleBlock="False" EnableViewState="true" SkipLinkText="" OnMenuItemClick="menuPeriod_MenuItemClick">
                        <Items>
                            <asp:MenuItem Text="1 mjesec" Value="1M"></asp:MenuItem>
                            <asp:MenuItem Text="3 mjeseca" Value="3M"></asp:MenuItem>
                            <asp:MenuItem Text="6 mjeseci" Value="6M"></asp:MenuItem>
                            <asp:MenuItem Text="1 godina" Value="1G" Selected="true"></asp:MenuItem>
                            <asp:MenuItem Text="3 godine" Value="3G"></asp:MenuItem>
                            <asp:MenuItem Text="5 godina" Value="5G"></asp:MenuItem>
                            <asp:MenuItem Text="MAX" Value="SVI"></asp:MenuItem>
                        </Items>
                    </asp:Menu>

                    <uc1:FondPrinosiGrafCtrl runat="server" ID="chartPrinos" Width="845" Height="400" />

                </ContentTemplate>
            </asp:UpdatePanel>

            <uc1:FondPrinosiTablicaCtrl runat="server" ID="tablePrinosi" DetaljneLabele="true" />

            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="200">
                <ProgressTemplate>
                    <div class="progress_message">Učitavanje...</div>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </div>

    </form>
</body>
</html>
