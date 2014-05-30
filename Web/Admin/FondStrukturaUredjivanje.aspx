<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondStrukturaUredjivanje.aspx.cs" Inherits="InvestApp.Web.FondStrukturaUredjivanje" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h1 class="form_header bar" id="formHeader" runat="server">Struktura</h1>

    <div class="form_body">

        <dx:ASPxPageControl ID="ASPxPageControl1" runat="server" ActiveTabIndex="0" Width="100%">
            <TabPages>
                <dx:TabPage Text="Top 10 ulaganja">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                            <dx:ASPxGridView ID="gvStrukturaTop10" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridT" CssClass="data_table admin" DataSourceID="EntityDataSourceStrukturaTop10" KeyFieldName="ID">
                                <Columns>
                                    <dx:GridViewCommandColumn ButtonType="Image" Caption="&nbsp;" ShowDeleteButton="True" VisibleIndex="5" Width="60px" ShowCancelButton="True" ShowUpdateButton="True" ShowEditButton="True" ShowNewButtonInHeader="true">
                                        <HeaderTemplate>
                                            <asp:Button ID="btnNova" runat="server" OnClientClick="gridT.AddNewRow(); return false;" Text="Dodaj" UseSubmitBehavior="false" CssClass="btn_grid_akcija right" />
                                        </HeaderTemplate>
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ZAGLAVLJE_ID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Naziv" FieldName="NAZIV" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Udio[%]" FieldName="UDIO" ShowInCustomizationForm="True" VisibleIndex="4" Width="50px">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsPager Mode="ShowAllRecords">
                                </SettingsPager>
                                <SettingsEditing Mode="Inline" NewItemRowPosition="Bottom">
                                </SettingsEditing>
                                <Settings ShowStatusBar="Hidden" ShowTitlePanel="false" />
                                <SettingsText Title="Top 10 ulaganja" EmptyDataRow="Nema podataka" />
                                <SettingsCommandButton>
                                    <NewButton ButtonType="Button" Text="Novo">
                                    </NewButton>
                                    <UpdateButton ButtonType="Image">
                                        <Image ToolTip="Spremi" Url="../Images/check.png"></Image>
                                    </UpdateButton>
                                    <CancelButton ButtonType="Image" Text="Odustani">
                                        <Image ToolTip="Odustani" Url="../Images/cancel.png"></Image>
                                    </CancelButton>
                                    <DeleteButton ButtonType="Image">
                                        <Image ToolTip="Obriši" Url="../Images/trash.png"></Image>
                                    </DeleteButton>
                                    <EditButton ButtonType="Image">
                                        <Image ToolTip="Ispravi" Url="../Images/edit.png"></Image>
                                    </EditButton>
                                </SettingsCommandButton>
                            </dx:ASPxGridView>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Geografska struktura">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                            <dx:ASPxGridView ID="gvStrukturaGeo" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridGeo" CssClass="data_table admin" DataSourceID="EntityDataSourceStrukturaGeo" KeyFieldName="ID">
                                <Columns>
                                    <dx:GridViewCommandColumn ButtonType="Image" Caption="&nbsp;" ShowDeleteButton="True" VisibleIndex="5" Width="60px" ShowCancelButton="True" ShowUpdateButton="True" ShowEditButton="True" ShowNewButtonInHeader="true">
                                        <HeaderTemplate>
                                            <asp:Button ID="btnNova" runat="server" OnClientClick="gridGeo.AddNewRow(); return false;" Text="Dodaj" UseSubmitBehavior="false" CssClass="btn_grid_akcija right" />
                                        </HeaderTemplate>
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ZAGLAVLJE_ID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Naziv" FieldName="NAZIV" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Udio[%]" FieldName="UDIO" ShowInCustomizationForm="True" VisibleIndex="4" Width="50px">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsPager Mode="ShowAllRecords">
                                </SettingsPager>
                                <SettingsEditing Mode="Inline" NewItemRowPosition="Bottom">
                                </SettingsEditing>
                                <Settings ShowStatusBar="Hidden" ShowTitlePanel="false" />
                                <SettingsText Title="Geografska struktura" EmptyDataRow="Nema podataka" />
                                <SettingsCommandButton>
                                    <NewButton ButtonType="Button" Text="Novo">
                                    </NewButton>
                                    <UpdateButton ButtonType="Image">
                                        <Image ToolTip="Spremi" Url="../Images/check.png"></Image>
                                    </UpdateButton>
                                    <CancelButton ButtonType="Image" Text="Odustani">
                                        <Image ToolTip="Odustani" Url="../Images/cancel.png"></Image>
                                    </CancelButton>
                                    <DeleteButton ButtonType="Image">
                                        <Image ToolTip="Obriši" Url="../Images/trash.png"></Image>
                                    </DeleteButton>
                                    <EditButton ButtonType="Image">
                                        <Image ToolTip="Ispravi" Url="../Images/edit.png"></Image>
                                    </EditButton>
                                </SettingsCommandButton>
                            </dx:ASPxGridView>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Sektorska izloženost">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                            <dx:ASPxGridView ID="gvStrukturaSek" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridSek" CssClass="data_table admin" DataSourceID="EntityDataSourceStrukturaSekt" KeyFieldName="ID">
                                <Columns>
                                    <dx:GridViewCommandColumn ButtonType="Image" Caption="&nbsp;" ShowDeleteButton="True" VisibleIndex="5" Width="60px" ShowCancelButton="True" ShowUpdateButton="True" ShowEditButton="True" ShowNewButtonInHeader="true">
                                        <HeaderTemplate>
                                            <asp:Button ID="btnNova" runat="server" OnClientClick="gridSek.AddNewRow(); return false;" Text="Dodaj" UseSubmitBehavior="false" CssClass="btn_grid_akcija right" />
                                        </HeaderTemplate>
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ZAGLAVLJE_ID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Naziv" FieldName="NAZIV" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Udio[%]" FieldName="UDIO" ShowInCustomizationForm="True" VisibleIndex="4" Width="50px">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsPager Mode="ShowAllRecords">
                                </SettingsPager>
                                <SettingsEditing Mode="Inline" NewItemRowPosition="Bottom">
                                </SettingsEditing>
                                <Settings ShowStatusBar="Hidden" ShowTitlePanel="false" />
                                <SettingsText Title="Sektorska izloženost" EmptyDataRow="Nema podataka" />
                                <SettingsCommandButton>
                                    <NewButton ButtonType="Button" Text="Novo">
                                    </NewButton>
                                    <UpdateButton ButtonType="Image">
                                        <Image ToolTip="Spremi" Url="../Images/check.png"></Image>
                                    </UpdateButton>
                                    <CancelButton ButtonType="Image" Text="Odustani">
                                        <Image ToolTip="Odustani" Url="../Images/cancel.png"></Image>
                                    </CancelButton>
                                    <DeleteButton ButtonType="Image">
                                        <Image ToolTip="Obriši" Url="../Images/trash.png"></Image>
                                    </DeleteButton>
                                    <EditButton ButtonType="Image">
                                        <Image ToolTip="Ispravi" Url="../Images/edit.png"></Image>
                                    </EditButton>
                                </SettingsCommandButton>
                            </dx:ASPxGridView>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Valutna izloženost">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                            <dx:ASPxGridView ID="gvStrukturaVal" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridVal" CssClass="data_table admin" DataSourceID="EntityDataSourceStrukturaVal" KeyFieldName="ID">
                                <Columns>
                                    <dx:GridViewCommandColumn ButtonType="Image" Caption="&nbsp;" ShowDeleteButton="True" VisibleIndex="5" Width="60px" ShowCancelButton="True" ShowUpdateButton="True" ShowEditButton="True" ShowNewButtonInHeader="true">
                                        <HeaderTemplate>
                                            <asp:Button ID="btnNova" runat="server" OnClientClick="gridVal.AddNewRow(); return false;" Text="Dodaj" UseSubmitBehavior="false" CssClass="btn_grid_akcija right" />
                                        </HeaderTemplate>
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ZAGLAVLJE_ID" ShowInCustomizationForm="True" Visible="False" VisibleIndex="2">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Naziv" FieldName="NAZIV" ShowInCustomizationForm="True" VisibleIndex="3">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn Caption="Udio[%]" FieldName="UDIO" ShowInCustomizationForm="True" VisibleIndex="4" Width="50px">
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsPager Mode="ShowAllRecords">
                                </SettingsPager>
                                <SettingsEditing Mode="Inline" NewItemRowPosition="Bottom">
                                </SettingsEditing>
                                <Settings ShowStatusBar="Hidden" ShowTitlePanel="false" />
                                <SettingsText Title="Valutna izloženost" EmptyDataRow="Nema podataka" />
                                <SettingsCommandButton>
                                    <NewButton ButtonType="Button" Text="Novo">
                                    </NewButton>
                                    <UpdateButton ButtonType="Image">
                                        <Image ToolTip="Spremi" Url="../Images/check.png"></Image>
                                    </UpdateButton>
                                    <CancelButton ButtonType="Image" Text="Odustani">
                                        <Image ToolTip="Odustani" Url="../Images/cancel.png"></Image>
                                    </CancelButton>
                                    <DeleteButton ButtonType="Image">
                                        <Image ToolTip="Obriši" Url="../Images/trash.png"></Image>
                                    </DeleteButton>
                                    <EditButton ButtonType="Image">
                                        <Image ToolTip="Ispravi" Url="../Images/edit.png"></Image>
                                    </EditButton>
                                </SettingsCommandButton>
                            </dx:ASPxGridView>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
            </TabPages>
        </dx:ASPxPageControl>

        <div class="btn_navigation_group snug">
            <asp:Button ID="UpdateCancelButton" runat="server" Text="Povratak" CssClass="btn_navigation" OnClick="UpdateCancelButton_Click" UseSubmitBehavior="false" />
        </div>

        <asp:EntityDataSource ID="EntityDataSourceStrukturaTop10"
            ContextTypeName="InvestApp.DAL.FondEntities" runat="server"
            ConnectionString="name=FondEntities"
            DefaultContainerName="FondEntities"
            EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
            EntitySetName="StruktureUlaganjaDetalji" EntityTypeFilter="StrukturaUlaganjaDetalji"
            AutoGenerateWhereClause="true"
            OnInserting="EntityDataSourceStrukturaTop10_Inserting">
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EntityDataSourceStrukturaGeo"
            ContextTypeName="InvestApp.DAL.FondEntities" runat="server"
            ConnectionString="name=FondEntities"
            DefaultContainerName="FondEntities"
            EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
            EntitySetName="StruktureUlaganjaDetalji"
            EntityTypeFilter="StrukturaUlaganjaDetalji"
            AutoGenerateWhereClause="true"
            OnInserting="EntityDataSourceStrukturaGeo_Inserting">
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EntityDataSourceStrukturaSekt"
            ContextTypeName="InvestApp.DAL.FondEntities" runat="server"
            ConnectionString="name=FondEntities"
            DefaultContainerName="FondEntities"
            EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
            EntitySetName="StruktureUlaganjaDetalji"
            EntityTypeFilter="StrukturaUlaganjaDetalji"
            AutoGenerateWhereClause="true"
            OnInserting="EntityDataSourceStrukturaSekt_Inserting">
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EntityDataSourceStrukturaVal"
            ContextTypeName="InvestApp.DAL.FondEntities" runat="server"
            ConnectionString="name=FondEntities"
            DefaultContainerName="FondEntities"
            EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
            EntitySetName="StruktureUlaganjaDetalji"
            EntityTypeFilter="StrukturaUlaganjaDetalji"
            AutoGenerateWhereClause="true"
            OnInserting="EntityDataSourceStrukturaVal_Inserting">
        </asp:EntityDataSource>

    </div>

</asp:Content>
