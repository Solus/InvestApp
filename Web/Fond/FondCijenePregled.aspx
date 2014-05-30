<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondCijenePregled.aspx.cs" Inherits="InvestApp.Web.FondCijenePregled" %>

<%@ Register assembly="DevExpress.XtraCharts.v13.2.Web, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts.Web" tagprefix="dxchartsui" %>
<%@ Register assembly="DevExpress.XtraCharts.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>
<%@ Register Src="~/Kontrole/FondPrinosiGrafCtrl.ascx" TagPrefix="uc1" TagName="FondPrinosiGrafCtrl" %>
<%@ Register Src="~/Kontrole/FondPrinosiTablicaCtrl.ascx" TagPrefix="uc1" TagName="FondPrinosiTablicaCtrl" %>



<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="form_body wide">

        <h1 class="form_header"><asp:Label ID="lblFondNaziv" runat="server" Text=""></asp:Label>Prinos</h1>

        <asp:Menu ID="menuPeriod" runat="server" CssClass="search_list" RenderingMode="List" IncludeStyleBlock="False" EnableViewState="true" SkipLinkText="" OnMenuItemClick="menuPeriod_MenuItemClick">
            <Items>
                <asp:MenuItem Text="1 mjesec" Value="1M"></asp:MenuItem>
                <asp:MenuItem Text="3 mjeseca" Value="3M"></asp:MenuItem>
                <asp:MenuItem Text="6 mjeseci" Value="6M"></asp:MenuItem>
                <asp:MenuItem Text="1 godina" Value="1G" Selected="true" ></asp:MenuItem>
                <asp:MenuItem Text="3 godine" Value="3G"></asp:MenuItem>
                <asp:MenuItem Text="5 godina" Value="5G"></asp:MenuItem>
                <asp:MenuItem Text="MAX" Value="SVI" ></asp:MenuItem>
            </Items>
        </asp:Menu>
        
            <%--<dxchartsui:WebChartControl ID="chartCijene" CssClass="graf_cijene" runat="server" OnDataBinding="chartCijene_DataBinding" CrosshairEnabled="True" Height="200px" Width="300px">
                <diagramserializable>
            <cc1:XYDiagram>
                <axisx visibleinpanesserializable="-1">
                    <autoscalebreaks maxcount="10" />
                    <tickmarks minorlength="3" />
                    <label staggered="True">
                    </label>
                    <numericscaleoptions autogrid="False" />
                    <datetimescaleoptions aggregatefunction="None" autogrid="False" gridalignment="Day" gridspacing="200">
                    </datetimescaleoptions>
                </axisx>
                <axisy visibleinpanesserializable="-1">
                </axisy>
            </cc1:XYDiagram>
        </diagramserializable>
                <seriesserializable>
            <cc1:Series Name="Series 1" ArgumentScaleType="DateTime">
                <viewserializable>
                    <cc1:LineSeriesView MarkerVisibility="True">
                    </cc1:LineSeriesView>
                </viewserializable>
            </cc1:Series>
        </seriesserializable>
                <seriestemplate>
            <viewserializable>
                <cc1:LineSeriesView>
                </cc1:LineSeriesView>
            </viewserializable>
        </seriestemplate>
            </dxchartsui:WebChartControl>--%>

        <uc1:FondPrinosiGrafCtrl runat="server" ID="chartPrinos" Width="845" Height="400" />

        <uc1:FondPrinosiTablicaCtrl runat="server" ID="tablePrinosi" DetaljneLabele="true" />
        
        <div class="btn_navigation_group left_buttons" id="divBtn" runat="server">

            <asp:Button ID="btnPovratak" runat="server" Text="Povratak" CssClass="btn_navigation" OnClick="btnPovratak_Click" />

        </div>

    </div>

</asp:Content>
