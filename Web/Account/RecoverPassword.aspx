<%@ Page Title="Resetiranje lozinke | InvestApp" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="RecoverPassword.aspx.cs" Inherits="InvestApp.Web.RecoverPassword" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div id="passwordRecoveryForm" class="user_box">

        <h2>Resetiranje lozinke</h2>

        <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" 
            RenderOuterTable="false" 
            UserNameFailureText="Upisano korisničko ime ne postoji" 
            OnSendingMail="PasswordRecovery1_SendingMail" 
            GeneralFailureText="Zahtjev nije bio uspješan. Pokušajte ponovno" OnSendMailError="PasswordRecovery1_SendMailError" OnUserLookupError="PasswordRecovery1_UserLookupError">
            <UserNameTemplate>

                <ol>
                    <li>
                        <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="UserName">Korisničko ime</asp:Label>
                        <asp:TextBox ID="UserName" runat="server"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName"
                            CssClass="field-validation-error" ErrorMessage="Korisničko ime mora biti uneseno" ValidationGroup="PasswordRecovery" Display="Dynamic" />
                        <asp:CustomValidator ID="valUsernamePostoji" runat="server" ControlToValidate="UserName"  Display="Dynamic" CssClass="field-validation-error" ErrorMessage="Upisano korisničko ime ne postoji" ValidationGroup="PasswordRecovery" OnServerValidate="valUsernamePostoji_ServerValidate"></asp:CustomValidator>
                    
                    </li>
                </ol>

                <div class="btn_group">
                    <asp:Button ID="SubmitButton" runat="server" CommandName="Submit" Text="Resetiraj" ValidationGroup="PasswordRecovery" />
                </div>
            </UserNameTemplate>

            <MailDefinition IsBodyHtml="True" Subject="InvestApp promjena lozinke" BodyFileName="~/Account/Templates/PasswordResetTemplate.html">
            </MailDefinition>

            <SuccessTemplate>


                <p class="message-info">Uputstva za resetiranje lozinke su vam poslani na e-mail</p>

            </SuccessTemplate>
        </asp:PasswordRecovery>

        <asp:PlaceHolder ID="phPromijeni" runat="server" Visible="False">
            
            <p class="message-info">
                Promijenite lozinku,
                <asp:Label ID="lblUsername" runat="server" Text="Label"></asp:Label>
            </p>

            <ol>

                <li>
                    <asp:Label runat="server" ID="Label1" AssociatedControlID="txtLozinka">Nova lozinka</asp:Label>
                    <asp:TextBox ID="txtLozinka" runat="server" TextMode="Password"></asp:TextBox>

                    <asp:CustomValidator ID="valLozinkaCustom" runat="server" ControlToValidate="txtLozinka" CssClass="field-validation-error" ValidationGroup="PasswordChange" OnServerValidate="valLozinkaCustom_ServerValidate"></asp:CustomValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLozinka"
                        CssClass="field-validation-error" ErrorMessage="Lozinka mora biti unesena" ValidationGroup="PasswordChange" />
                </li>

                <li>
                    <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="txtLozinka2">Potvrda lozinke</asp:Label>
                    <asp:TextBox runat="server" ID="txtLozinka2" CssClass="passwordEntry" TextMode="Password" />

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLozinka2"
                        CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Potvrda lozinke mora biti unesena"
                        ValidationGroup="PasswordChange" />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtLozinka" ControlToValidate="txtLozinka2"
                        CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Potvrda nije jednaka lozinci"
                        ValidationGroup="PasswordChange" />
                </li>

            </ol>

            <div class="btn_group">
                <asp:Button ID="btnPromijeni" runat="server" Text="Promijeni" ValidationGroup="PasswordChange" OnClick="btnPromijeni_Click" />
            </div>

        </asp:PlaceHolder>

        <asp:Label ID="lblPoruka" runat="server" CssClass="message-info" Text=""></asp:Label>

    </div>

</asp:Content>
