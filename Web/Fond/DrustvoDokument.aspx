<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="DrustvoDokument.aspx.cs" Inherits="InvestApp.Web.DrustvoDokument" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxDataView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxFormLayout" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="EntityDataSourceDrustva" CssClass="form_body">
        <EditItemTemplate>

        </EditItemTemplate>
        <InsertItemTemplate>
            
        </InsertItemTemplate>
        <ItemTemplate>
            
            <h3 class="form_group">OSNOVNE INFORMACIJE DRUŠTVA</h3>

            <div class="form_item">	<label class="form_item_label">naziv:</label>
            <asp:Label ID="NAZIVLabel" runat="server" Text='<%# Bind("NAZIV") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">adresa:</label>
            <asp:Label ID="DRUSTVA_IDLabel" runat="server" Text='<%# Bind("ADRESA") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">matični broj:</label>
            <asp:Label ID="KATEGORIJA_IDLabel" runat="server" Text='<%# Bind("MATICNI_BROJ") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">OIB:</label>
            <asp:Label ID="GEO_IDLabel" runat="server" Text='<%# Bind("OIB") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">tel:</label>
            <asp:Label ID="TIP_ULAGANJA_IDLabel" runat="server" Text='<%# Bind("TEL") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">fax:</label>
            <asp:Label ID="TIP_UPRAVLJANJA_IDLabel" runat="server" Text='<%# Bind("FAX") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">dodatni podaci:</label>
            <asp:Label ID="RIZICNOSTLabel" runat="server" Text='<%# Bind("DODATNI_PODACI") %>' CssClass="form_item_value" /></div>

            <h3 class="form_group">NALOG</h3>
            
            <div class="form_item">	<label class="form_item_label">Broj računa:</label>
            <asp:Label ID="NALOG_PRIMATELJ_VBDILabel" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_VBDI") %>' CssClass="form_item_value" />&nbsp;
            <asp:Label ID="NALOG_PRIMATELJ_RACUNLabel" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_RACUN") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">Poziv na broj:</label>
            <asp:Label ID="NALOG_PBO_MODELLabel" runat="server" Text='<%# Bind("NALOG_PBO_MODEL") %>' CssClass="form_item_value" />&nbsp;
            <asp:Label ID="NALOG_PBOLabel" runat="server" Text='<%# Bind("NALOG_PBO") %>' CssClass="form_item_value" /></div>
            
            <div class="form_item">	<label class="form_item_label">opis plaćanja:</label>
            <asp:Label ID="NALOG_OPIS_PLACANJALabel" runat="server" Text='<%# Bind("NALOG_OPIS_PLACANJA") %>' CssClass="form_item_value" /></div>
            
            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible="False" />&nbsp;
            <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" Visible="False" />&nbsp;
            <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" Visible="False" />
        </ItemTemplate>
    </asp:FormView>

    <asp:Button ID="btnPovratak" runat="server" Text="Povratak" CssClass="btn_navigation" OnClick="btnPovratak_Click" />


    <asp:EntityDataSource ID="EntityDataSourceDrustva" runat="server" ContextTypeName="InvestApp.DAL.FondEntities"  ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" EnableFlattening="False" EntitySetName="Drustva" EntityTypeFilter="Drustvo" >
    </asp:EntityDataSource>

    </asp:Content>

