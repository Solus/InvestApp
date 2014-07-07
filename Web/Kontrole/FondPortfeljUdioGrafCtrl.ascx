<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FondPortfeljUdioGrafCtrl.ascx.cs" Inherits="InvestApp.Web.FondPortfeljUdioGrafCtrl" %>
<%@ Register Assembly="DevExpress.XtraCharts.v13.2.Web, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>

<%@ Register Assembly="DevExpress.XtraCharts.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>

<div class="control_inner_container">



    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>



            <div class="ctrl_search">
                            <label for="ddlPrikaz">Prikaz po:</label>
                                <asp:DropDownList ID="ddlPrikaz" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPrikaz_SelectedIndexChanged">
                                    <asp:ListItem Value="D" Selected="True">društvu za upravljanje</asp:ListItem>
                                    <asp:ListItem Value="K">kategoriji</asp:ListItem>
                                    <asp:ListItem Value="V">valuti</asp:ListItem>
                                    <asp:ListItem Value="UP">upravljanju</asp:ListItem>
                                    <asp:ListItem Value="C">cilju prinosa</asp:ListItem>
                                    <asp:ListItem Value="UL">ulaganju</asp:ListItem>
                                    <asp:ListItem Value="G">geografskoj regiji</asp:ListItem>
                                    <asp:ListItem Value="S">sektoru</asp:ListItem>
                                    <asp:ListItem Value="T">tržištu</asp:ListItem>
                                    <asp:ListItem Value="P">profilu rizičnosti i uspješnosti</asp:ListItem>
                                </asp:DropDownList>
            </div>

            <dxchartsui:WebChartControl ID="qtyChart" runat="server" BackColor="#E6E6E6" CrosshairEnabled="True" CssClass="portfelj_piechart" Height="200px" Width="300px">
                <smallcharttext text="Increase the chart's size to view its layout.
    " />
                <borderoptions color="Transparent" visible="False" />
                <diagramserializable>
                
            <cc1:SimpleDiagram EqualPieSize="False"></cc1:SimpleDiagram></diagramserializable>
                <legend alignmenthorizontal="Center" alignmentvertical="BottomOutside" backcolor="Transparent" markersize="20, 20" textcolor="64, 64, 64">
                    <border visible="False" />
                </legend>
                <seriesserializable>
                <cc1:Series Name="Series 1">
                    <viewserializable>
                        
                    <cc1:PieSeriesView ExplodeMode="All" RuntimeExploding="False"><fillstyle fillmode="Solid"></fillstyle></cc1:PieSeriesView></viewserializable>
                    <labelserializable>
                        
                    <cc1:PieSeriesLabel BackColor="Transparent" TextColor="64, 64, 64" Position="TwoColumns"><border visible="False" /><fillstyle fillmode="Empty"></fillstyle><pointoptionsserializable><cc1:PiePointOptions PercentOptions-PercentageAccuracy="3"><valuenumericoptions format="Percent" precision="1" /></cc1:PiePointOptions></pointoptionsserializable></cc1:PieSeriesLabel></labelserializable>
                    <legendpointoptionsserializable>
                        <cc1:PiePointOptions PercentOptions-PercentageAccuracy="3">
                            <valuenumericoptions format="Percent" precision="1" />
                        </cc1:PiePointOptions>
                    </legendpointoptionsserializable>
                </cc1:Series>
            </seriesserializable>
                <seriestemplate>
                <viewserializable>
                    
                <cc1:PieSeriesView RuntimeExploding="False"></cc1:PieSeriesView></viewserializable>
                <labelserializable>
                    
                <cc1:PieSeriesLabel><pointoptionsserializable><cc1:PiePointOptions><valuenumericoptions format="General" /></cc1:PiePointOptions></pointoptionsserializable></cc1:PieSeriesLabel></labelserializable>
                <legendpointoptionsserializable>
                    <cc1:PiePointOptions>
                        <valuenumericoptions format="General" />
                    </cc1:PiePointOptions>
                </legendpointoptionsserializable>
            </seriestemplate>
            </dxchartsui:WebChartControl>

            <div id="praznoS" runat="server" style="width: 469px; height: 10px">&nbsp;</div>

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="200">
        <ProgressTemplate>
            <div class="progress_message">Učitavanje...</div>
        </ProgressTemplate>
    </asp:UpdateProgress>

</div>