<%@ Page Title="" Language="C#" Culture="de-DE" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondUredjivanje.aspx.cs" Inherits="InvestApp.Web.FondUredjivanje" ValidateRequest="false" %>

<asp:Content ID="contentHead" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/tinymce.min.js") %>'></script>

    <script type="text/javascript">
        tinymce.init({
            selector: "#DODATNI_PODACITxt",
            plugins: "link",
            entity_encoding: "raw",
            height: 150,
            menubar: false,
            toolbar: ["bold italic underline strikethrough alignleft aligncenter alignright alignjustify styleselect formatselect fontsizeselect",
                      "cut copy paste bullist numlist outdent indent removeformat subscript superscript link unlink"]
        });
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">

        function makeSafe(control) {
            control.value = window.escape(document.getElementById('TextBox1').value);
        };

        function clearDocLink(linkID, hiddenFieldID) {
            $('#' + linkID).removeAttr('href');
            $('#' + hiddenFieldID).removeAttr('value');
        }

    </script>

    <asp:Label ID="lblLog" runat="server"></asp:Label>

    <h1 class="form_header bar normal" id="formHeader" runat="server">Uređivanje fonda</h1>

    <div class="form_body">

        <asp:FormView ID="FormViewFond" runat="server" DataKeyNames="ID" RenderOuterTable="False" DataSourceID="EntityDataSourceFond" DefaultMode="Edit" OnItemCommand="FormViewKorisnik_ItemCommand" OnItemUpdated="FormViewKorisnik_ItemUpdated" OnItemUpdating="FormViewFond_ItemUpdating" OnItemInserted="FormViewFond_ItemInserted" OnDataBound="FormViewFond_DataBound">
            <EditItemTemplate>

                <div class="edit">

                    <div class="form_item">
                        <label class="form_item_label_edit">Opis fonda:</label>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("OPIS") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit" title="Svako uneseno slovo predstavlja zasebnu grupu">Grupe:</label>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("GRUPE") %>' CssClass="form_item_value_edit" />
                    </div>

                    <h3 class="form_group">DOKUMENTI FONDA</h3>

                    <div class="form_item">
                        <a href="javascript: void(0);" class="link_add_file" onclick="$('#divDokKIID').toggle();" title="Odaberi"></a>
                        <asp:HyperLink ID="linkDokKIID" ClientIDMode="Static" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Eval("KIID_URL") %>'>Ključne informacije za ulagatelje</asp:HyperLink>
                        <asp:HiddenField ID="hfDokKIID" ClientIDMode="Static" runat="server" Value='<%# Bind("KIID_URL") %>' />
                        <a href="javascript: void(0);" class="link_clear_file" onclick="clearDocLink('linkDokKIID', 'hfDokKIID');" title="Obriši"></a>
                        <div id="divDokKIID" class="form_item" style="display: none;">
                            <label class="form_item_label_edit">Ključne informacije za ulagatelje (PDF):</label>
                            <asp:FileUpload ID="fileKIID" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>
                    </div>

                    <div class="form_item">
                        <a href="javascript: void(0);" class="link_add_file" onclick="$('#divDokPravila').toggle();" title="Odaberi"></a>
                        <asp:HyperLink ID="linkDokPravila" ClientIDMode="Static" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Eval("PRAVILA_URL") %>'>Pravila fonda</asp:HyperLink>
                        <asp:HiddenField ID="hfDokPravila" ClientIDMode="Static" runat="server" Value='<%# Bind("PRAVILA_URL") %>' />
                        <a href="javascript: void(0);" class="link_clear_file" onclick="clearDocLink('linkDokPravila', 'hfDokPravila');" title="Obriši"></a>
                        <div id="divDokPravila" class="form_item" style="display: none;">
                            <label class="form_item_label_edit">Pravila fonda (PDF):</label>
                            <asp:FileUpload ID="filePravila" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>
                    </div>

                    <div class="form_item">
                        <a href="javascript: void(0);" class="link_add_file" onclick="$('#divDokProspekt').toggle();" title="Odaberi"></a>
                        <asp:HyperLink ID="linkDokProspekt" ClientIDMode="Static" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Eval("PROSPEKT_URL") %>'>Prospekt fonda</asp:HyperLink>
                        <asp:HiddenField ID="hfDokProspekt" ClientIDMode="Static" runat="server" Value='<%# Bind("PROSPEKT_URL") %>' />
                        <a href="javascript: void(0);" class="link_clear_file" onclick="clearDocLink('linkDokProspekt', 'hfDokProspekt');" title="Obriši"></a>
                        <div id="divDokProspekt" class="form_item" style="display: none;">
                            <label class="form_item_label_edit">Prospekt fonda (PDF):</label>
                            <asp:FileUpload ID="fileProspekt" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>
                    </div>

                    <div class="form_item">
                        <a href="javascript: void(0);" class="link_add_file" onclick="$('#divDokOsobna').toggle();" title="Odaberi"></a>
                        <asp:HyperLink ID="linkDokOsobna" ClientIDMode="Static" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Eval("OSOBNA_ISKAZNICA_URL") %>'>Osobna iskaznica</asp:HyperLink>
                        <asp:HiddenField ID="hfkDokOsobna" ClientIDMode="Static" runat="server" Value='<%# Bind("OSOBNA_ISKAZNICA_URL") %>' />
                        <a href="javascript: void(0);" class="link_clear_file" onclick="clearDocLink('linkDokOsobna', 'hfkDokOsobna');" title="Obriši"></a>
                        <div id="divDokOsobna" class="form_item" style="display: none;">
                            <label class="form_item_label_edit">Osobna iskaznica (PDF):</label>
                            <asp:FileUpload ID="fileOsobna" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>
                    </div>

                    <%--<div class="form_item">
                        <asp:CheckBox ID="chkDok" runat="server" Text="Promijeni dokumente" CssClass="form_item_value_edit" AutoPostBack="true" OnCheckedChanged="chkDok_CheckedChanged" />
                    </div>

                    <div id="divDokUpload" runat="server" visible="false">
                    </div>--%>

                    <h3 class="form_group">OSNOVNE INFORMACIJE</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Društvo:</label>
                        <%--<asp:Label ID="DRUSTVA_IDLabel" runat="server" Text='<%# Eval("DRUSTVO_NAZIV") %>' CssClass="form_item_value_edit" />--%>
                        <asp:DropDownList ID="ddlDrustvo" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("DRUSTVA_ID") %>' DataSourceID="EntityDataSourceDrustva" DataTextField="NAZIV" DataValueField="ID"></asp:DropDownList>
                    </div>


                    <div class="form_item">
                        <label class="form_item_label_edit">Naziv fonda:</label>
                        <asp:TextBox ID="txtNaziv" runat="server" Text='<%# Bind("NAZIV") %>' CssClass="form_item_value_edit" />

                        <asp:RequiredFieldValidator ID="valNazivReq" Display="Dynamic" ControlToValidate="txtNaziv" runat="server" ErrorMessage="Naziv mora biti unesen" SetFocusOnError="true" CssClass="validate_error_inline"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Kategorija:</label>
                        <asp:DropDownList ID="KATEGORIJA_IDLabel" runat="server" SelectedValue='<%# Bind("KATEGORIJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Dionički" Value="4"></asp:ListItem>
                            <asp:ListItem Text="Mješoviti" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Obveznički" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Novčani" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Geografska regija:</label>
                        <asp:DropDownList ID="GEO_IDLabel" runat="server" SelectedValue='<%# Bind("REGIJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Globalni" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Europa" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Istočna Europa" Value="6"></asp:ListItem>
                            <asp:ListItem Text="Jugoistočna Europa" Value="5"></asp:ListItem>
                            <asp:ListItem Text="Hrvatska" Value="7"></asp:ListItem>
                            <asp:ListItem Text="Azija i Pacifik" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Sjeverna Amerika" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Ulaganje:</label>
                        <asp:DropDownList ID="TIP_ULAGANJA_IDLabel" runat="server" SelectedValue='<%# Bind("TIP_ULAGANJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Fond fondova" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Direktno ulaganje" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Upravljanje:</label>
                        <asp:DropDownList ID="TIP_UPRAVLJANJA_IDLabel" runat="server" SelectedValue='<%# Bind("TIP_UPRAVLJANJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Aktivno" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Pasivno" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Cilj prinosa:</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("CILJ_PRINOSA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Relativni" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Apsolutni" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Sektor:</label>
                        <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("SEKTOR_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Svi sektori" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Energija i robe" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Tržište:</label>
                        <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("TRZISTE_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Razvijena tržišta" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Tržišta u nastajanju" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Granična tržišta" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Profil rizičnosti i uspješnosti:</label>
                        <asp:DropDownList ID="DropDownList4" runat="server" SelectedValue='<%# Bind("PROFIL_RIZICNOSTI_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                            <asp:ListItem Text="6" Value="6"></asp:ListItem>
                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <%--<div class="form_item">
                        <label class="form_item_label_edit">Rizičnost:</label>
                        <asp:DropDownList ID="RIZICNOSTLabel" runat="server" SelectedValue='<%# Bind("RIZICNOST") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Value="VN" Text="Vrlo niska"></asp:ListItem>
                            <asp:ListItem Value="NN" Text="Niska"></asp:ListItem>
                            <asp:ListItem Value="UU" Text="Umjerena"></asp:ListItem>
                            <asp:ListItem Value="VS" Text="Visoka"></asp:ListItem>
                            <asp:ListItem Value="VV" Text="Vrlo visoka"></asp:ListItem>
                        </asp:DropDownList>
                    </div>--%>

                    <div class="form_item">
                        <label class="form_item_label_edit">Valuta:</label>
                        <asp:DropDownList ID="VALUTA_SIFRALabel" runat="server" CssClass="form_item_value_edit" DataTextField="OZNAKA" DataValueField="SIFRA" SelectedValue='<%# Bind("VALUTA_SIFRA") %>' DataSourceID="EntityDataSourceValute"></asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Trenutna imovina fonda:</label>
                        <asp:TextBox ID="IMOVINA_FONDALabel" runat="server" Text='<%# Bind("IMOVINA_FONDA", "{0:n2}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator4" ControlToValidate="IMOVINA_FONDALabel" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,00" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Datum početka rada:</label>
                        <asp:TextBox ID="DATUM_OSNIVANJALabel" runat="server" Text='<%# Bind("DATUM_OSNIVANJA", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator5" ControlToValidate="DATUM_OSNIVANJALabel" Type="Date" Operator="DataTypeCheck"
                            ErrorMessage="Datum mora biti u formatu 01.12.1999" runat="server" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <h3 class="form_group">TROŠKOVI FONDA</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Ulazna naknada:</label>
                        <asp:TextBox ID="NAKNADA_ULAZNALabel" runat="server" Text='<%# Bind("NAKNADA_ULAZNA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Izlazna naknada:</label>
                        <asp:TextBox ID="NAKNADA_IZLAZNALabel" runat="server" Text='<%# Bind("NAKNADA_IZLAZNA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Naknada za upravljanjem fonda:</label>
                        <asp:TextBox ID="NAKNADA_ZA_UPRAVLJANJEM_FONDALabel" runat="server" Text='<%# Bind("NAKNADA_ZA_UPRAVLJANJEM_FONDA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Naknada depozitarnoj banci:</label>
                        <asp:TextBox ID="NAKNADA_DEPOZITARNOJ_BANCILabel" runat="server" Text='<%# Bind("NAKNADA_DEPOZITARNOJ_BANCI") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Pokazatelj ukupnih troškova fonda:</label>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("POKAZATELJ_UKUPNIH_TROSKOVA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
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

                    <h3 class="form_group">DODATNI PODACI</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Minimalna početna uplata:</label>
                        <asp:TextBox ID="MINIMALNA_POCETNA_UPLATALabel" runat="server" Text='<%# Bind("MINIMALNA_POCETNA_UPLATA", "{0:n2}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator3" ControlToValidate="MINIMALNA_POCETNA_UPLATALabel" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,00" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Minimalne ostale uplate:</label>
                        <asp:TextBox ID="MINIMALNE_OSTALE_UPLATELabel" runat="server" Text='<%# Bind("MINIMALNE_OSTALE_UPLATE", "{0:n2}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator1" ControlToValidate="MINIMALNE_OSTALE_UPLATELabel" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,00" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Početna cijena udjela:</label>
                        <asp:TextBox ID="POCETNA_CIJENA_UDJELALabel" runat="server" Text='<%# Bind("POCETNA_CIJENA_UDJELA", "{0:n4}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator2" ControlToValidate="POCETNA_CIJENA_UDJELALabel" Type="Double" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,0000" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <asp:TextBox ID="DODATNI_PODACITxt" ClientIDMode="Static" runat="server" Text='<%# Bind("DODATNI_PODACI") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                </div>

                <div class="btn_navigation_group">
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Spremi" CssClass="btn_navigation save" />
                    <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" CssClass="btn_navigation cancel" />
                </div>

            </EditItemTemplate>
            <InsertItemTemplate>

                <div class="edit">

                    <div class="form_item">
                        <label class="form_item_label_edit">Opis fonda:</label>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("OPIS") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <h3 class="form_group">DOKUMENTI FONDA</h3>
                    
                    <div id="divDokUpload" runat="server">

                        <div class="form_item">
                            <label class="form_item_label_edit">Ključne informacije za ulagatelje (PDF):</label>
                            <asp:FileUpload ID="fileKIID" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label_edit">Pravila fonda (PDF):</label>
                            <asp:FileUpload ID="filePravila" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label_edit">Prospekt fonda (PDF):</label>
                            <asp:FileUpload ID="fileProspekt" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>

                        <div class="form_item">
                            <label class="form_item_label_edit">Osobna iskaznica (PDF):</label>
                            <asp:FileUpload ID="fileOsobna" runat="server" CssClass="form_item_value_edit pdf" />
                        </div>

                    </div>

                    <h3 class="form_group">OSNOVNE INFORMACIJE FONDA</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Društvo:</label>
                        <asp:DropDownList ID="ddlDrustvo" runat="server" CssClass="form_item_value_edit" SelectedValue='<%# Bind("DRUSTVA_ID") %>' DataSourceID="EntityDataSourceDrustva" DataTextField="NAZIV" DataValueField="ID"></asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Naziv fonda:</label>
                        <asp:TextBox ID="txtNaziv" runat="server" Text='<%# Bind("NAZIV") %>' CssClass="form_item_value_edit" />

                        <asp:RequiredFieldValidator ID="valNazivReq" Display="Dynamic" ControlToValidate="txtNaziv" runat="server" ErrorMessage="Naziv mora biti unesen" SetFocusOnError="true" CssClass="validate_error_inline"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Kategorija:</label>
                        <asp:DropDownList ID="KATEGORIJA_IDLabel" runat="server" SelectedValue='<%# Bind("KATEGORIJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Dionički" Value="4"></asp:ListItem>
                            <asp:ListItem Text="Mješoviti" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Obveznički" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Novčani" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Geografska regija:</label>
                        <asp:DropDownList ID="GEO_IDLabel" runat="server" SelectedValue='<%# Bind("REGIJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Globalni" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Europa" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Istočna Europa" Value="6"></asp:ListItem>
                            <asp:ListItem Text="Jugoistočna Europa" Value="5"></asp:ListItem>
                            <asp:ListItem Text="Hrvatska" Value="7"></asp:ListItem>
                            <asp:ListItem Text="Azija i Pacifik" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Sjeverna Amerika" Value="4"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Ulaganje:</label>
                        <asp:DropDownList ID="TIP_ULAGANJA_IDLabel" runat="server" SelectedValue='<%# Bind("TIP_ULAGANJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Fond fondova" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Direktno ulaganje" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Upravljanje:</label>
                        <asp:DropDownList ID="TIP_UPRAVLJANJA_IDLabel" runat="server" SelectedValue='<%# Bind("TIP_UPRAVLJANJA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Aktivno" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Pasivno" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Cilj prinosa:</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("CILJ_PRINOSA_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Relativni" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Apsolutni" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Sektor:</label>
                        <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("SEKTOR_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Svi sektori" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Energija i robe" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Tržište:</label>
                        <asp:DropDownList ID="DropDownList3" runat="server" SelectedValue='<%# Bind("TRZISTE_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="Razvijena tržišta" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Tržišta u nastajanju" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Granična tržišta" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Profil rizičnosti i uspješnosti:</label>
                        <asp:DropDownList ID="DropDownList4" runat="server" SelectedValue='<%# Bind("PROFIL_RIZICNOSTI_ID") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                            <asp:ListItem Text="6" Value="6"></asp:ListItem>
                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <%--<div class="form_item">
                        <label class="form_item_label_edit">Rizičnost:</label>
                        <asp:DropDownList ID="RIZICNOSTLabel" runat="server" SelectedValue='<%# Bind("RIZICNOST") %>' CssClass="form_item_value_edit">
                            <asp:ListItem Value="VN" Text="Vrlo niska"></asp:ListItem>
                            <asp:ListItem Value="NN" Text="Niska"></asp:ListItem>
                            <asp:ListItem Value="UU" Text="Umjerena"></asp:ListItem>
                            <asp:ListItem Value="VS" Text="Visoka"></asp:ListItem>
                            <asp:ListItem Value="VV" Text="Vrlo visoka"></asp:ListItem>
                        </asp:DropDownList>
                    </div>--%>

                    <div class="form_item">
                        <label class="form_item_label_edit">Valuta:</label>
                        <asp:DropDownList ID="VALUTA_SIFRALabel" runat="server" CssClass="form_item_value_edit" DataTextField="OZNAKA" DataValueField="SIFRA" SelectedValue='<%# Bind("VALUTA_SIFRA") %>' DataSourceID="EntityDataSourceValute"></asp:DropDownList>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Trenutna imovina fonda:</label>
                        <asp:TextBox ID="IMOVINA_FONDALabel" runat="server" Text='<%# Bind("IMOVINA_FONDA", "{0:n2}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator8" ControlToValidate="IMOVINA_FONDALabel" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,00" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Datum početka rada:</label>
                        <asp:TextBox ID="DATUM_OSNIVANJALabel" runat="server" Text='<%# Bind("DATUM_OSNIVANJA", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator5" ControlToValidate="DATUM_OSNIVANJALabel" Type="Date" Operator="DataTypeCheck"
                            ErrorMessage="Datum mora biti u formatu 01.12.1999" runat="server" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <h3 class="form_group">TROŠKOVI FONDA</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Ulazna naknada:</label>
                        <asp:TextBox ID="NAKNADA_ULAZNALabel" runat="server" Text='<%# Bind("NAKNADA_ULAZNA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Izlazna naknada:</label>
                        <asp:TextBox ID="NAKNADA_IZLAZNALabel" runat="server" Text='<%# Bind("NAKNADA_IZLAZNA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Naknada za upravljanjem fonda:</label>
                        <asp:TextBox ID="NAKNADA_ZA_UPRAVLJANJEM_FONDALabel" runat="server" Text='<%# Bind("NAKNADA_ZA_UPRAVLJANJEM_FONDA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Naknada depozitarnoj banci:</label>
                        <asp:TextBox ID="NAKNADA_DEPOZITARNOJ_BANCILabel" runat="server" Text='<%# Bind("NAKNADA_DEPOZITARNOJ_BANCI") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Pokazatelj ukupnih troškova fonda:</label>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("POKAZATELJ_UKUPNIH_TROSKOVA") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
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

                    <h3 class="form_group">DODATNI PODACI</h3>

                    <div class="form_item">
                        <label class="form_item_label_edit">Minimalna početna uplata:</label>
                        <asp:TextBox ID="MINIMALNA_POCETNA_UPLATALabel" runat="server" Text='<%# Bind("MINIMALNA_POCETNA_UPLATA", "{0:n2}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator4" ControlToValidate="MINIMALNA_POCETNA_UPLATALabel" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,00" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Minimalne ostale uplate:</label>
                        <asp:TextBox ID="MINIMALNE_OSTALE_UPLATELabel" runat="server" Text='<%# Bind("MINIMALNE_OSTALE_UPLATE", "{0:n2}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator6" ControlToValidate="MINIMALNE_OSTALE_UPLATELabel" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,00" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit">Početna cijena udjela:</label>
                        <asp:TextBox ID="POCETNA_CIJENA_UDJELALabel" runat="server" Text='<%# Bind("POCETNA_CIJENA_UDJELA", "{0:n4}") %>' CssClass="form_item_value_edit" />

                        <asp:CompareValidator ID="CompareValidator7" ControlToValidate="POCETNA_CIJENA_UDJELALabel" Type="Double" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 123,0000" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <asp:TextBox ID="DODATNI_PODACITxt" ClientIDMode="Static" runat="server" Text='<%# Bind("DODATNI_PODACI") %>' CssClass="form_item_value_edit" TextMode="MultiLine" />
                    </div>

                </div>

                <div class="btn_navigation_group">
                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Spremi" CssClass="btn_navigation save" />
                    <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" CssClass="btn_navigation cancel" />
                </div>

            </InsertItemTemplate>
            <ItemTemplate>

                <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
            </ItemTemplate>
        </asp:FormView>

        <asp:EntityDataSource ID="EntityDataSourceFond" runat="server"
            ContextTypeName="InvestApp.DAL.FondEntities"
            ConnectionString="name=FondEntities"
            DefaultContainerName="FondEntities"
            EnableFlattening="False" EnableUpdate="True"
            EntitySetName="Fondovi" EntityTypeFilter="Fond"
            OnSelecting="EntityDataSourceFond_Selecting"
            AutoGenerateWhereClause="True" OnInserted="EntityDataSourceFond_Inserted"
            EnableInsert="True" OnUpdating="EntityDataSourceFond_Updating" OnUpdated="EntityDataSourceFond_Updated" >
            <InsertParameters>
                <asp:Parameter Name="KIID_URL" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="PRAVILA_URL" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="PROSPEKT_URL" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="OSOBNA_ISKAZNICA_URL" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NAKNADA_ULAZNA" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NAKNADA_IZLAZNA" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NAKNADA_ZA_UPRAVLJANJEM_FONDA" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NAKNADA_DEPOZITARNOJ_BANCI" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="DODATNI_PODACI" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="OPIS" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="POKAZATELJ_UKUPNIH_TROSKOVA" ConvertEmptyStringToNull="true" Type="String" />

                <asp:Parameter Name="NALOG_PRIMATELJ_RACUN" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NALOG_PBO_MODEL" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NALOG_PBO" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NALOG_SIFRA_NAMJENE" ConvertEmptyStringToNull="true" Type="String" />
                <asp:Parameter Name="NALOG_OPIS_PLACANJA" ConvertEmptyStringToNull="true" Type="String" />
            </InsertParameters>
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EntityDataSourceValute" runat="server"
            ContextTypeName="InvestApp.DAL.FondEntities"
            ConnectionString="name=FondEntities"
            DefaultContainerName="FondEntities" EnableFlattening="False"
            EntitySetName="VALUTE" EntityTypeFilter="VALUTA"
            OrderBy="it.OZNAKA">
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EntityDataSourceDrustva" runat="server"
            ConnectionString="name=FondEntities"
            ContextTypeName="InvestApp.DAL.FondEntities"
            DefaultContainerName="FondEntities"
            EnableFlattening="False"
            EntitySetName="Drustva"
            EntityTypeFilter="Drustvo">
        </asp:EntityDataSource>

    </div>


</asp:Content>
