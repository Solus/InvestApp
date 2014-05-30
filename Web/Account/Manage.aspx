<%@ Page Title="Upravljanje računom | InvestApp" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="InvestApp.Web.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>
<%@ Import Namespace="Microsoft.AspNet.Membership.OpenAuth" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <%--<hgroup class="title">
        <h1><%: Title %>.</h1>
    </hgroup>--%>

    <section id="passwordForm" class="user_box">

        <%--<asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
            <p>
                You do not have a local password for this site. Add a local
                password so you can log in without an external login.
            </p>
            <fieldset>
                <legend>Set Password Form</legend>
                <ol>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="password">Password</asp:Label>
                        <asp:TextBox runat="server" ID="password" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                            CssClass="field-validation-error" ErrorMessage="The password field is required."
                            Display="Dynamic" ValidationGroup="SetPassword" />
                        
                        <asp:Label runat="server" ID="newPasswordMessage" CssClass="field-validation-error"
                            AssociatedControlID="password" />
                        
                    </li>
                    <li>
                        <asp:Label runat="server" AssociatedControlID="confirmPassword">Confirm password</asp:Label>
                        <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The confirm password field is required."
                            ValidationGroup="SetPassword" />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                            CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The password and confirmation password do not match."
                            ValidationGroup="SetPassword" />
                    </li>
                </ol>
                <asp:Button runat="server" Text="Set Password" ValidationGroup="SetPassword" OnClick="setPassword_Click" />
            </fieldset>
        </asp:PlaceHolder>--%>

        <asp:PlaceHolder runat="server" ID="changePassword" Visible="true">

            <h2>Promjena lozinke</h2>

            <p class="message-info">
                Korisničko ime: <strong><%: User.Identity.Name %></strong>
            </p>
            <p class="message-info" id="passwordInfo" runat="server">
                Min. broj znakova lozinke: <%: Membership.MinRequiredPasswordLength %>
                <br />
                Min broj specijalnih znakova:  <%: Membership.MinRequiredNonAlphanumericCharacters %><span class="info" title="Znakovi koji nisu ni broj ni slovo"></span>
            </p>

            <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                <p class="message-info"><%: SuccessMessage %></p>
            </asp:PlaceHolder>

            <asp:ChangePassword runat="server" ID="ChangePassword1"
                CancelDestinationPageUrl="~/"
                ViewStateMode="Disabled"
                RenderOuterTable="false"
                SuccessPageUrl="Manage?m=ChangePwdSuccess"
                ChangePasswordFailureText="Trenutna lozinka je pogrešno unesena ili nova nije ispravna" 
                OnChangePasswordError="ChangePassword1_ChangePasswordError"
                OnChangedPassword="ChangePassword1_ChangedPassword" >
                <ChangePasswordTemplate>

                    <p class="validation-summary-errors">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                    <fieldset class="changePassword">
                        <legend>Detalji</legend>
                        <ol>
                            <li>
                                <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword">Trenutna lozinka</asp:Label>
                                <asp:TextBox runat="server" ID="CurrentPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                    CssClass="field-validation-error" ErrorMessage="Trenutna lozinka mora biti unesena"
                                    ValidationGroup="ChangePassword" />
                            </li>
                            <li>
                                <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword">Nova lozinka</asp:Label>
                                <asp:TextBox runat="server" ID="NewPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                    CssClass="field-validation-error" ErrorMessage="Nova lozinka mora biti unesena"
                                    ValidationGroup="ChangePassword" />
                            </li>
                            <li>
                                <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword">Potvrda lozinke</asp:Label>
                                <asp:TextBox runat="server" ID="ConfirmNewPassword" CssClass="passwordEntry" TextMode="Password" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                    CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Potvrda lozinke mora biti unesena"
                                    ValidationGroup="ChangePassword" />
                                <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                    CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Potvrda nije jednaka lozinci"
                                    ValidationGroup="ChangePassword" />
                            </li>
                        </ol>

                        <div class="btn_group">
                            <asp:Button runat="server" CommandName="ChangePassword" Text="Promijeni" ValidationGroup="ChangePassword" />
                        </div>

                    </fieldset>
                </ChangePasswordTemplate>
            </asp:ChangePassword>
        </asp:PlaceHolder>
    </section>

    <%--<section id="externalLoginsForm">
        
        <asp:ListView runat="server" ID="externalLoginsList" ViewStateMode="Disabled"
            DataKeyNames="ProviderName,ProviderUserId" OnItemDeleting="externalLoginsList_ItemDeleting">
        
            <LayoutTemplate>
                <h3>Registered external logins</h3>
                <table>
                    <thead><tr><th>Service</th><th>User Name</th><th>Last Used</th><th>&nbsp;</th></tr></thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceholder"></tr>
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    
                    <td><%# HttpUtility.HtmlEncode(Item<OpenAuthAccountData>().ProviderDisplayName) %></td>
                    <td><%# HttpUtility.HtmlEncode(Item<OpenAuthAccountData>().ProviderUserName) %></td>
                    <td><%# HttpUtility.HtmlEncode(ConvertToDisplayDateTime(Item<OpenAuthAccountData>().LastUsedUtc)) %></td>
                    <td>
                        <asp:Button runat="server" Text="Remove" CommandName="Delete" CausesValidation="false" 
                            ToolTip='<%# "Remove this " + Item<OpenAuthAccountData>().ProviderDisplayName + " login from your account" %>'
                            Visible="<%# CanRemoveExternalLogins %>" />
                    </td>
                    
                </tr>
            </ItemTemplate>
        </asp:ListView>

        <h3>Add an external login</h3>
        <uc:OpenAuthProviders runat="server" ReturnUrl="~/Account/Manage" />
    </section>--%>
</asp:Content>
