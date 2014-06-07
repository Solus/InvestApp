<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FondPrinosiGrafCtrl.ascx.cs" Inherits="InvestApp.Web.FondPrinosiGrafCtrl" %>
<%@ Register Assembly="DevExpress.XtraCharts.v13.2.Web, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register assembly="DevExpress.XtraCharts.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>

<dxchartsui:WebChartControl ID="chartCijene" CssClass="graf_cijene" runat="server" 
    OnDataBinding="chartCijene_DataBinding" 
    EnableClientSideAPI="False" 
    CrosshairEnabled="False" 
    BackColor="Transparent" 
    Height="200px" Width="300px" >
    <borderoptions visible="False" />
    <diagramserializable>
            <cc1:XYDiagram>
                <axisx visibleinpanesserializable="-1" color="White">
                    <autoscalebreaks maxcount="10" />
                    <tickmarks minorlength="3" />
                    <label staggered="False">
                    <datetimeoptions autoformat="False" format="Custom" formatstring="dd.MM.yyyy" />
                    </label>
                    <gridlines color="255, 255, 255" visible="True"></gridlines><numericscaleoptions autogrid="False" />
                    <datetimescaleoptions scalemode="Continuous">
                    </datetimescaleoptions>
                </axisx>
                <axisy visibleinpanesserializable="-1" color="White">
                    <label endtext="%">
                        <numericoptions format="Number" precision="0" />
                    </label>
                <gridlines color="255, 255, 255"></gridlines></axisy>
                <defaultpane bordercolor="White" backcolor="230, 230, 230">
                    <fillstyle fillmode="Solid">
                    </fillstyle>
                </defaultpane>
            </cc1:XYDiagram>
        </diagramserializable>
    <legend alignmenthorizontal="Center" alignmentvertical="BottomOutside" backcolor="230, 230, 230" equallyspaceditems="False" visible="False">
        <border visible="False" />
    </legend>
    <seriesserializable>
            <cc1:Series Name="Series 1" ArgumentScaleType="DateTime">
                <viewserializable>
                    <cc1:LineSeriesView MarkerVisibility="False" >
                        <linemarkeroptions bordervisible="False" color="Transparent">
                            <fillstyle fillmode="Solid">
                            </fillstyle>
                        </linemarkeroptions>
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
    <titles>
        <cc1:ChartTitle Font="Tahoma, 10pt" Text="" Visible="False" Antialiasing="False" Indent="0" />
    </titles>
</dxchartsui:WebChartControl>

<asp:Repeater ID="repeaterLegend" runat="server" OnItemCreated="repeaterLegend_ItemCreated">
    <HeaderTemplate>
        <ul class="chart_legend">
    </HeaderTemplate>
    <ItemTemplate>
        <li id="liItem" runat="server"><%# Container.DataItem %></li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater>
