<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondCijeneUdjelaUredjivanje.aspx.cs" Inherits="InvestApp.Web.FondCijeneUdjelaUredjivanje" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h1 class="form_header bar" id="formHeader" runat="server">Cijene udjela</h1>

    <div class="form_body">

        <div class="form_item">
            <label class="form_item_label_edit small" for="ddlFondovi">Fond:</label>
            <asp:DropDownList ID="ddlFondovi" runat="server" AutoPostBack="true" CssClass="form_item_value_edit" DataTextField="NAZIV" DataValueField="ID" OnSelectedIndexChanged="ddlFondovi_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <div class="form_item" id="divCijeneUpload" runat="server" visible="false">
            <asp:FileUpload ID="uploadCijene" runat="server" />
            <asp:LinkButton ID="btnUcitajCijene" runat="server" CausesValidation="True" Text="Učitaj cijene (.csv)" OnClick="btnUcitajCijene_Click" />

            <asp:Label CssClass="poruka_small" ID="lblUploadPoruka" runat="server"></asp:Label>
            <%--<asp:CustomValidator ID="valCijeneUpload" runat="server" ErrorMessage="Datoteka mora biti u .csv formatu" OnServerValidate="valCijeneUpload_ServerValidate" Display="Dynamic"></asp:CustomValidator>--%>
        </div>

        <dx:ASPxGridView ID="gvCijene" runat="server" 
            AutoGenerateColumns="False" 
            ClientInstanceName="gridCijene" 
            CssClass="data_table admin" 
            DataSourceID="EntityDataSourceCijene" 
            KeyFieldName="ID" 
            OnRowInserting="gvCijene_RowInserting" 
            OnRowUpdating="gvCijene_RowUpdating" 
            OnCellEditorInitialize="gvCijene_CellEditorInitialize" 
            OnRowDeleting="gvCijene_RowDeleting"
            SettingsBehavior-ConfirmDelete="true"
            SettingsText-ConfirmDelete="Želite li obrisati cijenu?" >
            <Columns>
                <dx:GridViewCommandColumn 
                    Name="COMMAND" ButtonType="Image" Caption="&nbsp;" 
                    ShowDeleteButton="True" 
                    VisibleIndex="4" Width="60px" ShowCancelButton="True" ShowUpdateButton="True" ShowEditButton="True" ShowNewButtonInHeader="true">
                    <HeaderTemplate>
                        <asp:Button ID="btnNova" runat="server" OnClientClick="gridCijene.AddNewRow(); return false;" Text="Dodaj" UseSubmitBehavior="false" CssClass="btn_grid_akcija right" />
                    </HeaderTemplate>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" Visible="False" VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="FOND_ID" Visible="False" VisibleIndex="1">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Cijena" Name="VRIJEDNOST" FieldName="VRIJEDNOST" VisibleIndex="3" Width="70px">
                    <PropertiesTextEdit DisplayFormatString="n4">
                    </PropertiesTextEdit>
                    <HeaderStyle HorizontalAlign="Right" />
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataDateColumn Caption="Datum" Name="DATUM" FieldName="DATUM" VisibleIndex="2">
                    <PropertiesDateEdit DisplayFormatInEditMode="True" DisplayFormatString="dd.MM.yyyy" EditFormat="DateTime" EditFormatString="dd.MM.yyyy">
                        <CalendarProperties TodayButtonText="Danas">
                        </CalendarProperties>
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>

            </Columns>
            <SettingsBehavior AllowDragDrop="False" />
            <SettingsPager>
                <Summary AllPagesText="Stranica: {0} - {1} ({2} zapisa)" Text="Stranica {0} od {1} ({2} zapisa)" />
            </SettingsPager>
            <SettingsEditing Mode="Inline" NewItemRowPosition="Top">
                <BatchEditSettings EditMode="Row" />
            </SettingsEditing>
            <Settings ShowStatusBar="Hidden" ShowTitlePanel="True" />
            <SettingsText Title="Cijene" EmptyDataRow="Nema podataka za odabrani fond" />
            <SettingsCommandButton>
                <NewButton ButtonType="Button" Text="Nova">
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
            <Templates>
                <%--<StatusBar>
                    <asp:Button ID="btnNova" runat="server" OnClientClick="gridCijene.AddNewRow(); return false;" Text="Dodaj" UseSubmitBehavior="false"  CssClass="btn_grid_akcija right"/>
                    <dx:ASPxGridViewTemplateReplacement ID="btnUpdate" runat="server" ReplacementType="EditFormUpdateButton" />
                    <dx:ASPxGridViewTemplateReplacement ID="btnCancel" runat="server" ReplacementType="EditFormCancelButton" />
                </StatusBar>--%>
            </Templates>
        </dx:ASPxGridView>

        <div class="btn_navigation_group snug">
            <asp:Button ID="UpdateCancelButton" runat="server" Text="Povratak" CssClass="btn_navigation" OnClick="UpdateCancelButton_Click" />
        </div>

    </div>

    <asp:EntityDataSource ID="EntityDataSourceFondovi" runat="server"
        ContextTypeName="InvestApp.DAL.FondEntities"
        ConnectionString="name=FondEntities" DefaultContainerName="FondEntities"
        EnableFlattening="False"
        EntitySetName="Fondovi" EntityTypeFilter="Fond"
        OrderBy="it.[NAZIV]"
        AutoGenerateWhereClause="true">
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="EntityDataSourceCijene" runat="server"
        ConnectionString="name=FondEntities"
        DefaultContainerName="FondEntities"
        EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
        EntitySetName="FondVrijednosti"
        EntityTypeFilter="FondVrijednost"
        OrderBy="it.DATUM DESC"
        AutoGenerateWhereClause="true">
    </asp:EntityDataSource>

</asp:Content>

