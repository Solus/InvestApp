<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FondPortfeljVrijednostGrafCtrl.ascx.cs" Inherits="InvestApp.Web.FondPortfeljVrijednostGrafCtrl" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraCharts.v13.2.Web, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>

<script type="text/javascript">

    function IntervalChanged(select) {
        
        // decide whether to execute the __doPostBack event, which submits the
        // form back to the server
        if (select.value == 'P') {

            $('#divDatum').toggle(true);
            return false;
        }
        else {
            tbDatumOd.SetDate(null);
            tbDatumDo.SetDate(null);
            $('#divDatum').toggle(false);
            __doPostBack('ddlInterval', '');
        }
    };

</script>

<div class="control_inner_container">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <script type="text/javascript">

                function pageLoad() {

                    var proizvoljno = $('#ddlInterval').val() == 'P';

                    $('#divDatum').toggle(proizvoljno);
                }
            </script>

            <div class="ctrl_search">
                <label for="ddlPrikaz">Inverval:</label>
                <asp:DropDownList ID="ddlInterval" runat="server" ClientIDMode="Static" AutoPostBack="True" onchange="IntervalChanged(this);" OnSelectedIndexChanged="ddlInterval_SelectedIndexChanged">
                    <asp:ListItem Value="1T">1 tjedan</asp:ListItem>
                    <asp:ListItem Value="1M">1 mjesec</asp:ListItem>
                    <asp:ListItem Selected="True" Value="3M">3 mjeseca</asp:ListItem>
                    <asp:ListItem Value="6M">6 mjeseci</asp:ListItem>
                    <asp:ListItem Value="G">Tekuća godina</asp:ListItem>
                    <asp:ListItem Value="1G">1 godina</asp:ListItem>
                    <asp:ListItem Value="2G">2 godine</asp:ListItem>
                    <asp:ListItem Value="P">Proizvoljno</asp:ListItem>
                </asp:DropDownList>

                <div id="divDatum" visible="false">

                    <label for="tbDatumOd">Datum od/do:</label>

                    <dx:ASPxDateEdit CssClass="search_control_date" ClientInstanceName="tbDatumOd" ID="tbDatumOd" runat="server" ForeColor="#5F5F5F"
                        MaxDate="2100-01-01" MinDate="1900-01-01">
                        <CalendarProperties ClearButtonText="Briši" TodayButtonText="Danas">
                        </CalendarProperties>
                    </dx:ASPxDateEdit>

                    <dx:ASPxDateEdit CssClass="search_control_date" ClientInstanceName="tbDatumDo" ID="tbDatumDo" runat="server" ForeColor="#5F5F5F"
                        MaxDate="2100-01-01" MinDate="1900-01-01">
                        <CalendarProperties ClearButtonText="Briši" TodayButtonText="Danas">
                        </CalendarProperties>
                    </dx:ASPxDateEdit>
                    <asp:LinkButton ID="btnTrazi" runat="server" OnClick="btnTrazi_Click" CssClass="search_button">Traži</asp:LinkButton>

                </div>

            </div>

            <dxchartsui:WebChartControl ID="chartPortfelj" CssClass="portfelj_graf" runat="server" EnableClientSideAPI="False" CrosshairEnabled="False" BackColor="Transparent" Height="200px" Width="300px">
                <emptycharttext text="Nema podataka za zadane uvjete pretraživanja." />
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
                    <label>
                        <numericoptions format="Number" precision="0" />
                    </label>
                <gridlines color="255, 255, 255"></gridlines></axisy>
                <defaultpane bordercolor="White" backcolor="230, 230, 230">
                    <fillstyle fillmode="Solid">
                    </fillstyle>
                </defaultpane>
            </cc1:XYDiagram>
        </diagramserializable>
                <legend visible="False"></legend>
                <seriesserializable>
            <cc1:Series Name="Series 1" ArgumentScaleType="DateTime">
                <viewserializable>
                    <cc1:LineSeriesView MarkerVisibility="False" Color="193, 39, 45">
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

        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="200">
        <ProgressTemplate>
            <div class="progress_message">Učitavanje...</div>
        </ProgressTemplate>
    </asp:UpdateProgress>

</div>

