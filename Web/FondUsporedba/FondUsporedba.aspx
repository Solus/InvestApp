<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondUsporedba.aspx.cs" Inherits="InvestApp.Web.FondUsporedba" %>

<%@ Register Assembly="DevExpress.XtraCharts.v13.2.Web, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.XtraCharts.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Src="~/Kontrole/FondPrinosiTablicaCtrl.ascx" TagPrefix="uc1" TagName="FondPrinosiTablicaCtrl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        function pageLoad() {

            var proizvoljno = $('#hidProizvoljno').val();

            if (proizvoljno == 'true')
                $('#divDatum').toggle(true);
        }

        function toggleDatum() {

            $('#divDatum').toggle();

            var opened = $('#divDatum').is(":visible");

            $('.search_list a[href^=javascript]').toggleClass("opened", opened);
        }

        $(document).ready(function () {

            $('.fond_usporedba_table tr:nth-child(1)').addClass("first_child");
            $('.fond_usporedba_table tr:nth-child(2)').addClass("second_child");
            $('.fond_usporedba_table tr:nth-child(3)').addClass("third_child");
            $('.fond_usporedba_table tr:nth-child(4)').addClass("fourth_child");

            $('.prinosi_table th:nth-child(2)').addClass("second_child");
            $('.prinosi_table th:nth-child(3)').addClass("third_child");
            $('.prinosi_table th:nth-child(4)').addClass("fourth_child");
            $('.prinosi_table th:nth-child(5)').addClass("fifth_child");

        });
    </script>

    <asp:HiddenField ID="hidProizvoljno" runat="server" ClientIDMode="Static" />

    <h1 class="form_header bar">Usporedba fondova</h1>

    <asp:Label ID="lblLog" runat="server"></asp:Label>

    <div class="form_body_table">

        <asp:Menu ID="menuPeriod" runat="server" CssClass="search_list items8" RenderingMode="List" IncludeStyleBlock="False" EnableViewState="true" SkipLinkText="" OnMenuItemClick="menuPeriod_MenuItemClick">
            <Items>
                <asp:MenuItem Text="1 mjesec" Value="1M"></asp:MenuItem>
                <asp:MenuItem Text="3 mjeseca" Value="3M"></asp:MenuItem>
                <asp:MenuItem Text="6 mjeseci" Value="6M"></asp:MenuItem>
                <asp:MenuItem Text="1 godina" Value="1G" Selected="true"></asp:MenuItem>
                <asp:MenuItem Text="3 godine" Value="3G"></asp:MenuItem>
                <asp:MenuItem Text="5 godina" Value="5G"></asp:MenuItem>
                <asp:MenuItem Text="MAX" Value="SVI"></asp:MenuItem>
                <asp:MenuItem Text="Proizvoljno" Value="P" NavigateUrl="javascript: toggleDatum(); "></asp:MenuItem>
            </Items>
        </asp:Menu>

        <div class="search_group">

            <div class="search_item_group fond_usporedba_container">

                <%--<label class="search_label" for="ddlInterval">Dodaj fond:</label>--%>
                <div class="fond_usporedba_container_inner">

                    <div class="fond_usporedba_select">
                        <asp:DropDownList ID="ddlFondoviSvi" ClientIDMode="Static" runat="server" DataTextField="NAZIV" DataValueField="ID" CssClass="search_control"></asp:DropDownList>
                        <asp:Button ID="btnDodajSvi" runat="server" Text="" OnClick="btnDodajSvi_Click" CssClass="btn_usporedba_dodaj" ToolTip="Dodaj" OnClientClick="return $('#ddlFondoviSvi').val() != -1;" />
                    </div>
                    <div class="fond_usporedba_select">
                        <asp:DropDownList ID="ddlFondoviDionicki" ClientIDMode="Static" runat="server" DataTextField="NAZIV" DataValueField="ID" CssClass="search_control"></asp:DropDownList>
                        <asp:Button ID="btnDodajDionicki" runat="server" Text="" OnClick="btnDodajDionicki_Click" CssClass="btn_usporedba_dodaj" ToolTip="Dodaj" OnClientClick="return $('#ddlFondoviDionicki').val() != -1;" />
                    </div>
                    <div class="fond_usporedba_select">
                        <asp:DropDownList ID="ddlFondoviMjesoviti" ClientIDMode="Static" runat="server" DataTextField="NAZIV" DataValueField="ID" CssClass="search_control"></asp:DropDownList>
                        <asp:Button ID="btnDodajMjesoviti" runat="server" Text="" OnClick="btnDodajMjesoviti_Click" CssClass="btn_usporedba_dodaj" ToolTip="Dodaj" OnClientClick="return $('#ddlFondoviMjesoviti').val() != -1;" />
                    </div>
                    <div class="fond_usporedba_select">
                        <asp:DropDownList ID="ddlFondoviObveznicki" ClientIDMode="Static" runat="server" DataTextField="NAZIV" DataValueField="ID" CssClass="search_control"></asp:DropDownList>
                        <asp:Button ID="btnDodajObveznicki" runat="server" Text="" OnClick="btnDodajObveznicki_Click" CssClass="btn_usporedba_dodaj" ToolTip="Dodaj" OnClientClick="return $('#ddlFondoviObveznicki').val() != -1;" />
                    </div>
                    <div class="fond_usporedba_select">
                        <asp:DropDownList ID="ddlFondoviNovcani" ClientIDMode="Static" runat="server" DataTextField="NAZIV" DataValueField="ID" CssClass="search_control"></asp:DropDownList>
                        <asp:Button ID="btnDodajNovcani" runat="server" Text="" OnClick="btnDodajNovcani_Click" CssClass="btn_usporedba_dodaj" ToolTip="Dodaj" OnClientClick="return $('#ddlFondoviNovcani').val() != -1;" />
                    </div>

                </div>

            </div>


            <%--<div class="search_item_group">
                        <label class="search_label" for="ddlInterval">Interval:</label>

                        <asp:DropDownList CssClass="search_control" ID="ddlInterval" runat="server" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlInterval_SelectedIndexChanged">
                            <asp:ListItem Value="1T">1 tjedan</asp:ListItem>
                            <asp:ListItem Value="1M">1 mjesec</asp:ListItem>
                            <asp:ListItem Value="3M">3 mjeseca</asp:ListItem>
                            <asp:ListItem Value="6M">6 mjeseci</asp:ListItem>
                            <asp:ListItem Value="G">Tekuća godina</asp:ListItem>
                            <asp:ListItem Value="1G">1 godina</asp:ListItem>
                            <asp:ListItem Value="2G">2 godine</asp:ListItem>
                            <asp:ListItem Value="O">Od osnivanja</asp:ListItem>
                            <asp:ListItem Value="P">Proizvoljno</asp:ListItem>
                        </asp:DropDownList>
                    </div>--%>

            <div id="divDatum" class="search_item_group search_date_range" style="display: none;">

                <label class="search_label" for="tbDatumOd">Interval:</label>

                <dx:ASPxDateEdit CssClass="search_control_date" ID="tbDatumOd" runat="server" ForeColor="#5F5F5F"
                    MaxDate="2100-01-01" MinDate="1900-01-01">
                    <CalendarProperties ClearButtonText="Briši" TodayButtonText="Danas">
                    </CalendarProperties>
                </dx:ASPxDateEdit>

                <dx:ASPxDateEdit CssClass="search_control_date" ID="tbDatumDo" runat="server" ForeColor="#5F5F5F"
                    MaxDate="2100-01-01" MinDate="1900-01-01">
                    <CalendarProperties ClearButtonText="Briši" TodayButtonText="Danas">
                    </CalendarProperties>
                </dx:ASPxDateEdit>
                <asp:LinkButton ID="btnTrazi" runat="server" OnClick="btnTrazi_Click" CssClass="search_button">Traži</asp:LinkButton>

            </div>

        </div>


        <div class="clearfix"></div>

        <div id="divGraf" runat="server" class="graf_usporedba_container">
            <div style="padding: 5px;">
                <asp:Label ID="lblPoruka" runat="server" Text="" Font-Bold="true" ForeColor="#C02750" Font-Size="12px"></asp:Label>
            </div>

            <dxchartsui:WebChartControl ID="chartUsporedba" runat="server" EnableClientSideAPI="false" CrosshairEnabled="false" Height="400px" Width="845px" CssClass="graf_usporedba">
            </dxchartsui:WebChartControl>

            <div class="fond_usporedba_table">
                <asp:GridView ID="gvFondovi" runat="server" AutoGenerateColumns="False" OnRowDeleting="gvFondovi_RowDeleting" ShowHeader="false" DataKeyNames="ID">
                    <Columns>
                        <asp:BoundField DataField="ID" Visible="false" />
                        <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Images/delete_circle_red.png" ShowDeleteButton="True" ControlStyle-CssClass="fond_usporedba_delete">
                        </asp:CommandField>
                        <asp:TemplateField>
                            <ItemTemplate><span class="fond_usporedba_color"></span></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NAZIV" />
                    
                    </Columns>
                </asp:GridView>
            </div>

        </div>

        <uc1:FondPrinosiTablicaCtrl runat="server" ID="tablePrinosi" DetaljneLabele="true" />

    </div>

    <asp:Repeater ID="Repeater1" runat="server"></asp:Repeater>

</asp:Content>
