<%@ Page Title="" Language="C#" Culture="hr-HR" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondKupnja.aspx.cs" Inherits="InvestApp.Web.FondKupnja" %>

<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="HeadContent">

    <script type="text/javascript">

        $(document).ready(function () {

            ToggleVlasnik2();
            ToggleVlasnik3();
        });

        function AdresaSlanjeVisible(visible) {

            var divAdresaSlanje = document.getElementById('adresa_slanje');
            var valUlica = document.getElementById('valSlanjeUlica');
            var valKbr = document.getElementById('valSlanjeKbr');
            var valPbr = document.getElementById('valSlanjePbr');
            var valMjesto = document.getElementById('valSlanjeMjesto');
            var valDrzava = document.getElementById('valSlanjeDrzava');

            if (visible) {
                divAdresaSlanje.style.display = 'block';
                valUlica.enabled = valKbr.enabled = valPbr.enabled = valMjesto.enabled = valDrzava.enabled = true;
            }
            else {
                divAdresaSlanje.style.display = 'none';
                valUlica.enabled = valKbr.enabled = valPbr.enabled = valMjesto.enabled = valDrzava.enabled = false;
            }
        }

        //podešava kontrole za prikaz računa ovisno o tome unosi li se IBAN ili NKS broj računa
        function SetUnosIBAN(iban) {

            var vbdiTxt = document.getElementById('VBDITextBox');
            var racunTxt = document.getElementById('RACUN_BROJTextBox');

            if (iban) {
                vbdiTxt.style.display = 'none';

                if (racunTxt.placeholder)
                    racunTxt.placeholder = 'IBAN';
            }
            else {
                vbdiTxt.style.display = '';

                if (racunTxt.placeholder)
                    racunTxt.placeholder = 'Broj računa';
            }
        }

        function ValidateRacun(sender, args) {

            var vbdiTxt = document.getElementById('VBDITextBox');
            var racunTxt = document.getElementById('RACUN_BROJTextBox');

            sender.errormessage = '';
            args.IsValid = true;

            if (vbdiTxt.style.display == 'none') { //ako se unosi IBAN

                if (!racunTxt.value) {
                    sender.errormessage = 'IBAN mora biti upisan';
                    args.IsValid = false;
                }
            }
            else { //ako se unosi VBDI+račun

                if (!vbdiTxt.value || !racunTxt.value) {
                    sender.errormessage = 'VBDI i broj računa moraju biti upisani';
                    args.IsValid = false;
                }
            }

        }

        function ToggleVlasnik2() {

            var chk = document.getElementById('chkVlasnik2');

            if (chk == null) return;

            var vlasnikEnabled = chk.checked;

            console.log(vlasnikEnabled);

            //validatori
            document.getElementById('valVLASNIK2_IME_PREZIME').enabled = 
            document.getElementById('valVLASNIK2_RODJENJE').enabled =
            document.getElementById('valVLASNIK2_PREBIVALISTE').enabled =
            document.getElementById('valVLASNIK2_DRZAVLJANSTVO').enabled =
            document.getElementById('valVLASNIK2_POSTOTAK_VLASNISTVA').enabled = vlasnikEnabled;

            $('#divVlasnik2').toggle(vlasnikEnabled);


            console.log('here');
        }

        function ToggleVlasnik3() {

            var chk = document.getElementById('chkVlasnik3');

            if (chk == null) return;
            
            var vlasnikEnabled = chk.checked;

            //validatori
            document.getElementById('valVLASNIK3_IME_PREZIME').enabled =
            document.getElementById('valVLASNIK3_RODJENJE').enabled =
            document.getElementById('valVLASNIK3_PREBIVALISTE').enabled =
            document.getElementById('valVLASNIK3_DRZAVLJANSTVO').enabled =
            document.getElementById('valVLASNIK3_POSTOTAK_VLASNISTVA').enabled = vlasnikEnabled;

            $('#divVlasnik3').toggle(vlasnikEnabled);

        }

        function ValidateUImeDrugog(sender, args) {

            console.log(args);
            args.IsValid = args.Value == 'N';
        }

    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h1 id="formHeader" class="form_header bar" runat="server">Kupnja udjela u fondu</h1>

    <div class="form_body">

        <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="EntityDataSourceZahtjev" DefaultMode="Insert" RenderOuterTable="False" OnItemInserted="FormView1_ItemInserted">
            <EditItemTemplate>
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <InsertItemTemplate>

                <%--<asp:Menu ID="menuKupnjaKoraci" runat="server" CssClass="steps_menu" Font-Size="Large" Orientation="Horizontal" StaticSelectedStyle-BackColor="#666699" OnMenuItemClick="menuKupnjaKoraci_MenuItemClick">
                        <Items>
                            <asp:MenuItem Text="1" Value="1"></asp:MenuItem>
                            <asp:MenuItem Text="2" Value="2"></asp:MenuItem>
                            <asp:MenuItem Text="3" Value="3"></asp:MenuItem>
                            <asp:MenuItem Text="4" Value="4"></asp:MenuItem>
                        </Items>
                        <StaticMenuItemStyle Font-Strikeout="False" ItemSpacing="3px" Width="20px" />
                        <StaticSelectedStyle BackColor="#666666" ForeColor="White" />
                    </asp:Menu>--%>

                <ul class="steps_menu">
                    <li id="liStep0" runat="server">1</li>
                    <li id="liStep1" runat="server">2</li>
                    <li id="liStep2" runat="server">2a</li>
                    <li id="liStep3" runat="server">3</li>
                    <li id="liStep4" runat="server">4</li>
                    <li id="liStep5" runat="server">5</li>
                    <li id="liStep6" runat="server">5a</li>
                    <li id="liStep7" runat="server">6</li>
                    <li id="liStep8" runat="server">6a</li>
                    <li id="liStep9" runat="server">6b</li>
                    <li id="liStep10" runat="server">6c</li>
                    <li id="liStep11" runat="server">Kraj</li>

                </ul>

                <div class="edit">

                    <asp:MultiView ID="mvFondKupnja" runat="server" ActiveViewIndex="0" OnActiveViewChanged="mvFondKupnja_ActiveViewChanged">

                        <asp:View ID="View1" runat="server"> <!-- uvod -->

                            <div class="form_item">
                                <label class="form_item_label_edit small" for="ddlFondovi">Fond:</label>
                                <asp:DropDownList ID="ddlFondovi" runat="server" CssClass="form_item_value_edit" DataSourceID="EntityDataSourceFondovi" DataTextField="NAZIV" DataValueField="ID" SelectedValue='<%# Bind("FOND_ID") %>'>
                                </asp:DropDownList>
                            </div>

                            <div class="form_item" id="divTipZahtjeva" runat="server" visible="false">
                                <asp:RadioButtonList ID="rblTipZahtjeva" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("TIP_ZAHTJEVA") %>' RepeatLayout="Flow">
                                    <asp:ListItem Value="K" Selected="True">Kupnja</asp:ListItem>
                                    <asp:ListItem Value="P">Prodaja</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <asp:RadioButtonList ID="rblPravna" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("PRAVNA") %>' RepeatLayout="Flow">
                                    <asp:ListItem Value="F" Selected="True">Fizička osoba</asp:ListItem>
                                    <asp:ListItem Value="P">Pravna osoba</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <div class="form_item">
                                <asp:RadioButtonList ID="rblRezident" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("REZIDENTNOST") %>' RepeatLayout="Flow">
                                    <asp:ListItem Value="R" Selected="True">Rezident</asp:ListItem>
                                    <asp:ListItem Value="N">Nerezident</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                        </asp:View>

                        <asp:View ID="View2" runat="server"> <!-- osobni podaci -->

                            <div id="pravnaPodaci" runat="server">

                                <h3 class="form_group">Podaci o pravnoj osobi</h3>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Pravna osoba:</label>
                                    <asp:TextBox ID="PRAVNA_IMETextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_IME") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ErrorMessage="Ime mora biti upisano" ControlToValidate="PRAVNA_IMETextBox">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Matični broj:</label>
                                    <asp:TextBox ID="PRAVNA_MBTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_MB") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Matični broj mora biti upisan" ControlToValidate="PRAVNA_MBTextBox">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">OIB:</label>
                                    <asp:TextBox ID="PRAVNA_OIBTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_OIB") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="PRAVNA_OIBTextBox" ErrorMessage="OIB mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <h3 class="form_group">Sjedište pravne osobe</h3>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Ulica:</label>
                                    <asp:TextBox ID="PRAVNA_ADRESA_ULICATextBox" runat="server" CssClass="form_item_value_edit ulica" Text='<%# Bind("PRAVNA_ADRESA_ULICA") %>' />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="PRAVNA_ADRESA_ULICATextBox" ErrorMessage="Ulica mora biti upisana" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                    <label class="form_item_label_edit inline">br.:</label>
                                    <asp:TextBox ID="PRAVNA_ADRESA_KUCNI_BROJTextBox" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("PRAVNA_ADRESA_KUCNI_BROJ") %>' />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ControlToValidate="PRAVNA_ADRESA_KUCNI_BROJTextBox" ErrorMessage="Kućni broj mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Poštanski broj:</label>
                                    <asp:TextBox ID="PRAVNA_ADRESA_POSTANSKI_BROJTextBox" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("PRAVNA_ADRESA_POSTANSKI_BROJ") %>' MaxLength="5" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="PRAVNA_ADRESA_POSTANSKI_BROJTextBox" ErrorMessage="Poštanski broj mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                    <label class="form_item_label_edit inline">Mjesto/grad:</label>
                                    <asp:TextBox ID="PRAVNA_ADRESA_MJESTOTextBox" runat="server" CssClass="form_item_value_edit mjesto" Text='<%# Bind("PRAVNA_ADRESA_MJESTO") %>' />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ControlToValidate="PRAVNA_ADRESA_MJESTOTextBox" ErrorMessage="Mjesto mora biti upisano" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Država:</label>
                                    <asp:TextBox ID="PRAVNA_ADRESA_DRZAVATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_ADRESA_DRZAVA") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ControlToValidate="PRAVNA_ADRESA_DRZAVATextBox" ErrorMessage="Država mora biti upisana" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <h3 class="form_group">Kontakt podaci pravne osobe</h3>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Telefon:</label>
                                    <asp:TextBox ID="PRAVNA_TELEFONTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_TELEFON") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator26" ControlToValidate="PRAVNA_TELEFONTextBox" ErrorMessage="Telefon mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Mobitel:</label>
                                    <asp:TextBox ID="PRAVNA_MOBITELTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_MOBITEL") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="PRAVNA_MOBITELTextBox" ErrorMessage="Mobitel mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Fax:</label>
                                    <asp:TextBox ID="PRAVNA_FAXTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_FAX") %>' />
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">E-mail:</label>
                                    <asp:TextBox ID="PRAVNA_EMAILTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_EMAIL") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator29" ControlToValidate="PRAVNA_EMAILTextBox" ErrorMessage="E-mail mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="PRAVNA_EMAILTextBox" runat="server" ErrorMessage="E-mail adresa nije ispravna"
                                        Display="Dynamic" ValidationExpression=".+@.+\..+" CssClass="validate_error_inline">
                                    </asp:RegularExpressionValidator>

                                </div>

                                <h3 class="form_group">Ovlaštena osoba pravne osobe</h3>

                                <div class="form_item">
                                    <div class="form_text">
                                        Ovlaštena osoba pravne osobe je:
                                            <ol>
                                                <li>Punoljetna osoba koja je unutar pravne osobe ovlaštena za raspolaganje s udjelima u fondu koji su u vlasništvu pravne osobe</li>
                                                <li>punoljetna osoba koja je prema sudskom ili drugom javnom registru ovlaštena za zastupanje tvrtke</li>
                                                <li>neka druga osoba koja dokazuje pravo raspolaganja udjelima u fondu temeljem javnobilježnički ovjerene punomoći</li>
                                            </ol>
                                    </div>
                                </div>

                            </div>
                            <!-- /podaci o pravnoj osobi -->

                            <h3 class="form_group">Osobni podaci</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Ime:</label>
                                <asp:TextBox ID="FIZICKA_IMETextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_IME") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="FIZICKA_IMETextBox" ErrorMessage="Ime mora biti upisano" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Prezime:</label>
                                <asp:TextBox ID="FIZICKA_PREZIMETextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_PREZIME") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="FIZICKA_PREZIMETextBox" ErrorMessage="Prezime mora biti upisano" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">JMBG:</label>
                                <asp:TextBox ID="FIZICKA_JMBGTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_JMBG") %>' />

                                <asp:RequiredFieldValidator ID="reqValJMBG" ControlToValidate="FIZICKA_JMBGTextBox" ErrorMessage="JMBG mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">OIB:</label>
                                <asp:TextBox ID="FIZICKA_OIBTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_OIB") %>' />

                                <asp:RequiredFieldValidator ID="reqValOIB" ControlToValidate="FIZICKA_OIBTextBox" ErrorMessage="OIB mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Osobni dokument:</label>
                                <asp:DropDownList ID="FIZICKA_DOKUMENT_TIP" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("FIZICKA_DOKUMENT_TIP") %>'>
                                    <%--<asp:ListItem Text="" Value=""></asp:ListItem>--%>
                                    <asp:ListItem Text="Osobna iskaznica" Value="o"></asp:ListItem>
                                    <asp:ListItem Text="Putovnica" Value="p"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Broj dokumenta:</label>
                                <asp:TextBox ID="FIZICKA_DOKUMENT_BROJTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_DOKUMENT_BROJ") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="FIZICKA_DOKUMENT_BROJTextBox" ErrorMessage="Broj dokumenta mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Izdavatelj dokumenta:</label>
                                <asp:TextBox ID="FIZICKA_DOKUMENT_IZDAVATELJTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_DOKUMENT_IZDAVATELJ") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="FIZICKA_DOKUMENT_IZDAVATELJTextBox" ErrorMessage="Izdavatelj dokumenta mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Dokument vrijedi do:</label>
                                <asp:TextBox ID="FIZICKA_DOKUMENT_VRIJEDI_DOTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_DOKUMENT_VRIJEDI_DO") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="FIZICKA_DOKUMENT_VRIJEDI_DOTextBox" ErrorMessage="Datum isteka dokumenta mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" ControlToValidate="FIZICKA_DOKUMENT_VRIJEDI_DOTextBox" Type="Date" Operator="DataTypeCheck"
                                    ErrorMessage="Datum mora biti u formatu 01.12.1999" runat="server" CssClass="validate_error_inline" Display="Dynamic">
                                </asp:CompareValidator>
                            </div>

                            <h3 class="form_group">Prebivalište</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Ulica:</label>
                                <asp:TextBox ID="FIZICKA_ADRESA_ULICATextBox" runat="server" CssClass="form_item_value_edit ulica" Text='<%# Bind("FIZICKA_ADRESA_ULICA") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator17" ControlToValidate="FIZICKA_ADRESA_ULICATextBox" ErrorMessage="Ulica mora biti upisana" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>

                                <label class="form_item_label_edit inline">br.:</label>
                                <asp:TextBox ID="FIZICKA_ADRESA_KUCNI_BROJTextBox" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("FIZICKA_ADRESA_KUCNI_BROJ") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ControlToValidate="FIZICKA_ADRESA_KUCNI_BROJTextBox" ErrorMessage="Kućni broj mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Poštanski broj:</label>
                                <asp:TextBox ID="FIZICKA_ADRESA_POSTANSKI_BROJTextBox" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("FIZICKA_ADRESA_POSTANSKI_BROJ") %>' MaxLength="5" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ControlToValidate="FIZICKA_ADRESA_POSTANSKI_BROJTextBox" ErrorMessage="Poštanski broj mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>

                                <label class="form_item_label_edit inline">Mjesto/grad:</label>
                                <asp:TextBox ID="FIZICKA_ADRESA_MJESTOTextBox" runat="server" CssClass="form_item_value_edit mjesto" Text='<%# Bind("FIZICKA_ADRESA_MJESTO") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ControlToValidate="FIZICKA_ADRESA_MJESTOTextBox" ErrorMessage="Mjesto mora biti upisano" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Država:</label>
                                <asp:TextBox ID="FIZICKA_ADRESA_DRZAVATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_ADRESA_DRZAVA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" ControlToValidate="FIZICKA_ADRESA_DRZAVATextBox" ErrorMessage="Država mora biti upisana" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <h3 class="form_group">Podaci o rođenju</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Datum rođenja:</label>
                                <asp:TextBox ID="FIZICKA_DATUM_RODENJATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_DATUM_RODENJA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ControlToValidate="FIZICKA_DATUM_RODENJATextBox" ErrorMessage="Datum rođenja mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator2" ControlToValidate="FIZICKA_DATUM_RODENJATextBox" Type="Date" Operator="DataTypeCheck"
                                    ErrorMessage="Datum mora biti u formatu 01.12.1999" runat="server" CssClass="validate_error_inline" Display="Dynamic">
                                </asp:CompareValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Mjesto rođenja:</label>
                                <asp:TextBox ID="FIZICKA_MJESTO_RODENJATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_MJESTO_RODENJA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" ControlToValidate="FIZICKA_MJESTO_RODENJATextBox" ErrorMessage="Mjesto rođenja mora biti upisano" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Država rođenja:</label>
                                <asp:TextBox ID="FIZICKA_DRZAVA_RODENJATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_DRZAVA_RODENJA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator24" ControlToValidate="FIZICKA_DRZAVA_RODENJATextBox" ErrorMessage="Država rođenja mora biti upisana" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Državljanstvo:</label>
                                <asp:TextBox ID="FIZICKA_DRZAVLJANSTVOTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_DRZAVLJANSTVO") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator25" ControlToValidate="FIZICKA_DRZAVLJANSTVOTextBox" ErrorMessage="Državljanstvo mora biti upisano" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <h3 class="form_group">Kontakt</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Telefon:</label>
                                <asp:TextBox ID="FIZICKA_TELEFONTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_TELEFON") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator30" ControlToValidate="FIZICKA_TELEFONTextBox" ErrorMessage="Telefon mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Mobitel:</label>
                                <asp:TextBox ID="FIZICKA_MOBITELTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_MOBITEL") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator31" ControlToValidate="FIZICKA_MOBITELTextBox" ErrorMessage="Mobitel mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Fax:</label>
                                <asp:TextBox ID="FIZICKA_FAXTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_FAX") %>' />
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">E-mail:</label>
                                <asp:TextBox ID="FIZICKA_EMAILTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_EMAIL") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator33" ControlToValidate="FIZICKA_EMAILTextBox" ErrorMessage="E-mail mora biti upisan" runat="server" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="FIZICKA_EMAILTextBox" runat="server" ErrorMessage="E-mail adresa nije ispravna"
                                    Display="Dynamic" ValidationExpression=".+@.+\..+" CssClass="validate_error_inline">
                                </asp:RegularExpressionValidator>
                            </div>

                            <div id="divPravnaZastupanjePojedinacno" runat="server">

                                <div class="spacer"></div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Ovlaštena osoba zastupa pravnu osobu:</label>
                                    <asp:RadioButtonList ID="rblPravnaZastupanjePojedinacno" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("ZASTUPANJE_TIP") %>' RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="A. Pojedinačno" Value="P" Selected="True" />
                                        <asp:ListItem Text="B. Skupno" Value="S" />
                                    </asp:RadioButtonList>
                                </div>

                            </div>

                            <h3 class="form_group">Adresa za slanje pošte</h3>

                            <div class="form_item">
                                <asp:RadioButtonList ID="rblAdresaSlanje" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="form_item_value_edit">
                                    <asp:ListItem Text="Gore navedena" Value="P" Selected="True" onclick="AdresaSlanjeVisible(false);"></asp:ListItem>
                                    <asp:ListItem Text="Nova" Value="N" onclick="AdresaSlanjeVisible(true);"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <!-- opcionalna adresa za slanje pošte -->
                            <div id="adresa_slanje" style="display: none;">

                                <div class="form_item">
                                    <label class="form_item_label_edit">Ulica:</label>
                                    <asp:TextBox ID="ADRESA_SLANJE_ULICATextBox" runat="server" CssClass="form_item_value_edit ulica" Text='<%# Bind("ADRESA_SLANJE_ULICA") %>' />
                                    <asp:RequiredFieldValidator Enabled="false" ID="valSlanjeUlica" ClientIDMode="Static" ControlToValidate="ADRESA_SLANJE_ULICATextBox" ErrorMessage="Adresa slanja mora biti upisana" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                    <label class="form_item_label_edit inline">br.:</label>
                                    <asp:TextBox ID="ADRESA_SLANJE_KUCNI_BROJTextBox" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("ADRESA_SLANJE_KUCNI_BROJ") %>' />
                                    <asp:RequiredFieldValidator Enabled="false" ID="valSlanjeKbr" ClientIDMode="Static" ControlToValidate="ADRESA_SLANJE_KUCNI_BROJTextBox" ErrorMessage="Kućni broj slanja mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Poštanski broj:</label>
                                    <asp:TextBox ID="ADRESA_SLANJE_POSTANSKI_BROJTextBox" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("ADRESA_SLANJE_POSTANSKI_BROJ") %>' MaxLength="5" />
                                    <asp:RequiredFieldValidator Enabled="false" ID="valSlanjePbr" ClientIDMode="Static" ControlToValidate="ADRESA_SLANJE_POSTANSKI_BROJTextBox" ErrorMessage="Poštanski broj slanja mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                    <label class="form_item_label_edit inline">Mjesto/grad:</label>
                                    <asp:TextBox ID="ADRESA_SLANJE_MJESTOTextBox" runat="server" CssClass="form_item_value_edit mjesto" Text='<%# Bind("ADRESA_SLANJE_MJESTO") %>' />
                                    <asp:RequiredFieldValidator Enabled="false" ID="valSlanjeMjesto" ClientIDMode="Static" ControlToValidate="ADRESA_SLANJE_MJESTOTextBox" ErrorMessage="Mjesto slanja mora biti upisano" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Država:</label>
                                    <asp:TextBox ID="ADRESA_SLANJE_DRZAVATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("ADRESA_SLANJE_DRZAVA") %>' />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valSlanjeDrzava" ClientIDMode="Static" ControlToValidate="ADRESA_SLANJE_DRZAVATextBox" ErrorMessage="Država slanja mora biti upisana" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                            </div>

                        </asp:View>

                        <asp:View ID="View2a" runat="server">
                            <!-- podaci o drugoj osobi zastupanja -->

                            <h3 class="form_group">Podaci o drugom zastupniku pravne osobe</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Ime:</label>
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_IME") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="TextBox1" ErrorMessage="Ime mora biti upisano" runat="server" Display="Dynamic">
                                    <img id="Img3" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Prezime:</label>
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_PREZIME") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator38" ControlToValidate="TextBox2" ErrorMessage="Prezime mora biti upisano" runat="server" Display="Dynamic">
                                    <img id="Img4" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">JMBG:</label>
                                <asp:TextBox ID="TextBox3" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_JMBG") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator41" ControlToValidate="TextBox3" ErrorMessage="JMBG mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img5" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">OIB:</label>
                                <asp:TextBox ID="TextBox4" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_OIB") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator42" ControlToValidate="TextBox4" ErrorMessage="OIB mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img6" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Osobni dokument:</label>
                                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("DRUGA_FIZICKA_DOKUMENT_TIP") %>'>
                                    <asp:ListItem Text="Osobna iskaznica" Value="o"></asp:ListItem>
                                    <asp:ListItem Text="Putovnica" Value="p"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Broj dokumenta:</label>
                                <asp:TextBox ID="TextBox5" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_DOKUMENT_BROJ") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator43" ControlToValidate="TextBox5" ErrorMessage="Broj dokumenta mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img7" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Izdavatelj dokumenta:</label>
                                <asp:TextBox ID="TextBox6" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_DOKUMENT_IZDAVATELJ") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator44" ControlToValidate="TextBox6" ErrorMessage="Izdavatelj dokumenta mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img8" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Dokument vrijedi do:</label>
                                <asp:TextBox ID="TextBox7" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_DOKUMENT_VRIJEDI_DO") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator45" ControlToValidate="TextBox7" ErrorMessage="Datum isteka dokumenta mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img9" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator5" ControlToValidate="TextBox7" Type="Date" Operator="DataTypeCheck"
                                    ErrorMessage="Datum mora biti u formatu 01.12.1999" runat="server" CssClass="validate_error_inline" Display="Dynamic">
                                </asp:CompareValidator>
                            </div>

                            <h3 class="form_group">Prebivalište</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Ulica:</label>
                                <asp:TextBox ID="TextBox8" runat="server" CssClass="form_item_value_edit ulica" Text='<%# Bind("DRUGA_FIZICKA_ADRESA_ULICA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator46" ControlToValidate="TextBox8" ErrorMessage="Ulica mora biti upisana" runat="server" Display="Dynamic">
                                    <img id="Img10" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>

                                <label class="form_item_label_edit inline">br.:</label>
                                <asp:TextBox ID="TextBox9" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("DRUGA_FIZICKA_ADRESA_KUCNI_BROJ") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator47" ControlToValidate="TextBox9" ErrorMessage="Kućni broj mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img11" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Poštanski broj:</label>
                                <asp:TextBox ID="TextBox10" runat="server" CssClass="form_item_value_edit small" Text='<%# Bind("DRUGA_FIZICKA_ADRESA_POSTANSKI_BROJ") %>' MaxLength="5" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator48" ControlToValidate="TextBox10" ErrorMessage="Poštanski broj mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img12" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>

                                <label class="form_item_label_edit inline">Mjesto/grad:</label>
                                <asp:TextBox ID="TextBox11" runat="server" CssClass="form_item_value_edit mjesto" Text='<%# Bind("DRUGA_FIZICKA_ADRESA_MJESTO") %>' />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator49" ControlToValidate="TextBox11" ErrorMessage="Mjesto mora biti upisano" runat="server" Display="Dynamic">
                                    <img id="Img13" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Država:</label>
                                <asp:TextBox ID="TextBox12" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_ADRESA_DRZAVA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator50" ControlToValidate="TextBox12" ErrorMessage="Država mora biti upisana" runat="server" Display="Dynamic">
                                    <img id="Img14" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <h3 class="form_group">Podaci o rođenju</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Datum rođenja:</label>
                                <asp:TextBox ID="TextBox13" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_DATUM_RODENJA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator51" ControlToValidate="TextBox13" ErrorMessage="Datum rođenja mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img15" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator6" ControlToValidate="TextBox13" Type="Date" Operator="DataTypeCheck"
                                    ErrorMessage="Datum mora biti u formatu 01.12.1999" runat="server" CssClass="validate_error_inline" Display="Dynamic">
                                </asp:CompareValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Mjesto rođenja:</label>
                                <asp:TextBox ID="TextBox14" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_MJESTO_RODENJA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator52" ControlToValidate="TextBox14" ErrorMessage="Mjesto rođenja mora biti upisano" runat="server" Display="Dynamic">
                                    <img id="Img16" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Država rođenja:</label>
                                <asp:TextBox ID="TextBox15" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_DRZAVA_RODENJA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator53" ControlToValidate="TextBox15" ErrorMessage="Država rođenja mora biti upisana" runat="server" Display="Dynamic">
                                    <img id="Img17" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Državljanstvo:</label>
                                <asp:TextBox ID="TextBox16" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_DRZAVLJANSTVO") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator54" ControlToValidate="TextBox16" ErrorMessage="Državljanstvo mora biti upisano" runat="server" Display="Dynamic">
                                    <img id="Img18" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <h3 class="form_group">Kontakt</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Telefon:</label>
                                <asp:TextBox ID="TextBox17" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_TELEFON") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator55" ControlToValidate="TextBox17" ErrorMessage="Telefon mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img19" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Mobitel:</label>
                                <asp:TextBox ID="TextBox18" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_MOBITEL") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator56" ControlToValidate="TextBox18" ErrorMessage="Mobitel mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img20" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">Fax:</label>
                                <asp:TextBox ID="TextBox19" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_FAX") %>' />
                            </div>
                            <div class="form_item">
                                <label class="form_item_label_edit">E-mail:</label>
                                <asp:TextBox ID="TextBox20" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DRUGA_FIZICKA_EMAIL") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator57" ControlToValidate="TextBox20" ErrorMessage="E-mail mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img21" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="TextBox20" runat="server" ErrorMessage="E-mail adresa nije ispravna"
                                    Display="Dynamic" ValidationExpression=".+@.+\..+" CssClass="validate_error_inline">
                                </asp:RegularExpressionValidator>
                            </div>

                        </asp:View>

                        <asp:View ID="View3" runat="server"> <!-- plaćanje -->

                            <h3 class="form_group">Račun za isplatu kod prodaje udjela</h3>

                            <%--<div class="form_item">
                                <label class="form_item_label_edit" for="ddlBanke">Banka:</label>
                                <asp:DropDownList ID="ddlBanke" runat="server" ClientIDMode="Static" CssClass="form_item_value_edit" DataTextField="NAZIV" DataValueField="VBDI"
                                    onchange="document.getElementById('VBDITextBox').value = this.value; ">
                                </asp:DropDownList>
                            </div>--%>

                            <%--<div class="form_item">
                                <label class="form_item_label_edit">Račun:</label>
                                <asp:RadioButtonList ID="rlbBrojRacunaTip" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="form_item_value_edit">
                                    <asp:ListItem Text="Tekući račun" Value="NKS" Selected="True"
                                        onclick="SetUnosIBAN(false); "></asp:ListItem>
                                    <asp:ListItem Text="IBAN" Value="IBAN"
                                        onclick="SetUnosIBAN(true);"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>--%>

                            <div class="form_item">
                                <label class="form_item_label_edit" for="ddlBanke">IBAN:</label>
                                <%--<asp:TextBox ID="VBDITextBox" placeholder="VBDI" CssClass="form_item_value_edit small" runat="server" ClientIDMode="Static" Text='<%# Bind("VBDI") %>' />--%>
                                
                                <asp:TextBox ID="RACUN_BROJTextBox" ClientIDMode="Static" CssClass="form_item_value_edit" runat="server" Text='<%# Bind("RACUN_BROJ") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator65" ControlToValidate="RACUN_BROJTextBox" ErrorMessage="IBAN mora biti upisan" runat="server" Display="Dynamic">
                                        <img id="Img45" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                <%--<asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="" ValidateEmptyText="true" ClientValidationFunction="ValidateRacun" Display="Dynamic">
                                    <img src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:CustomValidator>--%>

                            </div>

                            <div id="divIznos" runat="server">
                                <h3 class="form_group">Uplata</h3>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Iznos uplate u kn:</label>
                                    <asp:TextBox ID="ZELJENI_IZNOS_UDJELATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("ZELJENI_IZNOS_UDJELA") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator39" ControlToValidate="ZELJENI_IZNOS_UDJELATextBox" ErrorMessage="Iznos mora biti upisan" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator3" ControlToValidate="ZELJENI_IZNOS_UDJELATextBox" Type="Currency" Operator="DataTypeCheck" runat="server"
                                        ErrorMessage="Iznos mora biti u formatu 1234,00" CssClass="validate_error_inline" Display="Dynamic">
                                    </asp:CompareValidator>
                                </div>
                            </div>

                            <div id="divBrojUdjela" runat="server">
                                <h3 class="form_group">Uplata</h3>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Broj udjela:</label>
                                    <asp:TextBox ID="ZELJENI_BROJ_UDJELATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("ZELJENI_BROJ_UDJELA") %>' />

                                    <asp:RangeValidator ID="valBrUdjelaMax" Type="Integer" runat="server" ControlToValidate="ZELJENI_BROJ_UDJELATextBox" ErrorMessage="Broj udjela nije ispravan" Display="Dynamic" MinimumValue="0" CssClass="validate_error_inline">
                                    </asp:RangeValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="ZELJENI_BROJ_UDJELATextBox" ErrorMessage="Broj udjela mora biti upisan" runat="server" Display="Dynamic">
                                        <img id="Img1" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator4" ControlToValidate="ZELJENI_BROJ_UDJELATextBox" Type="Integer" Operator="DataTypeCheck" runat="server"
                                        ErrorMessage="Broj udjela mora biti u formatu 1234" CssClass="validate_error_inline" Display="Dynamic">
                                    </asp:CompareValidator>
                                </div>
                            </div>

                            <h3 class="form_group">Obavijesti od društva</h3>

                            <div class="form_item">
                                <asp:CheckBox ID="SLANJE_NA_EMAILCheckBox" runat="server" Checked='<%# Bind("SLANJE_NA_EMAIL") %>' CssClass="form_item_value_edit" Text="Obavijesti od društva želim primati e-mailom umjesto poštom" />
                            </div>
                        </asp:View>

                        <asp:View ID="View4" runat="server"> <!-- izjava o pranju novca -->

                            <h3 class="form_group">Ostali podaci</h3>

                            <div class="form_item">
                                <p class="form_text">
                                    Sukladno Zakonu o sprječavanju pranja novca i financiranju terorizma, (NN br.: 87/08, 25/12), te podzakonskim aktima Hrvatske agencije za nadzor financijskih usluga i Ureda za sprječavanje pranja novca Ministarstva Financija Republike Hrvatske, kupci Udjela u investicijskim fondovima registriranim u Republici Hrvatskoj, dužni su ispuniti slijedeći obrazac.
                                </p>
                            </div>

                            <div id="divOstaloFizicka" runat="server">

                                <div class="form_item">
                                    <label class="form_item_label_edit">Osobni status:</label>
                                    <asp:DropDownList ID="DropDownList1FIZICKA_STATUS_ODABIR" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("FIZICKA_STATUS_ODABIR") %>'>
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="zaposlenik" Value="z"></asp:ListItem>
                                        <asp:ListItem Text="poduzetnik" Value="p"></asp:ListItem>
                                        <asp:ListItem Text="nezaposlen" Value="n"></asp:ListItem>
                                        <asp:ListItem Text="umirovljenik" Value="u"></asp:ListItem>
                                        <asp:ListItem Text="student/učenik" Value="s"></asp:ListItem>
                                        <%--<asp:ListItem Text="ostalo" Value="o"></asp:ListItem>--%>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator28" ControlToValidate="DropDownList1FIZICKA_STATUS_ODABIR"
                                        ErrorMessage="Osobni status mora biti odabran" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                </div>
                                <%--<div class="form_item">
                                    <label class="form_item_label_edit">FIZICKA_STATUS_OSTALO:</label>
                                    <asp:TextBox ID="FIZICKA_STATUS_OSTALOTextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_STATUS_OSTALO") %>' />
                                </div>--%>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Vrsta poslodavca:</label>
                                    <asp:DropDownList ID="FIZICKA_VRSTA_POSLODAVCA" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("FIZICKA_VRSTA_POSLODAVCA") %>'>
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="privatni sektor" Value="ps"></asp:ListItem>
                                        <asp:ListItem Text="državna služba" Value="ds"></asp:ListItem>
                                        <asp:ListItem Text="tijela državne/regionalne vlasti" Value="td"></asp:ListItem>
                                        <asp:ListItem Text="državna trgovačka društva" Value="dt"></asp:ListItem>
                                        <asp:ListItem Text="ostalo(nezaposleni, umirovljenici)" Value="os"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator32" ControlToValidate="FIZICKA_VRSTA_POSLODAVCA"
                                        ErrorMessage="Vrsta poslodavca mora biti odabrana" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Stručna sprema:</label>
                                    <asp:DropDownList ID="FIZICKA_STRUCNA_SPREMA" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("FIZICKA_STRUCNA_SPREMA") %>'>
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="NKV" Value="NKV"></asp:ListItem>
                                        <asp:ListItem Text="NSS (KV,NSS)" Value="NSS"></asp:ListItem>
                                        <asp:ListItem Text="KV" Value="KV"></asp:ListItem>
                                        <asp:ListItem Text="SSS" Value="SSS"></asp:ListItem>
                                        <asp:ListItem Text="VKV" Value="VKV"></asp:ListItem>
                                        <asp:ListItem Text="VŠS" Value="VŠS"></asp:ListItem>
                                        <asp:ListItem Text="VSS" Value="VSS"></asp:ListItem>
                                        <asp:ListItem Text="VSS-MR" Value="VSS-MR"></asp:ListItem>
                                        <asp:ListItem Text="VSS-DR" Value="VSS-DR"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator34" ControlToValidate="FIZICKA_STRUCNA_SPREMA"
                                        ErrorMessage="Stručna sprema mora biti odabrana" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Zvanje:</label>
                                    <asp:TextBox ID="FIZICKA_ZVANJETextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_ZVANJE") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="FIZICKA_ZVANJETextBox" ErrorMessage="Zvanje mora biti upisano" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Zanimanje:</label>
                                    <asp:TextBox ID="FIZICKA_ZANIMANJETextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_ZANIMANJE") %>' />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator40" ControlToValidate="FIZICKA_ZANIMANJETextBox" ErrorMessage="Zanimanje mora biti upisano" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Planirana godišnja ulaganja u investicijske fondove:</label>
                                    <asp:DropDownList ID="FIZICKA_PLANIRANA_GOD_ULAGANJA" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("FIZICKA_PLANIRANA_GOD_ULAGANJA") %>'>
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="do 50.000,00 kn" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="50.001 kn do 200.000 kn" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="200.001 kn do 500.000 kn" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="500.001 kn do 1.000.000 kn" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="iznad 1.000.000,00 kn" Value="5"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator35" ControlToValidate="FIZICKA_PLANIRANA_GOD_ULAGANJA"
                                        ErrorMessage="Planirana godišnja ulaganja mora biti odabrano" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                </div>
                                <div class="form_item">
                                    <label class="form_item_label_edit">Sredstva za ulaganje ostvarena su iz:</label>
                                    <asp:DropDownList ID="FIZICKA_SREDSTVA_OSTVARENA" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("FIZICKA_SREDSTVA_OSTVARENA") %>'>
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="dohotka od redovne plaće - nesamostalni rad" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="dohotka od samostalne djelatnosti" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="dohotka od imovine i imovinskih prava" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="dohotka od kapitala" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="izvanrednih prihoda" Value="5"></asp:ListItem>
                                        <asp:ListItem Text="ostalog (stipendije, nasljedstva, naknade i sl)" Value="6"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator36" ControlToValidate="FIZICKA_SREDSTVA_OSTVARENA"
                                        ErrorMessage="Sredstva za ulaganje mora biti odabrano" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Da li poslovni odnos uspostavljate u ime nekog drugog?:</label>
                                    <asp:RadioButtonList ID="rblUImeDrugog" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>

                                    <asp:CustomValidator ID="valUImeDrugogCustom" runat="server" ControlToValidate="rblUImeDrugog"
                                        ErrorMessage="Kupnja udjela u ime nekog drugog nije moguća korištenjem ove aplikacije. Molimo Vas da nas kontaktirate kako bismo Vas uputili u način kako je moguće ostvariti ovu transakciju. Naši kontakti su: e-mail: &lt;a href=&quot;mailto:investiraj@investiraj.net&quot;&gt;investiraj@investiraj.net&lt;&#47;a&gt;; telefon: +385 1 4876 738"
                                        ClientValidationFunction="ValidateUImeDrugog" Display="Dynamic">
                                        <img id="Img2" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:CustomValidator>
                                </div>

                                <%--<div class="form_item">
                                        <label class="form_item_label_edit">Da li ste politički izložena osoba?:</label>
                                        <asp:RadioButtonList ID="POLITICKA_IZLOZENOSTRbl" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("POLITICKA_IZLOZENOST") %>' RepeatLayout="Flow">
                                            <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                            <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>--%>
                            </div>

                            <div id="ostaloPravna" runat="server">

                                <%--<div class="form_item">
                                        <label class="form_item_label_edit">Da li je vlasništvo podijeljeno na dijelove veće od 25%?:</label>
                                        <asp:RadioButtonList ID="VLASNISTVO_PODIJELJENORbl" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("VLASNISTVO_PODIJELJENO") %>' RepeatLayout="Flow">
                                            <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                            <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>--%>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Planirana godišnja ulaganja u investicijske fondove:</label>
                                    <asp:DropDownList ID="PRAVNA_PLANIRANA_GOD_ULAGANJA" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("PRAVNA_PLANIRANA_GOD_ULAGANJA") %>'>
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                        <asp:ListItem Text="do 100.000,00 kn" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="100.001 kn do 500.000 kn" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="500.001 kn do 1.000.000 kn" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="1.000.001 kn do 4.000.000 kn" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="iznad 4.000.000,00 kn" Value="5"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator37" ControlToValidate="PRAVNA_PLANIRANA_GOD_ULAGANJA"
                                        ErrorMessage="Planirana godišnja ulaganja mora biti odabrano" runat="server" Display="Dynamic">
                                        <img src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>

                                </div>
                            </div>

                        </asp:View>

                        <asp:View ID="View5" runat="server"> <!-- politička izloženost fizičke i vlasništvo pravne -->

                            <div id="divFizickaZadnje" runat="server">
                                <h1 class="form_group">Strana politički izložena osoba</h1>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Da li ste STRANA POLITIČKI IZLOŽENA osoba?:</label>
                                    <asp:RadioButtonList ID="POLITICKA_IZLOZENOSTRbl" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("POLITICKA_IZLOZENOST") %>' RepeatLayout="Flow">
                                        <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>

                                    <div class="form_text">
                                        Strana politički izložena osoba je:<br />
                                        <ol type="A">
                                            <li>svaka fizička osoba s prebivalištem ili uobičajenim boravištem u stranoj državi koja djeluje ili je u posljednjoj godini (ili dulje) djelovala na istaknutoj javnoj dužnosti (predsjednici država, vlada, ministri i njihovi zamjenici odnosno pomoćnici), članovi zakonodavnih tijela, suci onih sudova protiv čije presude, osim iznimno, nije moguće koristiti pravne lijekove, suci financijskih sudova i članovi savjeta središnjih banaka, veleposlanici konzuli i visoki časnici oružanih snaga, članovi upravnih i nadzornih odbora pravnih osoba u vlasništvu/većinskom vlasništvu države,</li>
                                            <li>uži član obitelji osobe pod A. što uključuje bračnog ili izvanbračnog druga, roditelje, braću i sestre, te djecu i njihove bračne i izvanbračne drugove,</li>
                                            <li>bliski suradnik osobe pod A. koji ima zajedničku dobit iz imovine ili uspostavljenog poslovnog odnosa ili koji s osobom pod A. ima druge uske poslovne kontakte.</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>

                            <div id="divPravnaZadnje" runat="server">

                                <h1 class="form_group">Podaci o stvarnom vlasniku*</h1>

                                <div class="form_item">

                                    <p class="form_text">
                                        *Pravne osobe koje po prvi puta vrše uplatu u fond pojedinog društva, uz Zahtjev za kupnju udjela, obvezne su dostaviti Rješenje Trgovačkog suda, pregled potpisnih kartona i Izjavu o stvarnom vlasnišvu.
                                        <br />
                                        *Podatake o stvarnom vlasniku nije potrebno utvrđivati u slučajevima predviđenim čl. 35 Zakona o sprječavanju pranja novca i financiranja terorizma.
                                    </p>

                                    <label class="form_item_label_edit">Da li je vlasništvo podijeljeno na dijelove veće od 25%?:</label>
                                    <asp:RadioButtonList ID="VLASNISTVO_PODIJELJENORbl" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("VLASNISTVO_PODIJELJENO") %>' RepeatLayout="Flow">
                                        <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                            </div>

                        </asp:View>

                        <asp:View ID="View6" runat="server"> <!-- politička izloženost fizičke osobe -->

                            <h3 class="form_group">Upitnik za STRANE POLITIČKI IZLOŽENE OSOBE</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li u državi vašega stalnog prebivališta/uobičajenog boravišta djelujete na istaknutoj javnoj dužnosti (kao predsjednik države ili vlade, ministar, zamjenik ili pomoćnik ministra)?:</label>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_1") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste zastupnik u parlamentu/izabrani član zakonodavnog tijela?:</label>
                                <asp:RadioButtonList ID="RadioButtonList2" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_2") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član vrhovnog, ustavnog ili drugog visokog suda protiv čije presude, osim u iznimnim slučajevima, nije moguće koristiti pravne lijekove?:</label>
                                <asp:RadioButtonList ID="RadioButtonList3" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_3") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste sudac financijskih sudova ili član savjeta središnje banke?:</label>
                                <asp:RadioButtonList ID="RadioButtonList4" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_4") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste veleposlanik, konzul ili visoki časnik oružanih snaga?:</label>
                                <asp:RadioButtonList ID="RadioButtonList5" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_5") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član upravnog i nadzornog odbora pravne osobe koja je u vlasništvu ili većinskom vlasništvu države?:</label>
                                <asp:RadioButtonList ID="RadioButtonList6" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_6") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">
                                    Jeste li možda član uže obitelji gore/prethodno navedenih osoba:<br />
                                    1.	bračni drug ili brat ili sestra<br />
                                    2.	izvanbračni drug<br />
                                    3.	dijete ili bračni drug djeteta ili izvanbračni drug djeteta<br />
                                    4.	roditelj:
                                </label>
                                <asp:RadioButtonList ID="RadioButtonList7" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_7") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Jeste li bliski suradnik gore/prethodno navedenih osoba na osnovu zajedničke dobiti iz imovine ili na osnovu uspostavljenog poslovnog odnosa ili nekog drugog uskog poslovnog kontakta s nekom od gore navedenih osoba?:</label>
                                <asp:RadioButtonList ID="RadioButtonList8" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_8") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li je od prestanka obavljanja prethodno navedenih istaknutih javnih dužnosti prošlo više od 12 mjeseci?:</label>
                                <asp:RadioButtonList ID="RadioButtonList9" runat="server" SelectedValue='<%# Bind("FIZICKA_POL_IZLOZEN_PITANJE_9") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <%--<h1 class="form_group">U slučaju da ste politički izložena osoba molimo navedite:</h1>--%>

                            <div class="form_item">
                                <label class="form_item_label_edit">Datum imenovanja ili vrijeme obavljanja istaknute javne dužnosti:</label>
                                <asp:TextBox ID="TextBox21" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_OBAVLJANJE_DUZNOSTI") %>' MaxLength="250" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator58" ControlToValidate="TextBox21" ErrorMessage="Datum imenovanja mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img22" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Izvor imovine i sredstava koja jesu ili će biti predmet poslovnog odnosa ili transakcije:</label>
                                <asp:TextBox ID="TextBox22" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("FIZICKA_IZVOR_IMOVINE") %>' TextMode="MultiLine" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator59" ControlToValidate="TextBox22" ErrorMessage="Izvor imovine mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img23" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                        </asp:View>

                        <asp:View ID="View7" runat="server"> <!-- Stvarni vlasnici -->

                            <h3 class="form_group">Podaci o stvarnim / beneficijarnim vlasnicima</h3>

                            <div class="form_item">
                                <div class="form_text">
                                    <p>
                                        U skladu s člankom 23. i 24. Zakona o sprječavanju pranja novca i financiranju terorizma (ZSPNFT), 
                                    Društvo je u obvezi pribaviti podatke o beneficijarnim/stvarnim vlasnicima poslovnih subjekata.<br />
                                        Stvarnim/beneficijarnim vlasnicima pravnih osoba (njihovih podružnica, predstavništava), 
                                    te drugih subjekata domaćeg i stranog prava izjednačenih s pravnom osobom, smatraju se:
                                    </p>

                                    <ol type="A">
                                        <li>Svaka fizička osoba koja je, direktno ili indirektno, vlasnik više od 25% dionica, više od 25% udjela ili više od 25% glasačkih prava</li>
                                        <li>Svaka fizička osoba koja na drugi način ima utjecajna upravu pravne osobe i koja kontrolira donošenjefinacijskih i poslovnih odluka.</li>
                                    </ol>
                                    Stvarnim/beneficijarnim vlasnicima drugih pravnih osoba kao što su zaklade, povjerenički poslovi kojima se upravlja 
                                novčanim sredstvima i raspodjeljuju novčana sredstva, smatraju se: 
                                <ol type="A" start="3">
                                    <li>Svaka fizička osoba koja je vlasnik više od 25% imovinskih prava određenog pravnog posla - ako su budući vlasnici već određeni</li>
                                    <li>Osoba ili grupa osoba u čijem je interesu pravni posao odnosno u čijem je interesu pravna osoba osnovana ili u čijem interesu posluje – ako fizičke odnosno pravneosobe koje će imati koristi od pravnog posla još nisu određene</li>
                                    <li>Svaka fizička osoba koja, direktno ili indirektno, kontrolira više od 25% imovinskih prava određenog pravnog posla.</li>
                                </ol>
                                </div>
                            </div>

                            <h3 class="form_group">Vlasnik 1</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit">Ime i prezime:</label>
                                <asp:TextBox ID="txtPravnaVlasnik1ImePRezime" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK1_IME_PREZIME") %>' MaxLength="250" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator60" ControlToValidate="txtPravnaVlasnik1ImePRezime" ErrorMessage="Ime i prezime mora biti uneseno" runat="server" Display="Dynamic">
                                    <img id="Img24" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Datum i mjesto rođenja:</label>
                                <asp:TextBox ID="TextBox24" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK1_RODJENJE") %>' MaxLength="250" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator61" ControlToValidate="TextBox24" ErrorMessage="Datum i mjesto rođenja mora biti uneseno" runat="server" Display="Dynamic">
                                    <img id="Img25" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Adresa prebivališta (ulica i broj, mjesto i poštanski broj, zemlja):</label>
                                <asp:TextBox ID="TextBox25" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK1_PREBIVALISTE") %>' MaxLength="250" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator62" ControlToValidate="TextBox25" ErrorMessage="Adresa mora biti unesena" runat="server" Display="Dynamic">
                                    <img id="Img26" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Državljanstvo:</label>
                                <asp:TextBox ID="TextBox26" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK1_DRZAVLJANSTVO") %>' MaxLength="100" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator63" ControlToValidate="TextBox26" ErrorMessage="Državljanstvo mora biti uneseno" runat="server" Display="Dynamic">
                                    <img id="Img27" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Osoba je:</label>
                                <asp:RadioButtonList ID="RadioButtonList10" runat="server" SelectedValue='<%# Bind("VLASNIK1_DIREKTNOST") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="direktni" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="indirektni vlasnik" Value="I" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Tip vlasništva:</label>
                                <asp:RadioButtonList ID="RadioButtonList11" runat="server" SelectedValue='<%# Bind("VLASNIK1_VLASNISTVO_TIP") %>' CssClass="form_item_value_edit small" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="A" Value="A" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="B" Value="B"></asp:ListItem>
                                    <asp:ListItem Text="C" Value="C"></asp:ListItem>
                                    <asp:ListItem Text="D" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="E" Value="E"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Postotak vlasništva:</label>
                                <asp:TextBox ID="TextBox27" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK1_POSTOTAK_VLASNISTVA") %>' />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator64" ControlToValidate="TextBox27" ErrorMessage="Postotak vlasništva mora biti uneseno" runat="server" Display="Dynamic">
                                    <img id="Img28" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator7" ControlToValidate="TextBox27" Type="Currency" Operator="DataTypeCheck" runat="server"
                                        ErrorMessage="Iznos mora biti u formatu 23,45" CssClass="validate_error_inline" Display="Dynamic">
                                 </asp:CompareValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox27" Type="Currency" MinimumValue="0" MaximumValue="100" CssClass="validate_error_inline" ErrorMessage="Uneseni postotak je izvan dopuštenih granica"></asp:RangeValidator>

                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Je li Vlasnik 1 strana politički izložena osoba:</label>
                                <asp:RadioButtonList ID="rblVlasnik1PolitickiIzlozen" runat="server" SelectedValue='<%# Bind("VLASNIK1_POLITICKA_IZLOZENOST") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <h3 class="form_group">Vlasnik 2</h3>

                            <div class="form_item">
                                <asp:CheckBox ID="chkVlasnik2" ClientIDMode="Static" runat="server" Checked='<%# Bind("PRAVNA_VLASNIK2_POSTOJI") %>' CssClass="form_item_value_edit" Text="Postoji vlasnik 2" onclick="ToggleVlasnik2(this);" />
                            </div>

                            <div id="divVlasnik2"> <!-- Vlasnik 2 -->

                                <div class="form_item">
                                    <label class="form_item_label_edit">Ime i prezime:</label>
                                    <asp:TextBox ID="txtPravnaVlasnik2ImePRezime" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK2_IME_PREZIME") %>' MaxLength="250" />

                                    <asp:RequiredFieldValidator Enabled="false"  ID="valVLASNIK2_IME_PREZIME" ClientIDMode="Static" ControlToValidate="txtPravnaVlasnik2ImePRezime" ErrorMessage="Ime i prezime mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img29" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Datum i mjesto rođenja:</label>
                                    <asp:TextBox ID="TextBox29" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK2_RODJENJE") %>' MaxLength="250" />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK2_RODJENJE" ClientIDMode="Static" ControlToValidate="TextBox29" ErrorMessage="Datum i mjesto rođenja mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img30" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Adresa prebivališta (ulica i broj, mjesto i poštanski broj, zemlja):</label>
                                    <asp:TextBox ID="TextBox30" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK2_PREBIVALISTE") %>' MaxLength="250" />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK2_PREBIVALISTE" ClientIDMode="Static" ControlToValidate="TextBox30" ErrorMessage="Adresa mora biti unesena" runat="server" Display="Dynamic">
                                        <img id="Img31" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Državljanstvo:</label>
                                    <asp:TextBox ID="TextBox31" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK2_DRZAVLJANSTVO") %>' MaxLength="100" />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK2_DRZAVLJANSTVO" ClientIDMode="Static" ControlToValidate="TextBox31" ErrorMessage="Državljanstvo mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img32" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Osoba je:</label>
                                    <asp:RadioButtonList ID="RadioButtonList13" runat="server" SelectedValue='<%# Bind("VLASNIK2_DIREKTNOST") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="direktni" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="indirektni vlasnik" Value="I" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Tip vlasništva:</label>
                                    <asp:RadioButtonList ID="RadioButtonList14" runat="server" SelectedValue='<%# Bind("VLASNIK2_VLASNISTVO_TIP") %>' CssClass="form_item_value_edit small" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="A" Value="A" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="B" Value="B"></asp:ListItem>
                                        <asp:ListItem Text="C" Value="C"></asp:ListItem>
                                        <asp:ListItem Text="D" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="E" Value="E"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Postotak vlasništva:</label>
                                    <asp:TextBox ID="TextBox32" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK2_POSTOTAK_VLASNISTVA") %>' />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK2_POSTOTAK_VLASNISTVA" ClientIDMode="Static" ControlToValidate="TextBox32" ErrorMessage="Postotak vlasništva mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img33" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator8" ControlToValidate="TextBox32" Type="Currency" Operator="DataTypeCheck" runat="server"
                                        ErrorMessage="Iznos mora biti u formatu 23,45" CssClass="validate_error_inline" Display="Dynamic">
                                    </asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="TextBox32" Type="Currency" MinimumValue="0" MaximumValue="100" CssClass="validate_error_inline" ErrorMessage="Uneseni postotak je izvan dopuštenih granica"></asp:RangeValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Je li Vlasnik 2 strana politički izložena osoba:</label>
                                    <asp:RadioButtonList ID="rblVlasnik2PolitickiIzlozen" runat="server" SelectedValue='<%# Bind("VLASNIK2_POLITICKA_IZLOZENOST") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                            </div>

                            <h3 class="form_group">Vlasnik 3</h3>

                            <div class="form_item">
                                <asp:CheckBox ID="chkVlasnik3" ClientIDMode="Static" runat="server" Checked='<%# Bind("PRAVNA_VLASNIK3_POSTOJI") %>' CssClass="form_item_value_edit" Text="Postoji vlasnik 3" onclick="ToggleVlasnik3(this);" />
                            </div>

                            <div id="divVlasnik3"> <!-- Vlasnik 3 -->

                                <div class="form_item">
                                    <label class="form_item_label_edit">Ime i prezime:</label>
                                    <asp:TextBox ID="txtPravnaVlasnik3ImePRezime" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK3_IME_PREZIME") %>' MaxLength="250" />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK3_IME_PREZIME" ClientIDMode="Static" ControlToValidate="txtPravnaVlasnik3ImePRezime" ErrorMessage="Ime i prezime mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img34" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Datum i mjesto rođenja:</label>
                                    <asp:TextBox ID="TextBox34" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK3_RODJENJE") %>' MaxLength="250" />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK3_RODJENJE" ClientIDMode="Static" ControlToValidate="TextBox34" ErrorMessage="Datum i mjesto rođenja mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img35" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Adresa prebivališta (ulica i broj, mjesto i poštanski broj, zemlja):</label>
                                    <asp:TextBox ID="TextBox35" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK3_PREBIVALISTE") %>' MaxLength="250" />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK3_PREBIVALISTE" ClientIDMode="Static" ControlToValidate="TextBox35" ErrorMessage="Adresa mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img36" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Državljanstvo:</label>
                                    <asp:TextBox ID="TextBox36" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK3_DRZAVLJANSTVO") %>' MaxLength="100" />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK3_DRZAVLJANSTVO" ClientIDMode="Static" ControlToValidate="TextBox36" ErrorMessage="Državljanstvo mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img37" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Osoba je:</label>
                                    <asp:RadioButtonList ID="RadioButtonList16" runat="server" SelectedValue='<%# Bind("VLASNIK3_DIREKTNOST") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="direktni" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="indirektni vlasnik" Value="I" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Tip vlasništva:</label>
                                    <asp:RadioButtonList ID="RadioButtonList17" runat="server" SelectedValue='<%# Bind("VLASNIK3_VLASNISTVO_TIP") %>' CssClass="form_item_value_edit small" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="A" Value="A" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="B" Value="B"></asp:ListItem>
                                        <asp:ListItem Text="C" Value="C"></asp:ListItem>
                                        <asp:ListItem Text="D" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="E" Value="E"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Postotak vlasništva:</label>
                                    <asp:TextBox ID="TextBox37" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("VLASNIK3_POSTOTAK_VLASNISTVA") %>' />

                                    <asp:RequiredFieldValidator Enabled="false" ID="valVLASNIK3_POSTOTAK_VLASNISTVA" ClientIDMode="Static" ControlToValidate="TextBox37" ErrorMessage="Postotak vlasništva mora biti uneseno" runat="server" Display="Dynamic">
                                        <img id="Img38" src="~/Images/Upozorenje.gif" runat="server" />
                                    </asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator9" ControlToValidate="TextBox37" Type="Currency" Operator="DataTypeCheck" runat="server"
                                        ErrorMessage="Iznos mora biti u formatu 23,45" CssClass="validate_error_inline" Display="Dynamic">
                                    </asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="TextBox37" Type="Currency" MinimumValue="0" MaximumValue="100" CssClass="validate_error_inline" ErrorMessage="Uneseni postotak je izvan dopuštenih granica"></asp:RangeValidator>
                                
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label_edit">Je li Vlasnik 3 strana politički izložena osoba:</label>
                                    <asp:RadioButtonList ID="rblVlasnik3PolitickiIzlozen" runat="server" SelectedValue='<%# Bind("VLASNIK3_POLITICKA_IZLOZENOST") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                        <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>

                            </div>

                        </asp:View>

                        <asp:View ID="View7a" runat="server"> <!-- Politička izloženost vlasnika 1 -->

                            <h3 class="form_group"><%: PravnaVlasnik1ImePrezime %> - Upitnik za STRANE POLITIČKI IZLOŽENE OSOBE</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li u državi vašega stalnog prebivališta/uobičajenog boravišta djelujete na istaknutoj javnoj dužnosti (kao predsjednik države ili vlade, ministar, zamjenik ili pomoćnik ministra)?:</label>
                                <asp:RadioButtonList ID="RadioButtonList19" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_1") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste zastupnik u parlamentu/izabrani član zakonodavnog tijela?:</label>
                                <asp:RadioButtonList ID="RadioButtonList20" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_2") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član vrhovnog, ustavnog ili drugog visokog suda protiv čije presude, osim u iznimnim slučajevima, nije moguće koristiti pravne lijekove?:</label>
                                <asp:RadioButtonList ID="RadioButtonList21" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_3") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste sudac financijskih sudova ili član savjeta središnje banke?:</label>
                                <asp:RadioButtonList ID="RadioButtonList22" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_4") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste veleposlanik, konzul ili visoki časnik oružanih snaga?:</label>
                                <asp:RadioButtonList ID="RadioButtonList23" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_5") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član upravnog i nadzornog odbora pravne osobe koja je u vlasništvu ili većinskom vlasništvu države?:</label>
                                <asp:RadioButtonList ID="RadioButtonList24" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_6") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">
                                    Jeste li možda član uže obitelji gore/prethodno navedenih osoba:<br />
                                    1.	bračni drug ili brat ili sestra<br />
                                    2.	izvanbračni drug<br />
                                    3.	dijete ili bračni drug djeteta ili izvanbračni drug djeteta<br />
                                    4.	roditelj:
                                </label>
                                <asp:RadioButtonList ID="RadioButtonList25" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_7") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Jeste li bliski suradnik gore/prethodno navedenih osoba na osnovu zajedničke dobiti iz imovine ili na osnovu uspostavljenog poslovnog odnosa ili nekog drugog uskog poslovnog kontakta s nekom od gore navedenih osoba?:</label>
                                <asp:RadioButtonList ID="RadioButtonList26" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_8") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li je od prestanka obavljanja prethodno navedenih istaknutih javnih dužnosti prošlo više od 12 mjeseci?:</label>
                                <asp:RadioButtonList ID="RadioButtonList27" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK1_POL_IZLOZEN_PITANJE_9") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <%--<h1 class="form_group">U slučaju da ste politički izložena osoba molimo navedite:</h1>--%>

                            <div class="form_item">
                                <label class="form_item_label_edit">Datum imenovanja ili vrijeme obavljanja istaknute javne dužnosti:</label>
                                <asp:TextBox ID="TextBox38" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_VLASNIK1_OBAVLJANJE_DUZNOSTI") %>' MaxLength="250" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator75" ControlToValidate="TextBox38" ErrorMessage="Datum imenovanja mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img39" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Izvor imovine i sredstava koja jesu ili će biti predmet poslovnog odnosa ili transakcije:</label>
                                <asp:TextBox ID="TextBox39" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_VLASNIK1_IZVOR_IMOVINE") %>' TextMode="MultiLine" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator76" ControlToValidate="TextBox39" ErrorMessage="Izvor imovine mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img40" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                        </asp:View>

                        <asp:View ID="View7b" runat="server"> <!-- Politička izloženost vlasnika 2 -->

                            <h3 class="form_group"><%: PravnaVlasnik2ImePrezime %> - Upitnik za STRANE POLITIČKI IZLOŽENE OSOBE</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li u državi vašega stalnog prebivališta/uobičajenog boravišta djelujete na istaknutoj javnoj dužnosti (kao predsjednik države ili vlade, ministar, zamjenik ili pomoćnik ministra)?:</label>
                                <asp:RadioButtonList ID="RadioButtonList28" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_1") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste zastupnik u parlamentu/izabrani član zakonodavnog tijela?:</label>
                                <asp:RadioButtonList ID="RadioButtonList29" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_2") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član vrhovnog, ustavnog ili drugog visokog suda protiv čije presude, osim u iznimnim slučajevima, nije moguće koristiti pravne lijekove?:</label>
                                <asp:RadioButtonList ID="RadioButtonList30" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_3") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste sudac financijskih sudova ili član savjeta središnje banke?:</label>
                                <asp:RadioButtonList ID="RadioButtonList31" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_4") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste veleposlanik, konzul ili visoki časnik oružanih snaga?:</label>
                                <asp:RadioButtonList ID="RadioButtonList32" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_5") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član upravnog i nadzornog odbora pravne osobe koja je u vlasništvu ili većinskom vlasništvu države?:</label>
                                <asp:RadioButtonList ID="RadioButtonList33" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_6") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">
                                    Jeste li možda član uže obitelji gore/prethodno navedenih osoba:<br />
                                    1.	bračni drug ili brat ili sestra<br />
                                    2.	izvanbračni drug<br />
                                    3.	dijete ili bračni drug djeteta ili izvanbračni drug djeteta<br />
                                    4.	roditelj:
                                </label>
                                <asp:RadioButtonList ID="RadioButtonList34" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_7") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Jeste li bliski suradnik gore/prethodno navedenih osoba na osnovu zajedničke dobiti iz imovine ili na osnovu uspostavljenog poslovnog odnosa ili nekog drugog uskog poslovnog kontakta s nekom od gore navedenih osoba?:</label>
                                <asp:RadioButtonList ID="RadioButtonList35" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_8") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li je od prestanka obavljanja prethodno navedenih istaknutih javnih dužnosti prošlo više od 12 mjeseci?:</label>
                                <asp:RadioButtonList ID="RadioButtonList36" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK2_POL_IZLOZEN_PITANJE_9") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <%--<h1 class="form_group">U slučaju da ste politički izložena osoba molimo navedite:</h1>--%>

                            <div class="form_item">
                                <label class="form_item_label_edit">Datum imenovanja ili vrijeme obavljanja istaknute javne dužnosti:</label>
                                <asp:TextBox ID="TextBox40" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_VLASNIK2_OBAVLJANJE_DUZNOSTI") %>' MaxLength="250" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator77" ControlToValidate="TextBox40" ErrorMessage="Datum imenovanja mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img41" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Izvor imovine i sredstava koja jesu ili će biti predmet poslovnog odnosa ili transakcije:</label>
                                <asp:TextBox ID="TextBox41" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_VLASNIK2_IZVOR_IMOVINE") %>' TextMode="MultiLine" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator78" ControlToValidate="TextBox41" ErrorMessage="Izvor imovine mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img42" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                        </asp:View>

                        <asp:View ID="View7c" runat="server"> <!-- Politička izloženost vlasnika 3 -->

                            <h3 class="form_group"><%: PravnaVlasnik3ImePrezime %> - Upitnik za STRANE POLITIČKI IZLOŽENE OSOBE</h3>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li u državi vašega stalnog prebivališta/uobičajenog boravišta djelujete na istaknutoj javnoj dužnosti (kao predsjednik države ili vlade, ministar, zamjenik ili pomoćnik ministra)?:</label>
                                <asp:RadioButtonList ID="RadioButtonList37" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_1") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste zastupnik u parlamentu/izabrani član zakonodavnog tijela?:</label>
                                <asp:RadioButtonList ID="RadioButtonList38" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_2") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član vrhovnog, ustavnog ili drugog visokog suda protiv čije presude, osim u iznimnim slučajevima, nije moguće koristiti pravne lijekove?:</label>
                                <asp:RadioButtonList ID="RadioButtonList39" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_3") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste sudac financijskih sudova ili član savjeta središnje banke?:</label>
                                <asp:RadioButtonList ID="RadioButtonList40" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_4") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste veleposlanik, konzul ili visoki časnik oružanih snaga?:</label>
                                <asp:RadioButtonList ID="RadioButtonList41" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_5") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li ste član upravnog i nadzornog odbora pravne osobe koja je u vlasništvu ili većinskom vlasništvu države?:</label>
                                <asp:RadioButtonList ID="RadioButtonList42" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_6") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">
                                    Jeste li možda član uže obitelji gore/prethodno navedenih osoba:<br />
                                    1.	bračni drug ili brat ili sestra<br />
                                    2.	izvanbračni drug<br />
                                    3.	dijete ili bračni drug djeteta ili izvanbračni drug djeteta<br />
                                    4.	roditelj:
                                </label>
                                <asp:RadioButtonList ID="RadioButtonList43" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_7") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Jeste li bliski suradnik gore/prethodno navedenih osoba na osnovu zajedničke dobiti iz imovine ili na osnovu uspostavljenog poslovnog odnosa ili nekog drugog uskog poslovnog kontakta s nekom od gore navedenih osoba?:</label>
                                <asp:RadioButtonList ID="RadioButtonList44" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_8") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit wide">Da li je od prestanka obavljanja prethodno navedenih istaknutih javnih dužnosti prošlo više od 12 mjeseci?:</label>
                                <asp:RadioButtonList ID="RadioButtonList45" runat="server" SelectedValue='<%# Bind("PRAVNA_VLASNIK3_POL_IZLOZEN_PITANJE_9") %>' CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                                    <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                            <%--<h1 class="form_group">U slučaju da ste politički izložena osoba molimo navedite:</h1>--%>

                            <div class="form_item">
                                <label class="form_item_label_edit">Datum imenovanja ili vrijeme obavljanja istaknute javne dužnosti:</label>
                                <asp:TextBox ID="TextBox42" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_VLASNIK3_OBAVLJANJE_DUZNOSTI") %>' MaxLength="250" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator79" ControlToValidate="TextBox42" ErrorMessage="Datum imenovanja mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img43" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form_item">
                                <label class="form_item_label_edit">Izvor imovine i sredstava koja jesu ili će biti predmet poslovnog odnosa ili transakcije:</label>
                                <asp:TextBox ID="TextBox43" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("PRAVNA_VLASNIK3_IZVOR_IMOVINE") %>' TextMode="MultiLine" />

                                <asp:RequiredFieldValidator ID="RequiredFieldValidator80" ControlToValidate="TextBox43" ErrorMessage="Izvor imovine mora biti upisan" runat="server" Display="Dynamic">
                                    <img id="Img44" src="~/Images/Upozorenje.gif" runat="server" />
                                </asp:RequiredFieldValidator>
                            </div>

                        </asp:View>

                        <asp:View ID="View99" runat="server">
                            
                            <asp:Label ID="lblStatusPoruka" runat="server" CssClass="poruka">Pregledajte unesene podatke ako želite, te unesite zahtjev.</asp:Label>

                        </asp:View>

                    </asp:MultiView>
                </div>

                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" Visible="False" />&nbsp;
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" Visible="False" />

            </InsertItemTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" />
            </ItemTemplate>
        </asp:FormView>

        <div id="divKorisnikSpremanje" runat="server" class="form_item prompt" visible="false">
            <label class="form_item_label_edit wide">Želite li spremiti promijenjene korisničke podatke?</label>
            <asp:RadioButtonList ID="rblKorisnikPodaciSpremi" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" RepeatLayout="Flow">
                <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
            </asp:RadioButtonList>
        </div>

        <asp:ValidationSummary ID="valSummaryKupnja" runat="server" CssClass="validation_summary" />

        <div class="btn_navigation_group">

            <asp:Button ID="btnPrevStep" CausesValidation="false" CssClass="btn_navigation prev" runat="server" OnClick="btnPrevStep_Click" Text="Prethodni korak" />
            <asp:Button ID="btnNextStep" CssClass="btn_navigation next" runat="server" OnClick="btnNextStep_Click" Text="Sljedeći korak" />

        </div>

    </div>

    <!-- ako se parametri ne postave, onda prazna polja unosi kao prazan string, umjesto NULL -->
    <asp:EntityDataSource ID="EntityDataSourceZahtjev" runat="server" ContextTypeName="InvestApp.DAL.FondEntities" ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" EnableFlattening="False" EnableInsert="True" EntitySetName="FondZahtjevi" EntityTypeFilter="FondZahtjev" OnInserted="EntityDataSourceZahtjev_Inserted" OnInserting="EntityDataSourceZahtjev_Inserting">
        <InsertParameters>
            <asp:Parameter Name="PRAVNA_IME" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_MB" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_OIB" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_ADRESA_ULICA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_ADRESA_KUCNI_BROJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_ADRESA_POSTANSKI_BROJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_ADRESA_MJESTO" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_ADRESA_DRZAVA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_FAX" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_TELEFON" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_MOBITEL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_EMAIL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_JMBG" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_OIB" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_TELEFON" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_MOBITEL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_FAX" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_EMAIL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="ADRESA_SLANJE_ULICA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="ADRESA_SLANJE_KUCNI_BROJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="ADRESA_SLANJE_POSTANSKI_BROJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="ADRESA_SLANJE_MJESTO" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="ADRESA_SLANJE_DRZAVA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="VBDI" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_ZVANJE" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_ZANIMANJE" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_SREDSTVA_OSTVARENA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="POLITICKA_IZLOZENOST" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="VLASNISTVO_PODIJELJENO" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_STATUS_ODABIR" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_VRSTA_POSLODAVCA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_STRUCNA_SPREMA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="FIZICKA_PLANIRANA_GOD_ULAGANJA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="PRAVNA_PLANIRANA_GOD_ULAGANJA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_IME" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_PREZIME" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_JMBG" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_OIB" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_DOKUMENT_BROJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_DOKUMENT_IZDAVATELJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_ADRESA_ULICA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_ADRESA_KUCNI_BROJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_ADRESA_POSTANSKI_BROJ" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_ADRESA_MJESTO" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_ADRESA_DRZAVA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_MJESTO_RODENJA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_DRZAVA_RODENJA" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_DRZAVLJANSTVO" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_TELEFON" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_MOBITEL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_FAX" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="DRUGA_FIZICKA_EMAIL" ConvertEmptyStringToNull="true" Type="String" />

        </InsertParameters>
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="EntityDataSourceFondovi" runat="server"
        ContextTypeName="InvestApp.DAL.FondEntities"
        ConnectionString="name=FondEntities"
        DefaultContainerName="FondEntities"
        EnableFlattening="False"
        EntitySetName="Fondovi"
        EntityTypeFilter="Fond"
        OrderBy="it.[NAZIV]"
        Where="it.INDEKSNI IS NULL OR it.INDEKSNI = FALSE">
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="EntityDataSourceBanke" runat="server" ContextTypeName="InvestApp.DAL.FondEntities" ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" EnableFlattening="False" EntitySetName="BankeDomace" EntityTypeFilter="BankaDomaca">
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="EntityDataSourceKorisnikDodatno" runat="server" ContextTypeName="InvestApp.DAL.FondEntities" ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" EnableFlattening="False" EntitySetName="KorisniciDodatno" EntityTypeFilter="KorisnikDodatno">
    </asp:EntityDataSource>

</asp:Content>


