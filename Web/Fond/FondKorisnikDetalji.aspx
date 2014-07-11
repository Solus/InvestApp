<%@ Page Title="" Language="C#" Culture="hr-HR" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondKorisnikDetalji.aspx.cs" Inherits="InvestApp.Web.FondKorisnikDetalji" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">

        function ClearOsobna() {
            $("a[id$='lightboxSLIKA_OSOBNE']").removeAttr('href');
        }

        function ClearKarticaRacuna() {
            $("a[id$='lightboxKARTICA_RACUNA']").removeAttr('href');
        }
        
    </script>

    <h1 class="form_header bar">Podaci korisnika</h1>

    <asp:Label ID="lblLog" runat="server"></asp:Label>

    <div class="form_body">

    <asp:FormView ID="FormViewKorisnik" runat="server" DataKeyNames="ID" DataSourceID="EntityDataSourceKorisnikDodatno" OnItemCommand="FormViewKorisnik_ItemCommand" RenderOuterTable="false" OnModeChanged="FormViewKorisnik_ModeChanged" OnDataBound="FormViewKorisnik_DataBound" OnModeChanging="FormViewKorisnik_ModeChanging" OnItemUpdating="FormViewKorisnik_ItemUpdating">
        <EditItemTemplate>

            <div class="edit">
                <div class="form_item">
                    <asp:RadioButtonList ID="rblPravna" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("PRAVNA") %>' RepeatLayout="Flow" 
                        AutoPostBack="true" OnSelectedIndexChanged="rblPravna_SelectedIndexChanged" >
                        <asp:ListItem Value="" ></asp:ListItem>
                        <asp:ListItem Value="F" Selected="True">Fizička osoba</asp:ListItem>
                        <asp:ListItem Value="P">Pravna osoba</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="form_item">
                    <asp:RadioButtonList ID="rblRezident" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("REZIDENTNOST") %>' RepeatLayout="Flow">
                        <asp:ListItem Value="" ></asp:ListItem>
                        <asp:ListItem Value="R" Selected="True">Rezident</asp:ListItem>
                        <asp:ListItem Value="N">Nerezident</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <h3 class="form_group">Osnovni podaci</h3>

                <div class="form_item">
                    <label class="form_item_label_edit" id="lblIme" runat="server">Ime:</label>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("IME") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item" id="divPrezime" runat="server">
                    <label class="form_item_label_edit">Prezime:</label>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PREZIME") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit" id="lblMB" runat="server">MB:</label>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("MB") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">OIB:</label>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("OIB") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Osobni dokument:</label>
                    <asp:DropDownList ID="FIZICKA_DOKUMENT_TIP" runat="server" SelectedValue='<%# Bind("FIZICKA_DOKUMENT_TIP") %>' CssClass="form_item_value_edit">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        <asp:ListItem Text="Osobna iskaznica" Value="o"></asp:ListItem>
                        <asp:ListItem Text="Putovnica" Value="p"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Broj dokumenta:</label>
                    <asp:TextBox ID="FIZICKA_DOKUMENT_BROJTextBox" runat="server" Text='<%# Bind("FIZICKA_DOKUMENT_BROJ") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Izdavatelj dokumenta:</label>
                    <asp:TextBox ID="FIZICKA_DOKUMENT_IZDAVATELJTextBox" runat="server" Text='<%# Bind("FIZICKA_DOKUMENT_IZDAVATELJ") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Dokument vrijedi do:</label>
                    <asp:TextBox ID="FIZICKA_DOKUMENT_VRIJEDI_DOTextBox" runat="server" Text='<%# Bind("FIZICKA_DOKUMENT_VRIJEDI_DO", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item" id="divVlasnistvoPodijeljeno" runat="server">
                    <label class="form_item_label_edit">Da li je vlasništvo podijeljeno na dijelove veće od 25%?:</label>
                    <asp:RadioButtonList ID="VLASNISTVO_PODIJELJENORbl" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("PRAVNA_VLASNISTVO_PODIJELJENO") %>' RepeatLayout="Flow">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                        <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="form_item" id="divPravnaUlaganja" runat="server">
                    <label class="form_item_label_edit">Planirana godišnja ulaganja u investicijske fondove:</label>
                    <asp:DropDownList ID="PRAVNA_PLANIRANA_GOD_ULAGANJA" runat="server" SelectedValue='<%# Bind("PRAVNA_PLANIRANA_GOD_ULAGANJA") %>' CssClass="form_item_value_edit">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        <asp:ListItem Text="do 100.000,00 kn" Value="1"></asp:ListItem>
                        <asp:ListItem Text="100.001 kn do 500.000 kn" Value="2"></asp:ListItem>
                        <asp:ListItem Text="500.001 kn do 1.000.000 kn" Value="3"></asp:ListItem>
                        <asp:ListItem Text="1.000.001 kn do 4.000.000 kn" Value="4"></asp:ListItem>
                        <asp:ListItem Text="iznad 4.000.000,00 kn" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <h3 class="form_group">Adresa</h3>

                <div class="form_item">
                    <label class="form_item_label_edit">Ulica:</label>
                    <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("ADRESA_ULICA") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">br.:</label>
                    <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("ADRESA_KUCNI_BROJ") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Poštanski broj:</label>
                    <asp:TextBox ID="TextBox13" runat="server" Text='<%# Bind("ADRESA_POSTANSKI_BROJ") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Mjesto/grad:</label>
                    <asp:TextBox ID="TextBox14" runat="server" Text='<%# Bind("ADRESA_MJESTO") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Država:</label>
                    <asp:TextBox ID="TextBox15" runat="server" Text='<%# Bind("ADRESA_DRZAVA") %>' CssClass="form_item_value_edit" />
                </div>

                <h3 class="form_group">Kontakt podaci</h3>

                <div class="form_item">
                    <label class="form_item_label_edit">Telefon:</label>
                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("TELEFON") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Mobitel:</label>
                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("MOBITEL") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Fax:</label>
                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("FAX") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">E-mail:</label>
                    <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("KONTAKT_EMAIL") %>' CssClass="form_item_value_edit" />
                </div>

                <h3 class="form_group">Račun za isplatu</h3>

                <div class="form_item">
                    <label class="form_item_label_edit" for="ddlBanke">IBAN:</label>
<%--                    <asp:TextBox ID="VBDITextBox" placeholder="VBDI" CssClass="form_item_value_edit small" runat="server" ClientIDMode="Static" Text='<%# Bind("RACUN_VBDI") %>' />--%>
                    <asp:TextBox ID="RACUN_BROJTextBox" ClientIDMode="Static" CssClass="form_item_value_edit" runat="server" Text='<%# Bind("RACUN_BROJ") %>' MaxLength="21" />
                </div>

                <div id="divZastupnik" runat="server">

                    <h3 class="form_group">Zakonski zastupnik</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Ime:</label>
                        <asp:TextBox ID="ZASTUPNIK_IMETextBox" runat="server" Text='<%# Bind("ZASTUPNIK_IME") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Prezime:</label>
                        <asp:TextBox ID="ZASTUPNIK_PREZIMETextBox" runat="server" Text='<%# Bind("ZASTUPNIK_PREZIME") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">JMBG:</label>
                        <asp:TextBox ID="ZASTUPNIK_JMBGTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_JMBG") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">OIB:</label>
                        <asp:TextBox ID="ZASTUPNIK_OIBTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_OIB") %>' CssClass="form_item_value_edit" />
                    </div>

                    <h3 class="form_group">Adresa zastupnika</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Ulica:</label>
                        <asp:TextBox ID="ZASTUPNIK_ADRESA_ULICATextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_ULICA") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">br.:</label>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_KUCNI_BROJ") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Poštanski broj:</label>
                        <asp:TextBox ID="ZASTUPNIK_ADRESA_P_BROJTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_P_BROJ") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Mjesto/grad:</label>
                        <asp:TextBox ID="ZASTUPNIK_ADRESA_MJESTOTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_MJESTO") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Država:</label>
                        <asp:TextBox ID="ZASTUPNIK_ADRESA_DRZAVATextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_DRZAVA") %>' CssClass="form_item_value_edit" />
                    </div>

                    <h3 class="form_group">Kontakt podaci zastupnika</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Telefon:</label>
                        <asp:TextBox ID="ZASTUPNIK_TELEFONTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_TELEFON") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Mobitel:</label>
                        <asp:TextBox ID="ZASTUPNIK_MOBITELTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_MOBITEL") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Fax:</label>
                        <asp:TextBox ID="ZASTUPNIK_FAXTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_FAX") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">E-mail:</label>
                        <asp:TextBox ID="ZASTUPNIK_EMAILTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_EMAIL") %>' CssClass="form_item_value_edit" />
                    </div>

                </div>

                <h3 class="form_group">Podaci o rođenju</h3>

                <div class="form_item">
                    <label class="form_item_label_edit">Datum rođenja:</label>
                    <asp:TextBox ID="FIZICKA_DATUM_RODENJATextBox" runat="server" Text='<%# Bind("FIZICKA_DATUM_RODENJA", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Mjesto rođenja:</label>
                    <asp:TextBox ID="FIZICKA_MJESTO_RODENJATextBox" runat="server" Text='<%# Bind("FIZICKA_MJESTO_RODENJA") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Država rođenja:</label>
                    <asp:TextBox ID="FIZICKA_DRZAVA_RODENJATextBox" runat="server" Text='<%# Bind("FIZICKA_DRZAVA_RODENJA") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Državljanstvo:</label>
                    <asp:TextBox ID="FIZICKA_DRZAVLJANSTVOTextBox" runat="server" Text='<%# Bind("FIZICKA_DRZAVLJANSTVO") %>' CssClass="form_item_value_edit" />
                </div>

                <div id="divFizickaOstalo" runat="server">

                    <h3 class="form_group">Dodatni podaci</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Osobni status:</label>
                        <asp:DropDownList ID="DropDownList1FIZICKA_STATUS_ODABIR" runat="server" SelectedValue='<%# Bind("FIZICKA_STATUS_ODABIR") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="zaposlenik" Value="z"></asp:ListItem>
                            <asp:ListItem Text="poduzetnik" Value="p"></asp:ListItem>
                            <asp:ListItem Text="nezaposlen" Value="n"></asp:ListItem>
                            <asp:ListItem Text="umirovljenik" Value="u"></asp:ListItem>
                            <asp:ListItem Text="student/učenik" Value="s"></asp:ListItem>
                            <%--<asp:ListItem Text="ostalo" Value="o"></asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>

                    <%--<div class="form_item">
                    <label class="form_item_label_edit">FIZICKA_STATUS_OSTALO:</label>
                    <asp:TextBox ID="FIZICKA_STATUS_OSTALOTextBox" runat="server" Text='<%# Bind("FIZICKA_STATUS_OSTALO") %>' CssClass="form_item_value_edit" />
                </div>--%>

                    <div class="form_item">
                        <label class="form_item_label_edit">Vrsta poslodavca:</label>
                        <asp:DropDownList ID="FIZICKA_VRSTA_POSLODAVCA" runat="server" SelectedValue='<%# Bind("FIZICKA_VRSTA_POSLODAVCA") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="privatni sektor" Value="ps"></asp:ListItem>
                            <asp:ListItem Text="državna služba" Value="ds"></asp:ListItem>
                            <asp:ListItem Text="tijela državne/regionalne vlasti" Value="td"></asp:ListItem>
                            <asp:ListItem Text="državna trgovačka društva" Value="dt"></asp:ListItem>
                            <asp:ListItem Text="ostalo(nezaposleni, umirovljenici)" Value="os"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Stručna sprema:</label>
                        <asp:DropDownList ID="FIZICKA_STRUCNA_SPREMA" runat="server" SelectedValue='<%# Bind("FIZICKA_STRUCNA_SPREMA") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Value="NKV" Text="NKV"></asp:ListItem>
                            <asp:ListItem Value="NSS" Text="NSS (KV,NSS)"></asp:ListItem>
                            <asp:ListItem Value="KV" Text="KV"></asp:ListItem>
                            <asp:ListItem Value="SSS" Text="SSS"></asp:ListItem>
                            <asp:ListItem Value="VKV" Text="VKV"></asp:ListItem>
                            <asp:ListItem Value="VŠS" Text="VŠS"></asp:ListItem>
                            <asp:ListItem Value="VSS" Text="VSS"></asp:ListItem>
                            <asp:ListItem Value="VSS-MR" Text="VSS-MR"></asp:ListItem>
                            <asp:ListItem Value="VSS-DR" Text="VSS-DR"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Zvanje:</label>
                        <asp:TextBox ID="FIZICKA_ZVANJETextBox" runat="server" Text='<%# Bind("FIZICKA_ZVANJE") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Zanimanje:</label>
                        <asp:TextBox ID="FIZICKA_ZANIMANJETextBox" runat="server" Text='<%# Bind("FIZICKA_ZANIMANJE") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Planirana godišnja ulaganja u investicijske fondove:</label>
                        <asp:DropDownList ID="FIZICKA_PLANIRANA_GOD_ULAGANJA" runat="server" SelectedValue='<%# Bind("FIZICKA_PLANIRANA_GOD_ULAGANJA") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="do 50.000,00 kn" Value="1"></asp:ListItem>
                            <asp:ListItem Text="50.001 kn do 200.000 kn" Value="2"></asp:ListItem>
                            <asp:ListItem Text="200.001 kn do 500.000 kn" Value="3"></asp:ListItem>
                            <asp:ListItem Text="500.001 kn do 1.000.000 kn" Value="4"></asp:ListItem>
                            <asp:ListItem Text="iznad 1.000.000,00 kn" Value="5"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Sredstva za ulaganje ostvarena su iz:</label>
                        <asp:DropDownList ID="FIZICKA_SREDSTVA_OSTVARENA" runat="server" SelectedValue='<%# Bind("FIZICKA_SREDSTVA_OSTVARENA") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="dohotka od redovne plaće - nesamostalni rad" Value="1"></asp:ListItem>
                            <asp:ListItem Text="dohotka od samostalne djelatnosti" Value="2"></asp:ListItem>
                            <asp:ListItem Text="dohotka od imovine i imovinskih prava" Value="3"></asp:ListItem>
                            <asp:ListItem Text="dohotka od kapitala" Value="4"></asp:ListItem>
                            <asp:ListItem Text="izvanrednih prihoda" Value="5"></asp:ListItem>
                            <asp:ListItem Text="ostalog (stipendije, nasljedstva, naknade i sl)" Value="6"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Da li ste politički izložena osoba?:</label>
                        <asp:RadioButtonList ID="POLITICKA_IZLOZENOSTRbl" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("FIZICKA_POLITICKA_IZLOZENOST") %>' RepeatLayout="Flow">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="DA" Value="D"></asp:ListItem>
                            <asp:ListItem Text="NE" Value="N" Selected="True"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                </div>

                <h3 class="form_group">Adresa za slanje pošte</h3>

                <div class="form_item">
                    <label class="form_item_label_edit">Ulica:</label>
                    <asp:TextBox ID="ADRESA_SLANJE_ULICATextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_ULICA") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">br.:</label>
                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("ADRESA_SLANJE_KUCNI_BROJ") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Poštanski broj:</label>
                    <asp:TextBox ID="ADRESA_SLANJE_POSTANSKI_BROJTextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_POSTANSKI_BROJ") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Mjesto/grad:</label>
                    <asp:TextBox ID="ADRESA_SLANJE_MJESTOTextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_MJESTO") %>' CssClass="form_item_value_edit" />
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Država:</label>
                    <asp:TextBox ID="ADRESA_SLANJE_DRZAVATextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_DRZAVA") %>' CssClass="form_item_value_edit" />
                </div>

                <h3 class="form_group">Dokumenti</h3>

                <div class="form_item">
                    <label class="form_item_label_edit">Osobna:</label>
                    <br />
                    <a class="image_link thickbox" href='<%# Bind("SLIKA_OSOBNE_URL") %>' target="_blank" runat="server" id="lightboxSLIKA_OSOBNE">
                        <asp:Image ID="imgSLIKA_OSOBNE" runat="server" ImageUrl='<%# Eval("SLIKA_OSOBNE_THUMB_URL") %>' CssClass="form_item_value_edit" />
                    </a>
                    <asp:LinkButton ID="linkOsobnaClear" runat="server" CausesValidation="True" CommandName="slika_osobna_clear" Text="X" ToolTip="Obriši osobnu" />
                    <br />
                    <asp:FileUpload ID="fileOsobna" runat="server" />
                    <asp:LinkButton ID="btnSpremiOsobnu" runat="server" CausesValidation="True" CommandName="slika_osobna" Text="Spremi osobnu" />

                </div>

                <div class="form_item" id="divOsobnaDruga" runat="server">
                    <label class="form_item_label_edit">Osobna drugog zastupnika:</label>
                    <br />
                    <a class="image_link thickbox" href='<%# Bind("SLIKA_OSOBNE_DRUGI_URL") %>' target="_blank" runat="server" id="lightboxSLIKA_OSOBNE_DRUGI">
                        <asp:Image ID="imgSLIKA_OSOBNE_DRUGI" runat="server" ImageUrl='<%# Eval("SLIKA_OSOBNE_DRUGI_THUMB_URL") %>' CssClass="form_item_value_edit" />
                    </a>
                    <asp:LinkButton ID="linkOsobnaDrugiClear" runat="server" CausesValidation="True" CommandName="slika_osobna_drugi_clear" Text="X" ToolTip="Obriši osobnu" />
                    <br />
                    <asp:FileUpload ID="fileOsobnaDrugi" runat="server" />
                    <asp:LinkButton ID="btnSpremiOsobnuDrugi" runat="server" CausesValidation="True" CommandName="slika_osobna_drugi" Text="Spremi osobnu" />

                </div>

                <div class="form_item" id="divKarticaRacuna" runat="server">
                    <label class="form_item_label_edit">Kartica računa:</label>
                    <br />
                    <a class="image_link thickbox" href='<%# Bind("KARTICA_RACUNA_URL") %>' target="_blank" runat="server" id="lightboxKARTICA_RACUNA">
                        <asp:Image ID="imgKARTICA_RACUNA" runat="server" ImageUrl='<%# Eval("KARTICA_RACUNA_THUMB_URL") %>' CssClass="form_item_value_edit" />
                    </a>
                    <asp:LinkButton ID="linkKarticaClear" runat="server" CausesValidation="True" CommandName="slika_kartica_clear" Text="X" ToolTip="Obriši karticu računa" />
                    <br />
                    <asp:FileUpload ID="fileKartica" runat="server" />
                    <asp:LinkButton ID="btnSpremiKarticu" runat="server" CausesValidation="True" CommandName="slika_kartica" Text="Spremi karticu" />
                </div>

                <div class="form_item" id="divIzvod" runat="server">
                    <label class="form_item_label_edit">Scan izvoda iz Sudskog registra:</label>
                    <br />
                    <a class="image_link thickbox" href='<%# Bind("IZVOD_SCAN_URL") %>' target="_blank" runat="server" id="lightboxIZVOD_SCAN_URL">
                        <asp:Image ID="imgIZVOD_SCAN_URL" runat="server" ImageUrl='<%# Eval("IZVOD_SCAN_THUMB_URL") %>' CssClass="form_item_value_edit" />
                    </a>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="izvod_clear" Text="X" ToolTip="Obriši izvod" />
                    <br />
                    <asp:FileUpload ID="fileIzvod" runat="server" />
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="True" CommandName="slika_izvod" Text="Spremi izvod" />
                </div>

                <div class="form_item" id="divPotpisniKarton" runat="server">
                    <label class="form_item_label_edit">Scan potpisnog kartona:</label>
                    <br />
                    <a class="image_link thickbox" href='<%# Bind("POTPISNI_KARTON_SCAN_URL") %>' target="_blank" runat="server" id="lightboxPOTPISNI_KARTON_SCAN_URL">
                        <asp:Image ID="imgPOTPISNI_KARTON_SCAN_URL" runat="server" ImageUrl='<%# Eval("POTPISNI_KARTON_SCAN_THUMB_URL") %>' CssClass="form_item_value_edit" />
                    </a>
                    <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="True" CommandName="potpisni_karton_clear" Text="X" ToolTip="Obriši postpisni karton" />
                    <br />
                    <asp:FileUpload ID="filePotpisniKarton" runat="server" />
                    <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="True" CommandName="slika_postpisni_karton" Text="Spremi potpisni karton" />
                </div>

            </div>

            <div class="btn_navigation_group">
                <asp:Button ID="UpdateButton" CssClass="btn_navigation save" runat="server" CausesValidation="True" CommandName="Update" Text="Spremi" />&nbsp;
                <asp:Button ID="UpdateCancelButton" CssClass="btn_navigation cancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" />
            </div>

        </EditItemTemplate>
        <InsertItemTemplate>
            
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>

            <div class="readonly">

                <div class="left">

                    <h3 class="form_group">Osnovni podaci</h3>

                    <div class="form_item">
                        <label class="form_item_label" id="lblIme" runat="server">Ime:</label>
                        <asp:Label ID="TextBox1" runat="server" Text='<%# Bind("IME") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item" id="divPrezime" runat="server">
                        <label class="form_item_label">Prezime:</label>
                        <asp:Label ID="TextBox2" runat="server" Text='<%# Bind("PREZIME") %>' CssClass="form_item_value" />
                    </div>
                    
                    <div class="form_item">
                        <label class="form_item_label" id="lblMB" runat="server">MB:</label>
                        <asp:Label ID="TextBox3" runat="server" Text='<%# Bind("MB") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">OIB:</label>
                        <asp:Label ID="TextBox4" runat="server" Text='<%# Bind("OIB") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Osobni dokument:</label>
                        <asp:Label ID="FIZICKA_DOKUMENT_TIP" runat="server" Text='<%# Bind("FIZICKA_DOKUMENT_TIP_NAZIV") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Broj dokumenta:</label>
                        <asp:Label ID="FIZICKA_DOKUMENT_BROJTextBox" runat="server" Text='<%# Bind("FIZICKA_DOKUMENT_BROJ") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Izdavatelj dokumenta:</label>
                        <asp:Label ID="FIZICKA_DOKUMENT_IZDAVATELJTextBox" runat="server" Text='<%# Bind("FIZICKA_DOKUMENT_IZDAVATELJ") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Dokument vrijedi do:</label>
                        <asp:Label ID="FIZICKA_DOKUMENT_VRIJEDI_DOTextBox" runat="server" Text='<%# Bind("FIZICKA_DOKUMENT_VRIJEDI_DO", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item" id="divVlasnistvoPodijeljeno" runat="server">
                        <label class="form_item_label">Vlasništvo je podijeljeno na dijelove veće od 25%:</label>
                        <asp:Label ID="VLASNISTVO_PODIJELJENOTxt" runat="server" CssClass="form_item_value" Text='<%# BoolToString(Eval("PRAVNA_VLASNISTVO_PODIJELJENO")) %>' ></asp:Label>
                    </div>

                    <div class="form_item" id="divPravnaUlaganja" runat="server">
                        <label class="form_item_label">Planirana godišnja ulaganja u investicijske fondove:</label>
                        <asp:Label ID="PRAVNA_PLANIRANA_GOD_ULAGANJA" runat="server" Text='<%# Bind("PRAVNA_PLANIRANA_GOD_ULAGANJA_NAZIV") %>' CssClass="form_item_value"></asp:Label>
                    </div>

                    <h3 class="form_group">Adresa</h3>

                    <div class="form_item">
                        <label class="form_item_label">Ulica:</label>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("ADRESA_ULICA") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">br.:</label>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("ADRESA_KUCNI_BROJ") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Poštanski broj:</label>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("ADRESA_POSTANSKI_BROJ") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Mjesto/grad:</label>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("ADRESA_MJESTO") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Država:</label>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("ADRESA_DRZAVA") %>' CssClass="form_item_value" />
                    </div>

                    <h3 class="form_group">Kontakt podaci</h3>

                    <div class="form_item">
                        <label class="form_item_label">Telefon:</label>
                        <asp:Label ID="TextBox7" runat="server" Text='<%# Bind("TELEFON") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Mobitel:</label>
                        <asp:Label ID="TextBox8" runat="server" Text='<%# Bind("MOBITEL") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Fax:</label>
                        <asp:Label ID="TextBox9" runat="server" Text='<%# Bind("FAX") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">E-mail:</label>
                        <asp:Label ID="TextBox10" runat="server" Text='<%# Bind("KONTAKT_EMAIL") %>' CssClass="form_item_value" />
                    </div>

                    <h3 class="form_group">Račun za isplatu</h3>

                    <div class="form_item">
                        <label class="form_item_label" for="ddlBanke">IBAN:</label>
<%--                        <asp:Label ID="VBDITextBox" placeholder="VBDI" CssClass="form_item_value" runat="server" ClientIDMode="Static" Text='<%# Bind("RACUN_VBDI") %>' />--%>
                        <asp:Label ID="RACUN_BROJTextBox" ClientIDMode="Static" CssClass="form_item_value" runat="server" Text='<%# Bind("RACUN_BROJ") %>' />
                    </div>

                </div>

                <div class="right">

                                        <div id="divZastupnik" runat="server">

                        <h3 class="form_group">Zakonski zastupnik</h3>

                        <div class="form_item">
                            <label class="form_item_label">Ime:</label>
                            <asp:Label ID="ZASTUPNIK_IMETextBox" runat="server" Text='<%# Bind("ZASTUPNIK_IME") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Prezime:</label>
                            <asp:Label ID="ZASTUPNIK_PREZIMETextBox" runat="server" Text='<%# Bind("ZASTUPNIK_PREZIME") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">JMBG:</label>
                            <asp:Label ID="ZASTUPNIK_JMBGTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_JMBG") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">OIB:</label>
                            <asp:Label ID="ZASTUPNIK_OIBTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_OIB") %>' CssClass="form_item_value" />
                        </div>

                        <h3 class="form_group">Adresa zastupnika</h3>

                        <div class="form_item">
                            <label class="form_item_label">Ulica:</label>
                            <asp:Label ID="ZASTUPNIK_ADRESA_ULICATextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_ULICA") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">br.:</label>
                            <asp:Label ID="TextBox5" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_KUCNI_BROJ") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Poštanski broj:</label>
                            <asp:Label ID="ZASTUPNIK_ADRESA_P_BROJTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_P_BROJ") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Mjesto/grad:</label>
                            <asp:Label ID="ZASTUPNIK_ADRESA_MJESTOTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_MJESTO") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Država:</label>
                            <asp:Label ID="ZASTUPNIK_ADRESA_DRZAVATextBox" runat="server" Text='<%# Bind("ZASTUPNIK_ADRESA_DRZAVA") %>' CssClass="form_item_value" />
                        </div>

                        <h3 class="form_group">Kontakt podaci zastupnika</h3>

                        <div class="form_item">
                            <label class="form_item_label">Telefon:</label>
                            <asp:Label ID="ZASTUPNIK_TELEFONTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_TELEFON") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Mobitel:</label>
                            <asp:Label ID="ZASTUPNIK_MOBITELTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_MOBITEL") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Fax:</label>
                            <asp:Label ID="ZASTUPNIK_FAXTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_FAX") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">E-mail:</label>
                            <asp:Label ID="ZASTUPNIK_EMAILTextBox" runat="server" Text='<%# Bind("ZASTUPNIK_EMAIL") %>' CssClass="form_item_value" />
                        </div>

                    </div>


                    <h3 class="form_group">Podaci o rođenju</h3>

                    <div class="form_item">
                        <label class="form_item_label">Datum rođenja:</label>
                        <asp:Label ID="FIZICKA_DATUM_RODENJATextBox" runat="server" Text='<%# Bind("FIZICKA_DATUM_RODENJA", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Mjesto rođenja:</label>
                        <asp:Label ID="FIZICKA_MJESTO_RODENJATextBox" runat="server" Text='<%# Bind("FIZICKA_MJESTO_RODENJA") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Država rođenja:</label>
                        <asp:Label ID="FIZICKA_DRZAVA_RODENJATextBox" runat="server" Text='<%# Bind("FIZICKA_DRZAVA_RODENJA") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Državljanstvo:</label>
                        <asp:Label ID="FIZICKA_DRZAVLJANSTVOTextBox" runat="server" Text='<%# Bind("FIZICKA_DRZAVLJANSTVO") %>' CssClass="form_item_value" />
                    </div>

                    <div id="divFizickaOstalo" runat="server">

                        <h3 class="form_group">Dodatni podaci</h3>

                        <div class="form_item">
                            <label class="form_item_label">Osobni status:</label>
                            <asp:Label ID="DropDownList1FIZICKA_STATUS_ODABIR" runat="server" Text='<%# Bind("FIZICKA_STATUS_ODABIR_NAZIV") %>' CssClass="form_item_value"></asp:Label>
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Vrsta poslodavca:</label>
                            <asp:Label ID="FIZICKA_VRSTA_POSLODAVCA" runat="server" Text='<%# Bind("FIZICKA_VRSTA_POSLODAVCA_NAZIV") %>' CssClass="form_item_value"></asp:Label>
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Stručna sprema:</label>
                            <asp:Label ID="FIZICKA_STRUCNA_SPREMA" runat="server" Text='<%# Bind("FIZICKA_STRUCNA_SPREMA_NAZIV") %>' CssClass="form_item_value"></asp:Label>
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Zvanje:</label>
                            <asp:Label ID="FIZICKA_ZVANJETextBox" runat="server" Text='<%# Bind("FIZICKA_ZVANJE") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Zanimanje:</label>
                            <asp:Label ID="FIZICKA_ZANIMANJETextBox" runat="server" Text='<%# Bind("FIZICKA_ZANIMANJE") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Planirana godišnja ulaganja u investicijske fondove:</label>
                            <asp:Label ID="FIZICKA_PLANIRANA_GOD_ULAGANJA" runat="server" Text='<%# Bind("FIZICKA_PLANIRANA_GOD_ULAGANJA_NAZIV") %>' CssClass="form_item_value"></asp:Label>
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Sredstva za ulaganje ostvarena su iz:</label>
                            <asp:Label ID="FIZICKA_SREDSTVA_OSTVARENA" runat="server" Text='<%# Bind("FIZICKA_SREDSTVA_OSTVARENA_NAZIV") %>' CssClass="form_item_value"></asp:Label>
                        </div>

                        <div class="form_item">
                            <label class="form_item_label">Politička izloženost:</label>
                            <asp:Label ID="POLITICKA_IZLOZENOSTTxt" runat="server" CssClass="form_item_value" RepeatDirection="Horizontal" Text='<%# BoolToString(Eval("FIZICKA_POLITICKA_IZLOZENOST")) %>' ></asp:Label>
                        </div>

                    </div>

                    <h3 class="form_group">Adresa za slanje pošte</h3>

                    <div class="form_item">
                        <label class="form_item_label">Ulica:</label>
                        <asp:Label ID="ADRESA_SLANJE_ULICATextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_ULICA") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">br.:</label>
                        <asp:Label ID="TextBox6" runat="server" Text='<%# Bind("ADRESA_SLANJE_KUCNI_BROJ") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Poštanski broj:</label>
                        <asp:Label ID="ADRESA_SLANJE_POSTANSKI_BROJTextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_POSTANSKI_BROJ") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Mjesto/grad:</label>
                        <asp:Label ID="ADRESA_SLANJE_MJESTOTextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_MJESTO") %>' CssClass="form_item_value" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label">Država:</label>
                        <asp:Label ID="ADRESA_SLANJE_DRZAVATextBox" runat="server" Text='<%# Bind("ADRESA_SLANJE_DRZAVA") %>' CssClass="form_item_value" />
                    </div>

                    <h3 class="form_group">Dokumenti</h3>

                    <div class="form_item inline">
                        <label class="form_item_label">Osobna:</label>
                        <br />
                        <a class="image_link" href='<%# Bind("SLIKA_OSOBNE_URL") %>' target="_blank" runat="server" id="lightboxSLIKA_OSOBNE">
                            <asp:Image ID="imgSLIKA_OSOBNE" runat="server" ImageUrl='<%# Eval("SLIKA_OSOBNE_THUMB_URL") %>' CssClass="form_item_value" />
                        </a>

                    </div>

                    <div class="form_item inline" id="divOsobnaDruga" runat="server">
                        <label class="form_item_label">Osobna drugog zastupnika:</label>
                        <br />
                        <a class="image_link" href='<%# Bind("SLIKA_OSOBNE_DRUGI_URL") %>' target="_blank" runat="server" id="lightboxSLIKA_OSOBNE_DRUGI">
                            <asp:Image ID="imgSLIKA_OSOBNE_DRUGI" runat="server" ImageUrl='<%# Eval("SLIKA_OSOBNE_DRUGI_THUMB_URL") %>' CssClass="form_item_value" />
                        </a>
                    </div>

                    <div class="form_item inline" id="divKarticaRacuna" runat="server">
                        <label class="form_item_label">Kartica računa:</label>
                        <br />
                        <a class="image_link" href='<%# Bind("KARTICA_RACUNA_URL") %>' target="_blank" runat="server" id="lightboxKARTICA_RACUNA">
                            <asp:Image ID="imgKARTICA_RACUNA" runat="server" ImageUrl='<%# Eval("KARTICA_RACUNA_THUMB_URL") %>' CssClass="form_item_value" />
                        </a>
                    </div>

                    <div class="form_item inline" id="divIzvod" runat="server">
                        <label class="form_item_label">Izvod iz Sudskog Registra:</label>
                        <br />
                        <a class="image_link" href='<%# Bind("IZVOD_SCAN_URL") %>' target="_blank" runat="server" id="lightboxIZVOD_SCAN_URL">
                            <asp:Image ID="imgIZVOD_SCAN_URL" runat="server" ImageUrl='<%# Eval("IZVOD_SCAN_THUMB_URL") %>' CssClass="form_item_value" />
                        </a>
                    </div>

                    <div class="form_item inline" id="divPotpisniKarton" runat="server">
                        <label class="form_item_label">Potpisni karton:</label>
                        <br />
                        <a class="image_link" href='<%# Bind("POTPISNI_KARTON_SCAN_URL") %>' target="_blank" runat="server" id="lightboxPOTPISNI_KARTON_SCAN_URL">
                            <asp:Image ID="imgPOTPISNI_KARTON_SCAN_URL" runat="server" ImageUrl='<%# Eval("POTPISNI_KARTON_SCAN_THUMB_URL") %>' CssClass="form_item_value" />
                        </a>
                    </div>

                </div>
            </div>

            <div class="btn_navigation_group">
                <asp:Button ID="EditButton" CssClass="btn_navigation" runat="server" CausesValidation="False" CommandName="Edit" Text="Uredi podatke" />
            </div>

        </ItemTemplate>
    </asp:FormView>

    </div>

    <asp:EntityDataSource 
        ID="EntityDataSourceKorisnikDodatno" 
        ContextTypeName="InvestApp.DAL.FondEntities" 
        runat="server" 
        ConnectionString="name=FondEntities" 
        DefaultContainerName="FondEntities" EnableFlattening="False" EnableUpdate="True" 
        EntitySetName="Korisnici" 
        EntityTypeFilter="Korisnik" 
        AutoGenerateWhereClause="True" 
        OnSelecting="EntityDataSourceKorisnikDodatno_Selecting" >
        <InsertParameters>
            <asp:Parameter Name="SLIKA_OSOBNE_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="KARTICA_RACUNA_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="IZVOD_SCAN_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="POTPISNI_KARTON_SCAN_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="SLIKA_OSOBNE_DRUGI_URL" ConvertEmptyStringToNull="true" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="SLIKA_OSOBNE_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="KARTICA_RACUNA_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="IZVOD_SCAN_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="POTPISNI_KARTON_SCAN_URL" ConvertEmptyStringToNull="true" Type="String" />
            <asp:Parameter Name="SLIKA_OSOBNE_DRUGI_URL" ConvertEmptyStringToNull="true" Type="String" />
        </UpdateParameters>
    </asp:EntityDataSource>

</asp:Content>