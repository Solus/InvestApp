<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="DrustvaPregled.aspx.cs" Inherits="InvestApp.Web.DrustvaPregled" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxUploadControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
        function OnUpdateClick() {
            uploader.UploadFile();
        }
    </script>

    <h1 class="form_header bar" id="formHeader" runat="server">Uređivanje društava</h1>

    <div class="form_body">

        <dx:ASPxGridView ID="gvDrustva" runat="server"
            AutoGenerateColumns="False"
            ClientInstanceName="gridDrustvo"
            CssClass="data_table admin"
            KeyFieldName="ID"
            DataSourceID="EntityDataSourceDrustva"
            OnRowUpdating="gvDrustva_RowUpdating"
            OnRowInserting="gvDrustva_RowInserting"
            EnableCallBacks="false" >
            <Columns>
                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false"></dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Naziv" FieldName="NAZIV" ShowInCustomizationForm="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataImageColumn Caption="Logo" FieldName="LOGO_URL" ToolTip="Logo društva" VisibleIndex="2" Width="150px">
                    <PropertiesImage ImageAlign="Left" ImageHeight="15px">
                    </PropertiesImage>
                </dx:GridViewDataImageColumn>

                <dx:GridViewCommandColumn ButtonType="Image" ShowDeleteButton="false" ShowEditButton="true" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="3" Width="70px">

                    <HeaderStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        <asp:Button ID="btnNovi" runat="server" CssClass="btn_grid_akcija right" OnClientClick="gridDrustvo.AddNewRow(); return false;" Text="Novo društvo" UseSubmitBehavior="true" />
                    </HeaderTemplate>
                </dx:GridViewCommandColumn>
            </Columns>
            <SettingsBehavior ConfirmDelete="True" />
            <SettingsPager Mode="ShowAllRecords">
            </SettingsPager>
            <SettingsEditing Mode="PopupEditForm" NewItemRowPosition="Bottom">
            </SettingsEditing>
            <SettingsPopup EditForm-HorizontalAlign="Center" EditForm-VerticalAlign="TopSides"></SettingsPopup>
            <Settings ShowStatusBar="Hidden" />
            <SettingsText ConfirmDelete="Želite li obrisati društvo?" EmptyDataRow="Nema podataka" PopupEditFormCaption="Društvo" />
            <SettingsCommandButton>
                <UpdateButton ButtonType="Image">
                    <Image ToolTip="Spremi" Url="../Images/check.png">
                    </Image>
                </UpdateButton>
                <CancelButton ButtonType="Image" Text="Odustani">
                    <Image ToolTip="Odustani" Url="../Images/cancel.png">
                    </Image>
                </CancelButton>
                <EditButton ButtonType="Image">
                    <Image ToolTip="Ispravi" Url="../Images/pencil.png">
                    </Image>
                </EditButton>
                <DeleteButton ButtonType="Image">
                    <Image ToolTip="Obriši" Url="../Images/trash_light.png">
                    </Image>
                </DeleteButton>
            </SettingsCommandButton>
            <Border BorderColor="#DDDDDD" />
            <Templates>
                <EditForm>

                    <asp:HiddenField ID="txtID" runat="server" Value='<%# Eval("ID") %>' ></asp:HiddenField>

                    <div class="form_item">
                        <label class="form_item_label_edit small">Naziv:</label>
                        <asp:TextBox ID="txtNaziv" runat="server" Text='<%# Bind("NAZIV") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit small">Adresa:</label>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ADRESA") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit small">Logo:</label>
                        <asp:Image ID="imgLOGO" runat="server" ImageUrl='<%# Eval("LOGO_URL") %>' CssClass="" Height="25px" />

                        <asp:FileUpload ID="fileLogo" runat="server" ToolTip="Odaberite sliku" />
                    </div>

                    <h3 class="form_group">PODACI ZA UPLATU</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">IBAN:</label>
                        <asp:TextBox ID="txtRacun" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_RACUN") %>' CssClass="form_item_value_edit" MaxLength="21" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit" for="ddlBanke">Model i poziv na broj:</label>
                        <asp:TextBox ID="txtPBModel" placeholder="Model" CssClass="form_item_value_edit small" runat="server" ClientIDMode="Static" Text='<%# Bind("NALOG_PBO_MODEL") %>' MaxLength="4" />
                        <asp:TextBox ID="txtPBO" placeholder="Poziv na broj" ClientIDMode="Static" CssClass="form_item_value_edit racun" runat="server" Text='<%# Bind("NALOG_PBO") %>' />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Šifra namjene:</label>
                        <asp:TextBox ID="txtSifraNamjene" runat="server" Text='<%# Bind("NALOG_SIFRA_NAMJENE") %>' CssClass="form_item_value_edit" MaxLength="4" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Opis plaćanja:</label>
                        <asp:TextBox ID="txtOpisPlacanja" runat="server" Text='<%# Bind("NALOG_OPIS_PLACANJA") %>' CssClass="form_item_value_edit" MaxLength="500" TextMode="MultiLine" />
                    </div>

                    <div class="btn_navigation_group">

                        <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
                        <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server"></dx:ASPxGridViewTemplateReplacement>

                    </div>

                </EditForm>
            </Templates>
        </dx:ASPxGridView>

    </div>



    <asp:EntityDataSource ID="EntityDataSourceDrustva" runat="server"
        ConnectionString="name=FondEntities"
        DefaultContainerName="FondEntities"
        ContextTypeName="InvestApp.DAL.FondEntities"
        EnableDelete="True"
        EnableFlattening="False"
        EnableInsert="True"
        EnableUpdate="True"
        EntitySetName="Drustva"
        EntityTypeFilter="Drustvo" OrderBy="it.NAZIV" >
    </asp:EntityDataSource>



</asp:Content>
