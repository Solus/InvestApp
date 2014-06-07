<%@ Page Title="Registracija | InvestApp" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="InvestApp.Web.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <script type="text/javascript">

        function CheckBoxRequired_ClientValidate(sender, e) {
            e.IsValid = $("#chkUvjeti").is(':checked');
        }

    </script>

    <div id="registerForm" class="user_box">

        <%--<h1><%: Title %>.</h1>--%>
        <h2>Registracija</h2>

        <asp:Label ID="lblPoruka" runat="server" CssClass="message-info" Text=""></asp:Label>

        <asp:CreateUserWizard runat="server" ID="RegisterUser" 
            ViewStateMode="Disabled" 
            OnCreatedUser="RegisterUser_CreatedUser" 
            OnSendingMail="RegisterUser_SendingMail"
            DuplicateUserNameErrorMessage="Korisničko ime je već zauzeto. Unesite drugo" InvalidPasswordErrorMessage="Lozinka nije dovoljno kompleksna" OnCreateUserError="RegisterUser_CreateUserError" >
            
            <MailDefinition Subject="Potvrda registracije na investiraj.net" BodyFileName="~/Account/Templates/NoviKorisnikTemplate.html" IsBodyHtml="true">
            </MailDefinition>

            <LayoutTemplate>
                <asp:PlaceHolder runat="server" ID="wizardStepPlaceholder" />
                <asp:PlaceHolder runat="server" ID="navigationPlaceholder" />
            </LayoutTemplate>
            <WizardSteps>
                <asp:CreateUserWizardStep runat="server" ID="RegisterUserWizardStep">
                    <ContentTemplate>
                        <p class="message-info">
                            Min. broj znakova lozinke: <%: Membership.MinRequiredPasswordLength %> <br />
                            Min broj specijalnih znakova:  <%: Membership.MinRequiredNonAlphanumericCharacters %><span class="info" title="Znakovi koji nisu ni broj ni slovo"></span>
                        </p>

                        <p class="validation-summary-errors">
                            <asp:Literal runat="server" ID="ErrorMessage" />
                        </p>

                        <fieldset>
                            <legend>Registration Form</legend>
                            <ol>
                                <li>
                                    <asp:Label runat="server" AssociatedControlID="UserName">Korisničko ime</asp:Label>
                                    <asp:TextBox runat="server" ID="UserName" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                                        CssClass="field-validation-error" ErrorMessage="Korisničko ime mora biti upisano" />
                                </li>
                                <li>
                                    <asp:Label runat="server" AssociatedControlID="Email">E-mail</asp:Label>
                                    <asp:TextBox runat="server" ID="Email" type="email" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                        CssClass="field-validation-error" ErrorMessage="E-mail mora biti upisan" />
                                </li>
                                <li>
                                    <asp:Label runat="server" AssociatedControlID="Password">Lozinka</asp:Label>
                                    <asp:TextBox runat="server" ID="Password" TextMode="Password" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                        CssClass="field-validation-error" ErrorMessage="Lozinka mora biti upisana" />
                                </li>
                                <li>
                                    <asp:Label runat="server" AssociatedControlID="ConfirmPassword">Potvrda lozinke</asp:Label>
                                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                        CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Potvrda lozinke mora biti upisana" />
                                    <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                        CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Potvrda nije jednaka lozinci" />
                                </li>
                                <li>
                                    <asp:CheckBox ID="chkUvjeti" runat="server" ClientIDMode="Static" Text="Prihvaćam &lt;a href=&quot;..&#47;UvjetiKoristenja.aspx&quot;&gt;uvjete korištenja&lt;&#47;a&gt;" />
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Uvjeti korištenja moraju biti prihvaćeni" 
                                        CssClass="field-validation-error" ClientValidationFunction="CheckBoxRequired_ClientValidate" ></asp:CustomValidator>
                                </li>
                            </ol>
                            <div class="btn_group">
                                <asp:Button runat="server" CommandName="MoveNext" Text="Registriraj se" />
                            </div>
                        </fieldset>
                    </ContentTemplate>
                    <CustomNavigationTemplate />
                </asp:CreateUserWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>

    </div>
</asp:Content>
