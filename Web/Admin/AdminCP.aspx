<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="AdminCP.aspx.cs" Inherits="InvestApp.Web.Admin.AdminCP" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTabControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxClasses" TagPrefix="dx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h1 class="form_header bar" id="formHeader" runat="server">Uređivanje korisnika</h1>

    <div class="form_body">

        <dx:ASPxGridView ID="gvKorisnici" runat="server" AutoGenerateColumns="False" ClientInstanceName="gridUser" CssClass="data_table admin" KeyFieldName="UserName" OnCustomButtonCallback="gvKorisnici_CustomButtonCallback" OnDataBinding="gvKorisnici_DataBinding" OnRowDeleting="gvKorisnici_RowDeleting">
            <Columns>
                <dx:GridViewDataTextColumn Caption="Username" FieldName="UserName" ReadOnly="True" ShowInCustomizationForm="True" VisibleIndex="0" Width="20px">
                    <HeaderStyle HorizontalAlign="Center" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="E-mail" FieldName="Email" ShowInCustomizationForm="True" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn Caption="Roles" FieldName="Roles" ShowInCustomizationForm="True" VisibleIndex="2">
                </dx:GridViewDataTextColumn>
                <dx:GridViewCommandColumn ButtonType="Image" ShowDeleteButton="True" ShowInCustomizationForm="True" ShowNewButtonInHeader="True" VisibleIndex="16" Width="70px">
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="btnEdit" Text="Ispravka">
                            <Image ToolTip="Ispravka" Url="~/Images/pencil.png">
                            </Image>
                        </dx:GridViewCommandColumnCustomButton>
                    </CustomButtons>
                    <HeaderStyle HorizontalAlign="Center" />
                    <HeaderTemplate>
                        <asp:Button ID="btnNovi" runat="server" CssClass="btn_grid_akcija right" OnClick="btnNovi_Click" Text="Novi korisnik" UseSubmitBehavior="false" />
                    </HeaderTemplate>
                </dx:GridViewCommandColumn>
            </Columns>
            <SettingsBehavior ConfirmDelete="True" />
            <SettingsPager Mode="ShowAllRecords">
            </SettingsPager>
            <SettingsEditing Mode="Inline" NewItemRowPosition="Bottom">
            </SettingsEditing>
            <Settings ShowStatusBar="Hidden" />
            <SettingsText ConfirmDelete="Želite li obrisati korisnika?" EmptyDataRow="Nema podataka" Title="Top 10 ulaganja" />
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
        </dx:ASPxGridView>

        <%--<dx:ASPxPageControl ID="adminPageControl" runat="server" ActiveTabIndex="0" Width="100%">
            <TabPages>
                <dx:TabPage Text="Uređivanje korisnika">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
                <dx:TabPage Text="Postavke">
                    <ContentCollection>
                        <dx:ContentControl runat="server" SupportsDisabledAttribute="True">

                            <h2 class="form_group">E-mail potvrde registracije</h2>

                            <p class="form_text">E-mail koji će se poslati korisniku nakon registracije. Parametri: #USERNAME# - korisničko ime.</p>

                            <div class="form_item">
                                <label class="form_item_label_edit small2">Naslov:</label>
                                <asp:TextBox ID="txtRegisterEmailSubject" runat="server" CssClass="form_item_value_edit" />
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit small2">Sadržaj:</label>
                                <asp:TextBox ID="txtRegisterEmailBody" runat="server" CssClass="form_item_value_edit" TextMode="MultiLine" />
                            </div>

                            <h2 class="form_group">E-mail resetiranja lozinke</h2>

                            <p class="form_text">E-mail koji će se poslati korisniku kad on zatraži resetiranje lozinke. Parametri: #USERNAME# - korisničko ime; #URL# - url linka za resetiranje.</p>

                            <div class="form_item">
                                <label class="form_item_label_edit small2">Naslov:</label>
                                <asp:TextBox ID="txtResetEmailSubject" runat="server" CssClass="form_item_value_edit" />
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit small2">Sadržaj:</label>
                                <asp:TextBox ID="txtResetEmailBody" runat="server" CssClass="form_item_value_edit" TextMode="MultiLine" />
                            </div>

                            <asp:Label ID="lblPoruka" runat="server" Text=""></asp:Label>

                            <div class="btn_navigation_group">
                                <asp:Button ID="UpdateButton" CssClass="btn_navigation save" runat="server" CausesValidation="True" CommandName="Update" Text="Spremi" OnClick="UpdateButton_Click" />
                            </div>

                        </dx:ContentControl>
                    </ContentCollection>
                </dx:TabPage>
            </TabPages>
        </dx:ASPxPageControl>--%>

    </div>

</asp:Content>
