<%@ Page Title="Prijava | InvestApp" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="InvestApp.Web.Login" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <hgroup class="title">
        <%--<h1><%: Title %>.</h1>--%>
    </hgroup>

    <section id="loginForm" class="user_box">
        <h2>Prijava</h2>
        <asp:Login ID="Login1" runat="server" ViewStateMode="Disabled" RenderOuterTable="false" FailureText="Prijava nije bila uspješna. Pokušajte ponovno" OnLoginError="Login1_LoginError" OnLoggedIn="LoginForm_LoggedIn" >
            <LayoutTemplate>
                <p class="validation-summary-errors">
                    <asp:Literal runat="server" ID="FailureText" />
                </p>
                <fieldset>
                    <legend>Log in Form</legend>
                    <ol>
                        <li>
                            <asp:Label ID="Label1" runat="server" AssociatedControlID="UserName">Korisničko ime</asp:Label>
                            <asp:TextBox runat="server" ID="UserName" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="Korisničko ime mora biti upisano" />
                        </li>
                        <li>
                            <asp:Label ID="Label2" runat="server" AssociatedControlID="Password">Lozinka</asp:Label>
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="Lozinka mora biti upisana" />
                        </li>
                        <li>
                            <asp:CheckBox runat="server" ID="RememberMe" />
                            <asp:Label ID="Label3" runat="server" AssociatedControlID="RememberMe" CssClass="checkbox">Zapamti me?</asp:Label>
                        </li>
                    </ol>

                    <div class="btn_group">
                        <asp:Button ID="Button1" runat="server" CommandName="Login" Text="Prijavi se" />
                    </div>

                </fieldset>
            </LayoutTemplate>
        </asp:Login>
        <p>
            <asp:HyperLink runat="server" CssClass="register_link" ID="RegisterHyperLink" ViewStateMode="Disabled">Registriraj se</asp:HyperLink>
        </p>

        <div class="login_extra">
            <asp:HyperLink runat="server" NavigateUrl="~/Account/RecoverPassword.aspx" CssClass="recover_link" ID="recoverPassLink" ViewStateMode="Disabled">Zaboravljena lozinka?</asp:HyperLink>
        </div>

    </section>

    <%--    <section id="socialLoginForm">
        <h2>Use another service to log in.</h2>
        <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
    </section>--%>
</asp:Content>
