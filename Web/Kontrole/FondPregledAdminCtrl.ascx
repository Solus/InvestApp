<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FondPregledAdminCtrl.ascx.cs" Inherits="InvestApp.Web.FondPregledAdminCtrl" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<dx:ASPxGridView ID="gvFondovi" runat="server"
     AutoGenerateColumns="False" DataSourceID="EntityDataSource1" KeyFieldName="ID" Theme="Default" 
    OnCustomButtonCallback="gvFondovi_CustomButtonCallback" EnableTheming="True" OnCustomGroupDisplayText="gvFondovi_CustomGroupDisplayText">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false" >
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="VALUTA_SIFRA" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="POCETNA_CIJENA_UDJELA" VisibleIndex="3">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataDateColumn FieldName="DATUM_OSNIVANJA" VisibleIndex="4">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataDateColumn FieldName="VRIJEDI_OD" VisibleIndex="5">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataDateColumn FieldName="VRIJEDI_DO" VisibleIndex="6">
        </dx:GridViewDataDateColumn>
        <dx:GridViewDataTextColumn FieldName="NAZIV" VisibleIndex="1">
        </dx:GridViewDataTextColumn>
        <dx:GridViewCommandColumn VisibleIndex="8" Width="100px" ShowDeleteButton="True">
            <CustomButtons>
                <dx:GridViewCommandColumnCustomButton ID="btnEdit" Text="Ispravka"></dx:GridViewCommandColumnCustomButton>
            </CustomButtons>
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="KATEGORIJA_ID" VisibleIndex="7">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Kategorija.NAZIV" Caption="Kategorija" VisibleIndex="7" Visible="false">
        </dx:GridViewDataTextColumn>
    </Columns>
    <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="true" />
    <SettingsBehavior ConfirmDelete="true" />
</dx:ASPxGridView>

<asp:Button ID="btnNovi" runat="server" Text="Novi" OnClick="btnNovi_Click" CausesValidation="False" />

<asp:EntityDataSource ID="EntityDataSource1" runat="server" ConnectionString="name=FondEntities" DefaultContainerName="FondEntities"
     EnableFlattening="False" EntitySetName="Fondovi" EntityTypeFilter="Fond" Include="Kategorija"
     EnableDelete="true" >
</asp:EntityDataSource>
