<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="AdminKorisnikUredjivanje.aspx.cs" Inherits="InvestApp.Web.Admin.AdminKorisnikUredjivanje" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="form_body wide">

        <h1 class="form_header" id="formHeader" runat="server">Uređivanje korisnika</h1>

        <asp:UpdatePanel ID="UpdatePanelRole" runat="server">
            <ContentTemplate>

                <div class="left_edit">
                    <div class="form_item">
                        <label class="form_item_label small2">Username:</label>
                        <asp:Label ID="lblUsername" runat="server" CssClass="form_item_value" />

                        <asp:TextBox ID="txtUserNameNovi" runat="server" CssClass="form_item_value_edit" Visible="false"/>
                        <asp:CustomValidator ID="valUsernameCustom" runat="server" Enabled="false" ErrorMessage="" Display="Dynamic" ControlToValidate="txtUserNameNovi" CssClass="validate_error_inline small2" OnServerValidate="valUsernameCustom_ServerValidate"></asp:CustomValidator>
                        <asp:RequiredFieldValidator ID="valUsernameReq" runat="server" Enabled="false" ControlToValidate="txtUserNameNovi" ErrorMessage="Korisničko ime mora biti uneseno" Display="Dynamic" CssClass="validate_error_inline small2"></asp:RequiredFieldValidator>
                        
                    </div>
                    
                    <div class="form_item">
                        <label class="form_item_label_edit small2">E-mail:</label>
                        <asp:TextBox ID="txtEmail" type="email" runat="server" CssClass="form_item_value_edit" />
                        
                        <asp:CustomValidator ID="valEmailCustom" runat="server" Enabled="false" ErrorMessage="" Display="Dynamic" ControlToValidate="txtEmail" CssClass="validate_error_inline small2" OnServerValidate="valEmailCustom_ServerValidate"></asp:CustomValidator>
                        <asp:RequiredFieldValidator ID="valEmailReq" runat="server" ControlToValidate="txtEmail" ErrorMessage="E-mail mora biti unesen" Display="Dynamic" CssClass="validate_error_inline small2"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_item" id="divDrustvo" runat="server">
                        <label class="form_item_label_edit small2">Društvo:</label>
                        <asp:DropDownList ID="ddlDrustva" runat="server" DataTextField="NAZIV" DataValueField="ID" CssClass="form_item_value_edit"></asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <asp:CheckBox ID="chkLozinka" runat="server" CssClass="form_item_value_edit" Text="Promijeni lozinku" AutoPostBack="true" OnCheckedChanged="chkLozinka_CheckedChanged" />
                    </div>

                    <div id="divLozinka" runat="server" visible="false">

                        <div class="form_item">
                            <label class="form_item_label_edit small2">Lozinka:</label>
                            <asp:TextBox ID="txtNovaLozinka" TextMode="Password" runat="server" CssClass="form_item_value_edit" />

                            <asp:CustomValidator ID="valLozinka" runat="server" ErrorMessage="" Display="Dynamic" ControlToValidate="txtNovaLozinka" OnServerValidate="valLozinka_ServerValidate" CssClass="validate_error_inline small2"></asp:CustomValidator>
                            <asp:RequiredFieldValidator ID="valLozinkaReq" runat="server" ControlToValidate="txtNovaLozinka" ErrorMessage="Lozinka mora biti unesena" Display="Dynamic" CssClass="validate_error_inline small2"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form_item">
                            <label class="form_item_label_edit small2">Potvrda lozinke:</label>
                            <asp:TextBox ID="txtLozinkaPonavljanje" TextMode="Password" runat="server" CssClass="form_item_value_edit" />

                            <asp:CompareValidator ID="valCompareLoznika" ControlToValidate="txtNovaLozinka" ControlToCompare="txtLozinkaPonavljanje" runat="server" ErrorMessage="Lozinke nisu jednake" Display="Dynamic" CssClass="validate_error_inline small2"></asp:CompareValidator>
                        </div>

                    </div>

                </div>

                <div class="right_edit">

                    <div class="form_item">
                        <asp:GridView ID="gvRole" runat="server" CssClass="data_table_role" AutoGenerateColumns="False" DataKeyNames="Rola" OnDataBinding="gvRole_DataBinding" ViewStateMode="Enabled">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbIsInRole" runat="server" Checked='<%# Eval("IsInRole") %>' AutoPostBack="True" OnCheckedChanged="cbIsInRole_CheckedChanged" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="20px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Rola" HeaderText="Role korisnika" />
                            </Columns>
                        </asp:GridView>
                    </div>

                </div>

                <div class="clearfix"></div>

           
                <asp:CustomValidator ID="valCustom" runat="server" ErrorMessage="" Display="None" ValidationGroup="Grupa1" >
                </asp:CustomValidator>
                <asp:ValidationSummary ID="valSummary" ValidationGroup="Grupa1" CssClass="validation_summary" runat="server" />

        <div class="btn_navigation_group">
            <asp:Button ID="UpdateButton" CssClass="btn_navigation save" runat="server" CausesValidation="True" CommandName="Update" Text="Spremi" OnClick="UpdateButton_Click" />
            <asp:Button ID="UpdateCancelButton" CssClass="btn_navigation cancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" OnClick="UpdateCancelButton_Click" />
        </div>

                 </ContentTemplate>
        </asp:UpdatePanel>

    </div>

</asp:Content>
