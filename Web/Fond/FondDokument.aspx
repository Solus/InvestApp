<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondDokument.aspx.cs" Inherits="InvestApp.Web.FondDokument" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxDataView" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxFormLayout" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="EntityDataSource1" OnModeChanging="FormView1_ModeChanging" CssClass="form_body">
        <EditItemTemplate>
            
            <label>ID:</label>
            <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
            <br />
            <label>KATEGORIJA:</label>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="EntityDataSourceKategorije" DataTextField="NAZIV" DataValueField="ID"
                  SelectedValue='<%# Bind("KATEGORIJA_ID") %>' ></asp:DropDownList>
            <br />
            <label>GEO_ID:</label>
            <asp:TextBox ID="GEO_IDTextBox" runat="server" Text='<%# Bind("REGIJA_ID") %>' />
            <br />
            <label>TIP_ULAGANJA_ID:</label>
            <asp:TextBox ID="TIP_ULAGANJA_IDTextBox" runat="server" Text='<%# Bind("TIP_ULAGANJA_ID") %>' />
            <br />
            <label>TIP_UPRAVLJANJA_ID:</label>
            <asp:TextBox ID="TIP_UPRAVLJANJA_IDTextBox" runat="server" Text='<%# Bind("TIP_UPRAVLJANJA_ID") %>' />
            <br />
            <label>DRUSTVA_ID:</label>
            <asp:TextBox ID="DRUSTVA_IDTextBox" runat="server" Text='<%# Bind("DRUSTVA_ID") %>' />
            <br />
            <label>RIZICNOST:</label>
            <asp:TextBox ID="RIZICNOSTTextBox" runat="server" Text='<%# Bind("RIZICNOST") %>' />
            <br />
            <label>MINIMALNA_POCETNA_UPLATA:</label>
            <asp:TextBox ID="MINIMALNA_POCETNA_UPLATATextBox" runat="server" Text='<%# Bind("MINIMALNA_POCETNA_UPLATA") %>' />
            <br />
            <label>MINIMALNE_OSTALE_UPLATE:</label>
            <asp:TextBox ID="MINIMALNE_OSTALE_UPLATETextBox" runat="server" Text='<%# Bind("MINIMALNE_OSTALE_UPLATE") %>' />
            <br />
            <label>VALUTA_SIFRA:</label>
            <asp:TextBox ID="VALUTA_SIFRATextBox" runat="server" Text='<%# Bind("VALUTA_SIFRA") %>' />
            <br />
            <label>POCETNA_CIJENA_UDJELA:</label>
            <asp:TextBox ID="POCETNA_CIJENA_UDJELATextBox" runat="server" Text='<%# Bind("POCETNA_CIJENA_UDJELA") %>' />
            <br />
            <label>DATUM_OSNIVANJA:</label>
            <asp:TextBox ID="DATUM_OSNIVANJATextBox" runat="server" Text='<%# Bind("DATUM_OSNIVANJA") %>' />
            <br />
            <label>IMOVINA_FONDA:</label>
            <asp:TextBox ID="IMOVINA_FONDATextBox" runat="server" Text='<%# Bind("IMOVINA_FONDA") %>' />
            <br />
            <label>NAKNADA_ULAZNA:</label>
            <asp:TextBox ID="NAKNADA_ULAZNATextBox" runat="server" Text='<%# Bind("NAKNADA_ULAZNA") %>' />
            <br />
            <label>NAKNADA_IZLAZNA:</label>
            <asp:TextBox ID="NAKNADA_IZLAZNATextBox" runat="server" Text='<%# Bind("NAKNADA_IZLAZNA") %>' />
            <br />
            <label>NAKNADA_ZA_UPRAVLJANJEM_FONDA:</label>
            <asp:TextBox ID="NAKNADA_ZA_UPRAVLJANJEM_FONDATextBox" runat="server" Text='<%# Bind("NAKNADA_ZA_UPRAVLJANJEM_FONDA") %>' />
            <br />
            <label>NAKNADA_DEPOZITARNOJ_BANCI:</label>
            <asp:TextBox ID="NAKNADA_DEPOZITARNOJ_BANCITextBox" runat="server" Text='<%# Bind("NAKNADA_DEPOZITARNOJ_BANCI") %>' />
            <br />
            <label>NAKNADA_BANKA_FIKSNA:</label>
            <asp:TextBox ID="NAKNADA_BANKA_FIKSNATextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_FIKSNA") %>' />
            <br />
            <label>NAKNADA_BANKA_POSTO:</label>
            <asp:TextBox ID="NAKNADA_BANKA_POSTOTextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_POSTO") %>' />
            <br />
            <label>NAKNADA_BANKA_MINIMALNI:</label>
            <asp:TextBox ID="NAKNADA_BANKA_MINIMALNITextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_MINIMALNI") %>' />
            <br />
            <label>NAKNADA_BANKA_MAKSIMALNI:</label>
            <asp:TextBox ID="NAKNADA_BANKA_MAKSIMALNITextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_MAKSIMALNI") %>' />
            <br />
            <label>NAPOMENA_ZA_KUPNJU:</label>
            <asp:TextBox ID="NAPOMENA_ZA_KUPNJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_KUPNJU") %>' />
            <br />
            <label>NAPOMENA_ZA_PRODAJU:</label>
            <asp:TextBox ID="NAPOMENA_ZA_PRODAJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_PRODAJU") %>' />
            <br />
            <label>NAPOMENA_ZA_REGISTRACIJU:</label>
            <asp:TextBox ID="NAPOMENA_ZA_REGISTRACIJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_REGISTRACIJU") %>' />
            <br />
            <label>DODATNI_PODACI:</label>
            <asp:TextBox ID="DODATNI_PODACITextBox" runat="server" Text='<%# Bind("DODATNI_PODACI") %>' />
            <br />
            <label>VRIJEDI_OD:</label>
            <asp:TextBox ID="VRIJEDI_ODTextBox" runat="server" Text='<%# Bind("VRIJEDI_OD") %>' />
            <br />
            <label>VRIJEDI_DO:</label>
            <asp:TextBox ID="VRIJEDI_DOTextBox" runat="server" Text='<%# Bind("VRIJEDI_DO") %>' />
            <br />
            <label>NAZIV:</label>
            <asp:TextBox ID="NAZIVTextBox" runat="server" Text='<%# Bind("NAZIV") %>' />
            <br />
            <label>NAPOMENA_ZA_ODREGISTRACIJU:</label>
            <asp:TextBox ID="NAPOMENA_ZA_ODREGISTRACIJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_ODREGISTRACIJU") %>' />
            <br />
            <label>ZAHTJEV_REPORT_ID:</label>
            <asp:TextBox ID="ZAHTJEV_REPORT_IDTextBox" runat="server" Text='<%# Bind("ZAHTJEV_REPORT_ID") %>' />
            <br />
            <label>NALOG_PRIMATELJ_VBDI:</label>
            <asp:TextBox ID="NALOG_PRIMATELJ_VBDITextBox" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_VBDI") %>' />
            <br />
            <label>NALOG_PRIMATELJ_RACUN:</label>
            <asp:TextBox ID="NALOG_PRIMATELJ_RACUNTextBox" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_RACUN") %>' />
            <br />
            <label>NALOG_PBO_MODEL:</label>
            <asp:TextBox ID="NALOG_PBO_MODELTextBox" runat="server" Text='<%# Bind("NALOG_PBO_MODEL") %>' />
            <br />
            <label>NALOG_PBO:</label>
            <asp:TextBox ID="NALOG_PBOTextBox" runat="server" Text='<%# Bind("NALOG_PBO") %>' />
            <br />
            <label>NALOG_OPIS_PLACANJA:</label>
            <asp:TextBox ID="NALOG_OPIS_PLACANJATextBox" runat="server" Text='<%# Bind("NALOG_OPIS_PLACANJA") %>' />
            <br />

            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
            &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </EditItemTemplate>
        <InsertItemTemplate>
            ID:
            <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
            <br />
            KATEGORIJA_ID:
            <asp:TextBox ID="KATEGORIJA_IDTextBox" runat="server" Text='<%# Bind("KATEGORIJA_ID") %>' />
            <br />
            GEO_ID:
            <asp:TextBox ID="GEO_IDTextBox" runat="server" Text='<%# Bind("GEO_ID") %>' />
            <br />
            TIP_ULAGANJA_ID:
            <asp:TextBox ID="TIP_ULAGANJA_IDTextBox" runat="server" Text='<%# Bind("TIP_ULAGANJA_ID") %>' />
            <br />
            TIP_UPRAVLJANJA_ID:
            <asp:TextBox ID="TIP_UPRAVLJANJA_IDTextBox" runat="server" Text='<%# Bind("TIP_UPRAVLJANJA_ID") %>' />
            <br />
            DRUSTVA_ID:
            <asp:TextBox ID="DRUSTVA_IDTextBox" runat="server" Text='<%# Bind("DRUSTVA_ID") %>' />
            <br />
            RIZICNOST:
            <asp:TextBox ID="RIZICNOSTTextBox" runat="server" Text='<%# Bind("RIZICNOST") %>' />
            <br />
            MINIMALNA_POCETNA_UPLATA:
            <asp:TextBox ID="MINIMALNA_POCETNA_UPLATATextBox" runat="server" Text='<%# Bind("MINIMALNA_POCETNA_UPLATA") %>' />
            <br />
            MINIMALNE_OSTALE_UPLATE:
            <asp:TextBox ID="MINIMALNE_OSTALE_UPLATETextBox" runat="server" Text='<%# Bind("MINIMALNE_OSTALE_UPLATE") %>' />
            <br />
            VALUTA_SIFRA:
            <asp:TextBox ID="VALUTA_SIFRATextBox" runat="server" Text='<%# Bind("VALUTA_SIFRA") %>' />
            <br />
            POCETNA_CIJENA_UDJELA:
            <asp:TextBox ID="POCETNA_CIJENA_UDJELATextBox" runat="server" Text='<%# Bind("POCETNA_CIJENA_UDJELA") %>' />
            <br />
            DATUM_OSNIVANJA:
            <asp:TextBox ID="DATUM_OSNIVANJATextBox" runat="server" Text='<%# Bind("DATUM_OSNIVANJA") %>' />
            <br />
            IMOVINA_FONDA:
            <asp:TextBox ID="IMOVINA_FONDATextBox" runat="server" Text='<%# Bind("IMOVINA_FONDA") %>' />
            <br />
            NAKNADA_ULAZNA:
            <asp:TextBox ID="NAKNADA_ULAZNATextBox" runat="server" Text='<%# Bind("NAKNADA_ULAZNA") %>' />
            <br />
            NAKNADA_IZLAZNA:
            <asp:TextBox ID="NAKNADA_IZLAZNATextBox" runat="server" Text='<%# Bind("NAKNADA_IZLAZNA") %>' />
            <br />
            NAKNADA_ZA_UPRAVLJANJEM_FONDA:
            <asp:TextBox ID="NAKNADA_ZA_UPRAVLJANJEM_FONDATextBox" runat="server" Text='<%# Bind("NAKNADA_ZA_UPRAVLJANJEM_FONDA") %>' />
            <br />
            NAKNADA_DEPOZITARNOJ_BANCI:
            <asp:TextBox ID="NAKNADA_DEPOZITARNOJ_BANCITextBox" runat="server" Text='<%# Bind("NAKNADA_DEPOZITARNOJ_BANCI") %>' />
            <br />
            NAKNADA_BANKA_FIKSNA:
            <asp:TextBox ID="NAKNADA_BANKA_FIKSNATextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_FIKSNA") %>' />
            <br />
            NAKNADA_BANKA_POSTO:
            <asp:TextBox ID="NAKNADA_BANKA_POSTOTextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_POSTO") %>' />
            <br />
            NAKNADA_BANKA_MINIMALNI:
            <asp:TextBox ID="NAKNADA_BANKA_MINIMALNITextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_MINIMALNI") %>' />
            <br />
            NAKNADA_BANKA_MAKSIMALNI:
            <asp:TextBox ID="NAKNADA_BANKA_MAKSIMALNITextBox" runat="server" Text='<%# Bind("NAKNADA_BANKA_MAKSIMALNI") %>' />
            <br />
            NAPOMENA_ZA_KUPNJU:
            <asp:TextBox ID="NAPOMENA_ZA_KUPNJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_KUPNJU") %>' />
            <br />
            NAPOMENA_ZA_PRODAJU:
            <asp:TextBox ID="NAPOMENA_ZA_PRODAJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_PRODAJU") %>' />
            <br />
            NAPOMENA_ZA_REGISTRACIJU:
            <asp:TextBox ID="NAPOMENA_ZA_REGISTRACIJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_REGISTRACIJU") %>' />
            <br />
            DODATNI_PODACI:
            <asp:TextBox ID="DODATNI_PODACITextBox" runat="server" Text='<%# Bind("DODATNI_PODACI") %>' />
            <br />
            VRIJEDI_OD:
            <asp:TextBox ID="VRIJEDI_ODTextBox" runat="server" Text='<%# Bind("VRIJEDI_OD") %>' />
            <br />
            VRIJEDI_DO:
            <asp:TextBox ID="VRIJEDI_DOTextBox" runat="server" Text='<%# Bind("VRIJEDI_DO") %>' />
            <br />
            NAZIV:
            <asp:TextBox ID="NAZIVTextBox" runat="server" Text='<%# Bind("NAZIV") %>' />
            <br />
            NAPOMENA_ZA_ODREGISTRACIJU:
            <asp:TextBox ID="NAPOMENA_ZA_ODREGISTRACIJUTextBox" runat="server" Text='<%# Bind("NAPOMENA_ZA_ODREGISTRACIJU") %>' />
            <br />
            ZAHTJEV_REPORT_ID:
            <asp:TextBox ID="ZAHTJEV_REPORT_IDTextBox" runat="server" Text='<%# Bind("ZAHTJEV_REPORT_ID") %>' />
            <br />
            NALOG_PRIMATELJ_VBDI:
            <asp:TextBox ID="NALOG_PRIMATELJ_VBDITextBox" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_VBDI") %>' />
            <br />
            NALOG_PRIMATELJ_RACUN:
            <asp:TextBox ID="NALOG_PRIMATELJ_RACUNTextBox" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_RACUN") %>' />
            <br />
            NALOG_PBO_MODEL:
            <asp:TextBox ID="NALOG_PBO_MODELTextBox" runat="server" Text='<%# Bind("NALOG_PBO_MODEL") %>' />
            <br />
            NALOG_PBO:
            <asp:TextBox ID="NALOG_PBOTextBox" runat="server" Text='<%# Bind("NALOG_PBO") %>' />
            <br />
            NALOG_OPIS_PLACANJA:
            <asp:TextBox ID="NALOG_OPIS_PLACANJATextBox" runat="server" Text='<%# Bind("NALOG_OPIS_PLACANJA") %>' />
            <br />
            Drustvo:
            <asp:TextBox ID="DrustvoTextBox" runat="server" Text='<%# Bind("Drustvo") %>' />
            <br />
            FOND_GEO:
            <asp:TextBox ID="FOND_GEOTextBox" runat="server" Text='<%# Bind("FOND_GEO") %>' />
            <br />
            Kategorija:
            <asp:TextBox ID="KategorijaTextBox" runat="server" Text='<%# Bind("Kategorija") %>' />
            <br />
            FOND_TIP_ULAGANJA:
            <asp:TextBox ID="FOND_TIP_ULAGANJATextBox" runat="server" Text='<%# Bind("FOND_TIP_ULAGANJA") %>' />
            <br />
            FOND_TIP_UPRAVLJANJA:
            <asp:TextBox ID="FOND_TIP_UPRAVLJANJATextBox" runat="server" Text='<%# Bind("FOND_TIP_UPRAVLJANJA") %>' />
            <br />
            FOND_PROMETI:
            <asp:TextBox ID="FOND_PROMETITextBox" runat="server" Text='<%# Bind("FOND_PROMETI") %>' />
            <br />
            FOND_VRIJEDNOST_UDJELA:
            <asp:TextBox ID="FOND_VRIJEDNOST_UDJELATextBox" runat="server" Text='<%# Bind("FOND_VRIJEDNOST_UDJELA") %>' />
            <br />
            FOND_ZAHTJEVI:
            <asp:TextBox ID="FOND_ZAHTJEVITextBox" runat="server" Text='<%# Bind("FOND_ZAHTJEVI") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        <ItemTemplate>
            
            <div class="readonly">

                <h3 class="form_group">OSNOVNE INFORMACIJE FONDA</h3>

                <div class="form_item">
                    <label class="form_item_label">naziv:</label>
                    <asp:Label ID="NAZIVLabel" runat="server" Text='<%# Bind("NAZIV") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">društvo:</label>
                    <asp:Label ID="DRUSTVA_IDLabel" runat="server" Text='<%# Bind("DRUSTVO_NAZIV") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">kategorija:</label>
                    <asp:Label ID="KATEGORIJA_IDLabel" runat="server" Text='<%# Bind("KATEGORIJA_NAZIV") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">regija:</label>
                    <asp:Label ID="GEO_IDLabel" runat="server" Text='<%# Bind("REGIJA_NAZIV") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">ulaganje:</label>
                    <asp:Label ID="TIP_ULAGANJA_IDLabel" runat="server" Text='<%# Bind("ULAGANJE_NAZIV") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">upravljanje:</label>
                    <asp:Label ID="TIP_UPRAVLJANJA_IDLabel" runat="server" Text='<%# Bind("UPRAVLJANJE_NAZIV") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">rizičnost:</label>
                    <asp:Label ID="RIZICNOSTLabel" runat="server" Text='<%# Bind("RIZICNOST_NAZIV") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">valuta:</label>
                    <asp:Label ID="VALUTA_SIFRALabel" runat="server" Text='<%# Bind("VALUTA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">minimalna početna uplata:</label>
                    <asp:Label ID="MINIMALNA_POCETNA_UPLATALabel" runat="server" Text='<%# Bind("MINIMALNA_POCETNA_UPLATA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">minimalne ostale uplate:</label>
                    <asp:Label ID="MINIMALNE_OSTALE_UPLATELabel" runat="server" Text='<%# Bind("MINIMALNE_OSTALE_UPLATE") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">početna cijena udjela:</label>
                    <asp:Label ID="POCETNA_CIJENA_UDJELALabel" runat="server" Text='<%# Bind("POCETNA_CIJENA_UDJELA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">trenutna imovina fonda:</label>
                    <asp:Label ID="IMOVINA_FONDALabel" runat="server" Text='<%# Bind("IMOVINA_FONDA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">datum osnivanja:</label>
                    <asp:Label ID="DATUM_OSNIVANJALabel" runat="server" Text='<%# Bind("DATUM_OSNIVANJA", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value" />
                </div>

                <h3 class="form_group">NALOG</h3>

                <div class="form_item">
                    <label class="form_item_label">Broj računa:</label>
                    <asp:Label ID="NALOG_PRIMATELJ_VBDILabel" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_VBDI") %>' CssClass="form_item_value" />&nbsp;
            <asp:Label ID="NALOG_PRIMATELJ_RACUNLabel" runat="server" Text='<%# Bind("NALOG_PRIMATELJ_RACUN") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">Poziv na broj:</label>
                    <asp:Label ID="NALOG_PBO_MODELLabel" runat="server" Text='<%# Bind("NALOG_PBO_MODEL") %>' CssClass="form_item_value" />&nbsp;
            <asp:Label ID="NALOG_PBOLabel" runat="server" Text='<%# Bind("NALOG_PBO") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">opis plaćanja:</label>
                    <asp:Label ID="NALOG_OPIS_PLACANJALabel" runat="server" Text='<%# Bind("NALOG_OPIS_PLACANJA") %>' CssClass="form_item_value" />
                </div>

                <h3 class="form_group">NAKNADE DRUŠTVA</h3>

                <div class="form_item">
                    <label class="form_item_label">ulazna naknada:</label>
                    <asp:Label ID="NAKNADA_ULAZNALabel" runat="server" Text='<%# Bind("NAKNADA_ULAZNA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">izlazna naknada:</label>
                    <asp:Label ID="NAKNADA_IZLAZNALabel" runat="server" Text='<%# Bind("NAKNADA_IZLAZNA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">naknada za upravljanjem fonda:</label>
                    <asp:Label ID="NAKNADA_ZA_UPRAVLJANJEM_FONDALabel" runat="server" Text='<%# Bind("NAKNADA_ZA_UPRAVLJANJEM_FONDA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">naknada depozitarnoj banci:</label>
                    <asp:Label ID="NAKNADA_DEPOZITARNOJ_BANCILabel" runat="server" Text='<%# Bind("NAKNADA_DEPOZITARNOJ_BANCI") %>' CssClass="form_item_value" />
                </div>

                <h3 class="form_group">NAKNADE BANKE</h3>

                <div class="form_item">
                    <label class="form_item_label">naknada banke fiksna:</label>
                    <asp:Label ID="NAKNADA_BANKA_FIKSNALabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_FIKSNA") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">naknada banke posto:</label>
                    <asp:Label ID="NAKNADA_BANKA_POSTOLabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_POSTO") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">naknada banke minimalni:</label>
                    <asp:Label ID="NAKNADA_BANKA_MINIMALNILabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_MINIMALNI") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">naknada banke maksimalni:</label>
                    <asp:Label ID="NAKNADA_BANKA_MAKSIMALNILabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_MAKSIMALNI") %>' CssClass="form_item_value" />
                </div>

                <h3 class="form_group">NAPOMENE</h3>

                <div class="form_item">
                    <label class="form_item_label">napomena za kupnju:</label>
                    <asp:Label ID="NAPOMENA_ZA_KUPNJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_KUPNJU") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">napomena za prodaju:</label>
                    <asp:Label ID="NAPOMENA_ZA_PRODAJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_PRODAJU") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">napomena za registraciju:</label>
                    <asp:Label ID="NAPOMENA_ZA_REGISTRACIJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_REGISTRACIJU") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">napomena za odregistraciju:</label>
                    <asp:Label ID="NAPOMENA_ZA_ODREGISTRACIJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_ODREGISTRACIJU") %>' CssClass="form_item_value" />
                </div>

                <h3 class="form_group">DODATNI PODACI</h3>

                <div class="form_item">
                    <label class="form_item_label">dodatni podaci:</label>
                    <asp:Label ID="DODATNI_PODACILabel" runat="server" Text='<%# Bind("DODATNI_PODACI") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">vrijedi od:</label>
                    <asp:Label ID="VRIJEDI_ODLabel" runat="server" Text='<%# Bind("VRIJEDI_OD", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value" />
                </div>

                <div class="form_item">
                    <label class="form_item_label">vrijedi do:</label>
                    <asp:Label ID="VRIJEDI_DOLabel" runat="server" Text='<%# Bind("VRIJEDI_DO", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value" />
                </div>
            </div>
            
            <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible="False" />&nbsp;
            <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" Visible="False" />&nbsp;
            <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" Visible="False" />
        </ItemTemplate>
    </asp:FormView>

    <asp:Button ID="btnPovratak" runat="server" Text="Povratak" CssClass="btn_navigation" OnClick="btnPovratak_Click1" />


    <asp:EntityDataSource ID="EntityDataSource1" runat="server" ContextTypeName="InvestApp.DAL.FondEntities" ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="Fondovi" EntityTypeFilter="Fond" OnUpdated="EntityDataSource1_Updated" >
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="EntityDataSourceKategorije" runat="server" ContextTypeName="InvestApp.DAL.FondEntities" ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" EnableFlattening="False" EntitySetName="Kategorije" EntityTypeFilter="Kategorija">
    </asp:EntityDataSource>
    
</asp:Content>

