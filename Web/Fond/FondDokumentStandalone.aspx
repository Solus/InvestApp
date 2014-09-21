<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="FondDokumentStandalone.aspx.cs" Inherits="InvestApp.Web.FondDokumentStandalone" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxDataView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxFormLayout" TagPrefix="dx" %>
<%@ Register Src="~/Kontrole/FondPrinosiGrafCtrl.ascx" TagPrefix="uc1" TagName="FondPrinosiGrafCtrl" %>
<%@ Register Src="~/Kontrole/FondPrinosiTablicaCtrl.ascx" TagPrefix="uc1" TagName="FondPrinosiTablicaCtrl" %>
<%@ Register Src="~/Kontrole/FondStruktureUlaganjaCtrl.ascx" TagPrefix="uc1" TagName="FondStruktureUlaganjaCtrl" %>





<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <link href="~/Content/Site.css?v=2.31" rel="stylesheet" />

    <asp:PlaceHolder ID="PlaceHolder1" runat="server">

        <!--[if lt IE 9]>
            <script src="<%: ResolveUrl("~/Scripts/jquery-1.11.1.min.js") %>" ></script>
        <![endif]-->
        <!--[if (gte IE 9) | (!IE)]><!-->
            <script src="<%: ResolveUrl("~/Scripts/jquery-2.1.0.min.js") %>"></script>
        <!--<![endif]-->

    </asp:PlaceHolder>

    <script type="text/javascript">

        $(document).ready(function () {

            // Add the page method call as an onclick handler for the div.
            if (typeof parent.updateCartAjax === "function")
                $(".updateCart").click(parent.updateCartAjax);
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div id="body" class="standalone">

            <asp:Label ID="lblLog" runat="server"></asp:Label>

            <h1 id="formHeader" runat="server" class="form_header bar normal">Detalji fonda</h1>

            <div class="form_body">

                <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="EntityDataSource1" OnModeChanging="FormView1_ModeChanging" OnDataBound="FormView1_DataBound">
                    <EditItemTemplate>

                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </EditItemTemplate>
                    <InsertItemTemplate>

                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    <ItemTemplate>

                        <div class="readonly">

                            <div class="left">
                                <img id="drustvoLogo" runat="server" src='<%# Bind("DRUSTVO_LOGO_URL") %>' class="drustvo_logo" />
                            </div>

                            <div class="right align">
                                <asp:Button ID="btnKupi" runat="server" Text="Kupi" CssClass="btn_kupi" OnClick="btnKupi_Click" UseSubmitBehavior="False" />
                            </div>

                            <div class="clearfix"></div>

                            <div class="left">
                                <div class="form_item">
                                    <uc1:FondPrinosiGrafCtrl runat="server" ID="chartPrinosi" Width="430" Height="260" Naslov="Prinos u zadnjih godinu dana" PrikaziIndeksni="true" />
                                </div>
                            </div>

                            <div class="right">
                                <div class="form_item top">
                                    <uc1:FondPrinosiTablicaCtrl runat="server" ID="tablePrinosi" DetaljneLabele="true" />
                                </div>
                            </div>

                            <div class="clearfix"></div>

                            <div id="divOpis" class="form_item" runat="server">
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("OPIS") %>' CssClass="form_item_value text" />
                            </div>

                            <h3 class="form_group">DOKUMENTI FONDA</h3>

                            <div class="left">

                                <div class="form_item">
                                    <asp:HyperLink ID="HyperLink1" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Bind("KIID_URL") %>'>Ključne informacije za ulagatelje</asp:HyperLink>
                                </div>
                                <div class="form_item">
                                    <asp:HyperLink ID="HyperLink2" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Bind("PRAVILA_URL") %>'>Pravila fonda</asp:HyperLink>
                                </div>
                            </div>

                            <div class="right">
                                <div class="form_item">
                                    <asp:HyperLink ID="HyperLink3" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Bind("PROSPEKT_URL") %>'>Prospekt fonda</asp:HyperLink>
                                </div>
                                <div class="form_item">
                                    <asp:HyperLink ID="HyperLink4" CssClass="form_item_link" runat="server" Target="_blank" NavigateUrl='<%# Bind("OSOBNA_ISKAZNICA_URL") %>'>Mjesečno izvješće</asp:HyperLink>
                                </div>

                            </div>

                            <div class="clearfix"></div>

                            <h3 class="form_group">OSNOVNE INFORMACIJE</h3>

                            <div class="left">

                                <div class="form_item">
                                    <label class="form_item_label">Naziv:</label>
                                    <asp:Label ID="NAZIVLabel" runat="server" Text='<%# Bind("NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Društvo:</label>
                                    <asp:Label ID="DRUSTVA_IDLabel" runat="server" Text='<%# Bind("DRUSTVO_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Kategorija:</label>
                                    <asp:Label ID="KATEGORIJA_IDLabel" runat="server" Text='<%# Bind("KATEGORIJA_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Geografska regija:</label>
                                    <asp:Label ID="GEO_IDLabel" runat="server" Text='<%# Bind("REGIJA_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Ulaganje:</label>
                                    <asp:Label ID="TIP_ULAGANJA_IDLabel" runat="server" Text='<%# Bind("ULAGANJE_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Upravljanje:</label>
                                    <asp:Label ID="TIP_UPRAVLJANJA_IDLabel" runat="server" Text='<%# Bind("UPRAVLJANJE_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <%--<div class="form_item">
                                    <label class="form_item_label">Rizičnost:</label>
                                    <asp:Label ID="RIZICNOSTLabel" runat="server" Text='<%# Bind("RIZICNOST_NAZIV") %>' CssClass="form_item_value" />
                                </div>--%>

                                <div class="form_item">
                                    <label class="form_item_label">Valuta:</label>
                                    <asp:Label ID="VALUTA_SIFRALabel" runat="server" Text='<%# Bind("VALUTA") %>' CssClass="form_item_value" />
                                </div>

                            </div>

                            <div class="right">

                                <div class="form_item">
                                    <label class="form_item_label">Cilj prinosa:</label>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("CILJ_PRINOSA_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Sektor:</label>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("SEKTOR_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Tržište:</label>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("TRZISTE_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Profil rizičnosti i uspješnosti:</label>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("PROFIL_RIZICNOSTI_NAZIV") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Trenutna imovina fonda:</label>
                                    <asp:Label ID="IMOVINA_FONDALabel" runat="server" Text='<%# Eval("IMOVINA_FONDA", "{0:n2}") + " " + Eval("VALUTA") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Datum početka rada:</label>
                                    <asp:Label ID="DATUM_OSNIVANJALabel" runat="server" Text='<%# Bind("DATUM_OSNIVANJA", "{0:dd.MM.yyyy}") %>' CssClass="form_item_value" />
                                </div>

                            </div>

                            <div class="clearfix"></div>

                            <%--<h3 class="form_group">NALOG</h3>

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
                        </div>--%>

                            <h3 class="form_group">TROŠKOVI FONDA</h3>

                            <div class="form_item wide">
                                <label class="form_item_label">Ulazna naknada:</label>
                                <asp:Label ID="NAKNADA_ULAZNALabel" runat="server" Text='<%# Bind("NAKNADA_ULAZNA") %>' CssClass="form_item_value" />
                            </div>

                            <div class="form_item wide">
                                <label class="form_item_label">Izlazna naknada:</label>
                                <asp:Label ID="NAKNADA_IZLAZNALabel" runat="server" Text='<%# Bind("NAKNADA_IZLAZNA") %>' CssClass="form_item_value" />
                            </div>

                            <div class="form_item wide">
                                <label class="form_item_label">Naknada za upravljanjem fonda:</label>
                                <asp:Label ID="NAKNADA_ZA_UPRAVLJANJEM_FONDALabel" runat="server" Text='<%# Bind("NAKNADA_ZA_UPRAVLJANJEM_FONDA") %>' CssClass="form_item_value" />
                            </div>

                            <div class="form_item wide">
                                <label class="form_item_label">Naknada depozitarnoj banci:</label>
                                <asp:Label ID="NAKNADA_DEPOZITARNOJ_BANCILabel" runat="server" Text='<%# Bind("NAKNADA_DEPOZITARNOJ_BANCI") %>' CssClass="form_item_value" />
                            </div>

                            <div class="form_item wide">
                                <label class="form_item_label">Pokazatelj ukupnih troškova fonda:</label>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("POKAZATELJ_UKUPNIH_TROSKOVA") %>' CssClass="form_item_value" />
                            </div>

                            <h3 class="form_group">PORTFELJ FONDA</h3>

                            <div class="form_item">
                                <uc1:FondStruktureUlaganjaCtrl runat="server" ID="struktUlaganjaTop10" Tip="Top10" />
                                <uc1:FondStruktureUlaganjaCtrl runat="server" ID="struktUlaganjaSek" Tip="SektorskaIzlozenost" />
                                <uc1:FondStruktureUlaganjaCtrl runat="server" ID="struktUlaganjaGeo" Tip="GeografskaIzlozenost" />
                                <uc1:FondStruktureUlaganjaCtrl runat="server" ID="struktUlaganjaVal" Tip="ValutnaIzlozenost" />
                            </div>

                            <%--<h3 class="form_group">NAKNADE BANKE</h3>

                        <div class="form_item wide">
                            <label class="form_item_label">naknada banke fiksna:</label>
                            <asp:Label ID="NAKNADA_BANKA_FIKSNALabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_FIKSNA") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item wide">
                            <label class="form_item_label">naknada banke posto:</label>
                            <asp:Label ID="NAKNADA_BANKA_POSTOLabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_POSTO") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item wide">
                            <label class="form_item_label">naknada banke minimalni:</label>
                            <asp:Label ID="NAKNADA_BANKA_MINIMALNILabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_MINIMALNI") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item wide">
                            <label class="form_item_label">naknada banke maksimalni:</label>
                            <asp:Label ID="NAKNADA_BANKA_MAKSIMALNILabel" runat="server" Text='<%# Bind("NAKNADA_BANKA_MAKSIMALNI") %>' CssClass="form_item_value" />
                        </div>--%>

                            <%--<h3 class="form_group">NAPOMENE</h3>

                        <div class="form_item wide">
                            <label class="form_item_label">napomena za kupnju:</label>
                            <asp:Label ID="NAPOMENA_ZA_KUPNJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_KUPNJU") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item wide">
                            <label class="form_item_label">napomena za prodaju:</label>
                            <asp:Label ID="NAPOMENA_ZA_PRODAJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_PRODAJU") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item wide">
                            <label class="form_item_label">napomena za registraciju:</label>
                            <asp:Label ID="NAPOMENA_ZA_REGISTRACIJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_REGISTRACIJU") %>' CssClass="form_item_value" />
                        </div>

                        <div class="form_item wide">
                            <label class="form_item_label">napomena za odregistraciju:</label>
                            <asp:Label ID="NAPOMENA_ZA_ODREGISTRACIJULabel" runat="server" Text='<%# Bind("NAPOMENA_ZA_ODREGISTRACIJU") %>' CssClass="form_item_value" />
                        </div>--%>

                            <div id="divDodatniPodaci" runat="server">
                                <h3 class="form_group">DODATNI PODACI</h3>

                                <div class="form_item">
                                    <label class="form_item_label">Minimalna početna uplata:</label>
                                    <asp:Label ID="MINIMALNA_POCETNA_UPLATALabel" runat="server" Text='<%# Eval("MINIMALNA_POCETNA_UPLATA", "{0:n2}") + " " + Eval("VALUTA") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Minimalne ostale uplate:</label>
                                    <asp:Label ID="MINIMALNE_OSTALE_UPLATELabel" runat="server" Text='<%# Eval("MINIMALNE_OSTALE_UPLATE", "{0:n2}") + " " + Eval("VALUTA") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <label class="form_item_label">Početna cijena udjela:</label>
                                    <asp:Label ID="POCETNA_CIJENA_UDJELALabel" runat="server" Text='<%# Eval("POCETNA_CIJENA_UDJELA", "{0:n4}") + " " + Eval("VALUTA") %>' CssClass="form_item_value" />
                                </div>

                                <div class="form_item">
                                    <asp:Label ID="DODATNI_PODACILabel" runat="server" Text='<%# Bind("DODATNI_PODACI") %>' CssClass="form_item_value text" />
                                </div>
                            </div>

                            <h3 class="form_group">SLIČNI FONDOVI - USPOREDBA</h3>

                            <asp:Repeater ID="fondoviSlicniRepeater" runat="server" DataSource='<%# Bind("SlicniFondovi") %>' OnItemDataBound="fondoviSlicniRepeater_ItemDataBound">
                                <HeaderTemplate>
                                    <ul class="fondovi_slicni">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li>
                                        <a id="btnSlicanUsporedba" class='updateCart' href='javascript:void(0)' runat="server" data-id='<%# Eval("ID") %>' title="Usporedba" >Dodaj</a>
                                        <span class="fond_naziv"><%# Eval("NAZIV") %></span>
                                    </li>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>

                        </div>

                        <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" Visible="False" />&nbsp;
            <asp:Button ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" Visible="False" />&nbsp;
            <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New" Text="New" Visible="False" />
                    </ItemTemplate>
                </asp:FormView>

                <div class="btn_navigation_group left_buttons" id="btnGrupa" runat="server">
                    <%--<asp:Button ID="btnDodajUsporedba" CssClass="btn_navigation" runat="server" CausesValidation="False" CommandName="Edit" Text="Dodaj u usporedbu" OnClick="btnDodajUsporedba_Click" />--%>
                    <%--<a id="btnUsporedba" class='updateCart bigger' href='javascript:void(0)' runat="server">usporedi</a>--%>
                    <asp:Button id="btnUsporedi" CssClass='btn_kupi usporedi' runat="server" UseSubmitBehavior="false" Text="Usporedi" />
                </div>
            </div>

        </div>


        <asp:EntityDataSource ID="EntityDataSource1" runat="server" 
            ContextTypeName="InvestApp.DAL.FondEntities" 
            ConnectionString="name=FondEntities" 
            DefaultContainerName="FondEntities" 
            EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" 
            EntitySetName="Fondovi" 
            EntityTypeFilter="Fond" 
            OnUpdated="EntityDataSource1_Updated" OnSelecting="EntityDataSource1_Selecting">
        </asp:EntityDataSource>

        <asp:EntityDataSource ID="EntityDataSourceKategorije" runat="server" 
            ContextTypeName="InvestApp.DAL.FondEntities" 
            ConnectionString="name=FondEntities" 
            DefaultContainerName="FondEntities" 
            EnableFlattening="False" 
            EntitySetName="Kategorije" 
            EntityTypeFilter="Kategorija">
        </asp:EntityDataSource>

    </form>
</body>
</html>
