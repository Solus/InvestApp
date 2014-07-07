<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FondPregledCtrl.ascx.cs" Inherits="InvestApp.Web.FondPregledCtrl" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxNavBar" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<script type="text/javascript">

    var naprednaPretraga = false;

    function ToggleNaprednaPretraga(checked) {

        //if (checked)
        //    $('#divNapredniUvjeti').slideDown();
        //else
        //    $('#divNapredniUvjeti').slideUp();

        $('#divNapredniUvjeti').toggle();

        naprednaPretraga = $('#divNapredniUvjeti').is(":visible");

        $('.search_list a[href^=javascript]').toggleClass("opened", naprednaPretraga);
    }

    function setRadioButtonCheckedClass() {

        $('.search_list_extra input[type=radio]').removeClass('checked');
        $('.search_list_extra input[type=radio]:checked').addClass('checked');
    }

        function NaprednaPretragaPrikaz() {

            $('#divNapredniUvjeti').toggle(naprednaPretraga);
            $('.search_list a[href^=javascript]').toggleClass("opened", naprednaPretraga);
            //$('#cbNaprednoToggle').prop('checked', naprednaPretraga);
        }

        function initAjax() {

            $(document).ready(function () {

                // Add the page method call as an onclick handler for the div.
                $(".updateCart").click(updateCartAjax);
                $(".blacklist").click(toggleBlacklistAjax);

                usporedbaTooltipovi();
                blacklistTooltipovi();

                $('.search_list_extra > input[type=radio]:first-child').addClass('first_child');

                setRadioButtonCheckedClass();

                $(".search_list_extra input[type=radio] + label").click(function (event) {
                    var id = $(this).attr('for');
                    $('#' + id).click();

                    setRadioButtonCheckedClass();
                });

                var links = $('a.thickbox');

                $.each(links, function (key, value) {
                    
                    var href = $(value).attr('href');
                    if (href.indexOf('height') < 0) {

                        var height = screen.height / 1.5;

                        $(value).attr('href', href + '&height=' + height);
                    }
                });

            });

        }

        function usporedbaTooltipovi() {

            $(".updateCart").attr('title', 'Dodaj u usporedbu');
            $(".updateCart.remove").attr('title', 'Ukloni iz usporedbe');
            $(".updateCart.disabled").attr('title', 'Ne može se dodati više fondova u usporedbu');
        }

        function blacklistTooltipovi() {

            $(".blacklist").attr('title', 'Sakrij fond');
            $(".blacklist.blacklisted").attr('title', 'Prikaži fond');
        }

        function updateCartAjax(event) {

            var origBtn = $(this);
            var dataID = $(origBtn).attr("data-id");

            $.ajax({
                type: "POST",
                url: "../Fond/FondPregled.aspx/UpdateCart",
                data: "{'ID': '" + dataID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    console.log(msg);

                    var usporedbaLink = $('a[href="/FondUsporedba/FondUsporedba.aspx"]');//$('#usporedbaBroj');

                    if (msg.d.Count > 0)
                        $(usporedbaLink).text('Usporedba (' + msg.d.Count + ')');
                    else
                        $(usporedbaLink).text('Usporedba');

                    if (msg.d.Success) {

                        //animiranje linka za usporedbu
                        $(usporedbaLink).stop(true, true).switchClass("", "text_highlight", 100, function () { $(usporedbaLink).switchClass("text_highlight", "", 1000); });

                        var otherBtn = $('.updateCart[data-id=' + dataID + ']').not(origBtn);

                        var delay = 200;

                        if (msg.d.Removed) { //gumb sad dodaje

                            //$(origBtn).fadeOut(delay, function () {
                            //    $(origBtn).text('Dodaj').removeClass('remove').fadeIn(delay);
                            //});

                            $(origBtn).removeClass('remove');

                            if (otherBtn)
                                $(otherBtn).removeClass('remove');
                        }
                        else { //gumb sad uklanja

                            //$(origBtn).fadeOut(delay, function () {
                            //    $(origBtn).text('Ukloni').addClass('remove').fadeIn(delay);
                            //});

                            $(origBtn).addClass('remove')

                            if (otherBtn)
                                $(otherBtn).addClass('remove');
                        }

                        //ako se ne može više dodavati, označi gumbe drugačije
                        if (msg.d.IsFull) {
                            $(".updateCart:not([class*=remove])").not(origBtn).addClass("disabled");

                            $('#TB_iframeContent').contents().find(".updateCart:not([class*=remove])").not(origBtn).addClass("disabled"); //unutar framea
                        }
                        else {
                            $(".updateCart").removeClass("disabled");

                            $('#TB_iframeContent').contents().find(".updateCart").removeClass("disabled"); //unutar framea
                        }

                        usporedbaTooltipovi();

                    }
                }
            });
        }

        function toggleBlacklistAjax(event) {

            var origBtn = $(this);
            var dataID = $(origBtn).attr("data-id");

            $.ajax({
                type: "POST",
                url: "../Fond/FondPregled.aspx/BlacklistToggle",
                data: "{'ID': '" + dataID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    console.log(msg);

                    if (msg.d) {
                        $(origBtn).toggleClass('blacklisted');

                        blacklistTooltipovi();
                    }
                }
            });
        }

</script>

<asp:UpdatePanel ID="FondUpdatePanel" runat="server" UpdateMode="Conditional">
    <ContentTemplate>

        <script type="text/javascript">
            Sys.Application.add_load(initAjax);

            function pageLoad() {
                var isAsyncPostback = Sys.WebForms.PageRequestManager.getInstance().get_isInAsyncPostBack();
                if (isAsyncPostback) {
                    tb_init('a.thickbox, area.thickbox, input.thickbox');

                    initAjax();
                    NaprednaPretragaPrikaz();
                }


            }
        </script>

        <div class="search_body">

            <asp:Menu ID="menuKat" runat="server" CssClass="search_list items6" RenderingMode="List" IncludeStyleBlock="False" EnableViewState="true" OnMenuItemClick="menuKat_MenuItemClick" SkipLinkText="">
                <Items>
                    <asp:MenuItem Text="SVI" Value="NULL" Selected="True"></asp:MenuItem>
                    <asp:MenuItem Text="DIONIČKI" Value="4"></asp:MenuItem>
                    <asp:MenuItem Text="MJEŠOVITI" Value="3"></asp:MenuItem>
                    <asp:MenuItem Text="OBVEZNIČKI" Value="2"></asp:MenuItem>
                    <asp:MenuItem Text="NOVČANI" Value="1"></asp:MenuItem>
                    <asp:MenuItem Text="napredna pretraga" Value="" NavigateUrl="javascript: ToggleNaprednaPretraga(); " ></asp:MenuItem>
                </Items>
            </asp:Menu>

            <%--<asp:CheckBox ID="cbNaprednoToggle" ClientIDMode="Static" runat="server" CssClass="search_extra_toggle" Text="&nbsp;" AutoPostBack="false" ToolTip="Napredni uvjeti pretraživanja"
                onclick=" ToggleNaprednaPretraga(this.checked); " EnableViewState="true" ViewStateMode="Enabled" Checked="false" />--%>

            <div id="divNapredniUvjeti" class="search_extra_group" style="display: none;">



                <div class="search_extra">

                    <span class="search_extra_label">UPRAVLJANJE</span>

                    <asp:RadioButtonList ID="rblUpravljanje" runat="server" CssClass="search_list_extra" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="_Trazi">
                        <asp:ListItem Text="Sve" Value="NULL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Aktivno" Value="1" ></asp:ListItem>
                        <asp:ListItem Text="Pasivno" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>

                </div>

                <div class="search_extra">

                    <span class="search_extra_label">CILJ PRINOSA</span>

                    <asp:RadioButtonList ID="rblCiljPrinosa" runat="server" CssClass="search_list_extra" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="_Trazi">
                        <asp:ListItem Text="Svi" Value="NULL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Relativni" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Apsolutni" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>

                </div>

                <div class="search_extra">

                    <span class="search_extra_label">ULAGANJE</span>

                    <asp:RadioButtonList ID="rblUlaganje" runat="server" CssClass="search_list_extra" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="_Trazi">
                        <asp:ListItem Text="Sve" Value="NULL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Fond fondova" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Direktno ulaganje" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>

                </div>

                <div class="search_extra">

                    <span class="search_extra_label">GEOGRAFSKA REGIJA</span>

                    <asp:RadioButtonList ID="rblRegija" runat="server" CssClass="search_list_extra" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="_Trazi">
                        <asp:ListItem Text="Sve" Value="NULL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Globalni" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Europa" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Ist. Europa" Value="6" title="Istočna Europa"></asp:ListItem>
                        <asp:ListItem Text="JI Europa" Value="5" title="Jugoistočna Europa"></asp:ListItem>
                        <asp:ListItem Text="Hrvatska" Value="7"></asp:ListItem>
                        <asp:ListItem Text="Azija i Pacifik" Value="3"></asp:ListItem>
                        <asp:ListItem Text="Sjeverna Amerika" Value="4"></asp:ListItem>
                    </asp:RadioButtonList>

                </div>

                <div class="search_extra">

                    <span class="search_extra_label">SEKTOR</span>

                    <asp:RadioButtonList ID="rblTrziste" runat="server" CssClass="search_list_extra" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="_Trazi">
                        <asp:ListItem Text="Svi" Value="NULL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Svi sektori" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Energija i robe" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>

                </div>

                <div class="search_extra">

                    <span class="search_extra_label">TRŽIŠTE</span>

                    <asp:RadioButtonList ID="rblSektor" runat="server" CssClass="search_list_extra" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="_Trazi">
                        <asp:ListItem Text="Sva" Value="NULL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Razvijena tržišta" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Tržišta u nastajanju" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Granična tržišta" Value="3"></asp:ListItem>
                    </asp:RadioButtonList>

                </div>            

                <div class="search_extra">

                    <span class="search_extra_label">PROFIL RIZIČNOSTI I USPJEŠNOSTI</span>

                    <asp:RadioButtonList ID="rblProfilRizicnosti" runat="server" CssClass="search_list_extra small" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="_Trazi">
                        <asp:ListItem Text="Svi" Value="NULL" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="7" Value="7"></asp:ListItem>
                    </asp:RadioButtonList>

                </div>

            <asp:Button ID="btnTrazi" runat="server" Text="Traži" CssClass="btn_trazi" OnClick="btnTrazi_Click" Visible="False" />
            </div>

            <%--<dx:ASPxMenu ID="menuKategorije" runat="server" AllowSelectItem="True" AutoPostBack="True" EnableTheming="True" OnItemClick="ASPxMenu1_ItemClick" ItemSpacing="0px" >
                <Paddings Padding="0px" />
                <Items>
                    <dx:MenuItem Name="SVI" Selected="True" Text="Svi">
                    </dx:MenuItem>
                    <dx:MenuItem Name="DIONICKI" Text="Dionički">
                    </dx:MenuItem>
                    <dx:MenuItem Name="MJESOVITI" Text="Mješoviti">
                    </dx:MenuItem>
                    <dx:MenuItem Name="OBVEZNICKI" Text="Obveznički">
                    </dx:MenuItem>
                    <dx:MenuItem Name="NOVCANI" Text="Novčani">
                    </dx:MenuItem>
                </Items>
                            <ItemStyle BackColor="#DDDDDD" HorizontalAlign="Center" VerticalAlign="Middle">
                            <SelectedStyle BackColor="#777777" ForeColor="White">
                            </SelectedStyle>
                            <Paddings PaddingLeft="10px" PaddingRight="10px" PaddingBottom="4px" PaddingTop="4px" />
                            <Border BorderStyle="None" />
                            </ItemStyle>
                            <Border BorderStyle="None" />
            </dx:ASPxMenu>--%>



            <%--<dx:ASPxCheckBox ID="cbNapredniUvjeti" runat="server" Text="Napredno" Theme="MetropolisBlue" CheckState="Unchecked" AutoPostBack="false">
                <ClientSideEvents CheckedChanged="function(s, e) {
	                var checked = s.GetChecked();
                    panelNapredniUvjeti.SetVisible(checked);
                }" />
            </dx:ASPxCheckBox>--%>
        </div>

        <div class="data_container">

            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="FondUpdatePanel" DisplayAfter="200">
                <ProgressTemplate>
                    <div class="progress_message">Učitavanje...</div>
                </ProgressTemplate>
            </asp:UpdateProgress>

            <dx:ASPxGridView ID="gvFondovi" runat="server" AutoGenerateColumns="False" EnableTheming="True" KeyFieldName="ID"
                OnCustomButtonCallback="gvFondovi_CustomButtonCallback" OnCustomButtonInitialize="gvFondovi_CustomButtonInitialize" OnCustomColumnDisplayText="gvFondovi_CustomColumnDisplayText"
                OnCustomGroupDisplayText="gvFondovi_CustomGroupDisplayText" OnDataBinding="gvFondovi_DataBinding"
                SettingsPager-Mode="ShowAllRecords" CssClass="data_table" ClientInstanceName="grid" >
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" Visible="false" VisibleIndex="0">
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Naziv fonda" Name="FOND_NAZIV" ToolTip="" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>

                    <%--<dx:GridViewDataTextColumn Caption="Društvo za upravljanje" FieldName="NAZIV_VLASNIKA" VisibleIndex="2" Width="150px" ReadOnly="true" >
                        </dx:GridViewDataTextColumn>--%>

                    <dx:GridViewDataTextColumn FieldName="NAZIV_KATEGORIJE" Visible="false" VisibleIndex="3">
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Cijena udjela" FieldName="VRIJEDNOST" Name="VRIJEDNOST_UDJELA" ToolTip="Trenutna cijena udjela" VisibleIndex="4" Width="110px">
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                        <HeaderStyle HorizontalAlign="Right" />
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Valuta" FieldName="VALUTA" ReadOnly="True" ToolTip="Valuta fonda" VisibleIndex="5" Width="52px">
                        <HeaderStyle HorizontalAlign="Center" />
                        <CellStyle HorizontalAlign="Center"></CellStyle>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="Promjena[%]" FieldName="POSTOTAK" Name="POSTOTAK" ToolTip="Dnevna promjena cijene" VisibleIndex="6" Width="30px">
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <%--<dx:GridViewCommandColumn AllowDragDrop="False" ButtonType="Image" Name="CijeneDetalji" ToolTip="Detalji cijena udjela" VisibleIndex="7" Width="20px">
                            <CustomButtons>
                                <dx:GridViewCommandColumnCustomButton ID="cbCijeneDetalji" Text="Detalji cijena udjela">
                                    <Image Url="~/Images/chart-icon-16x16.gif" />
                                </dx:GridViewCommandColumnCustomButton>
                            </CustomButtons>
                            <HeaderStyle HorizontalAlign="Center" />
                        </dx:GridViewCommandColumn>--%>

                    <dx:GridViewDataTextColumn Caption="#" Name="CijeneDetalji" ToolTip="Detalji cijena udjela" VisibleIndex="7" Width="20px">
                        <HeaderStyle HorizontalAlign="Center" />
                    </dx:GridViewDataTextColumn>

                    <%--<dx:GridViewDataDateColumn Caption="Datum cijene" FieldName="VRIJEDNOST_DATUM" ToolTip="Datum zadnje promjene cijene" VisibleIndex="7" Width="80px">
                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy">
                            </PropertiesDateEdit>
                        </dx:GridViewDataDateColumn>--%>

                    <dx:GridViewDataTextColumn Caption="PTG[%]" FieldName="PTG" Name="PTG" ToolTip="Prinos u tekućoj godini [%]" VisibleIndex="8" Width="60px">
                        <HeaderStyle HorizontalAlign="Right" />
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="1mj[%]" FieldName="PRINOS_1M" Name="PRINOS_1M" ToolTip="Prinos u 1 mjesec [%]" VisibleIndex="10" Width="60px">
                        <HeaderStyle HorizontalAlign="Center" />
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="3mj[%]" FieldName="PRINOS_3M" Name="PRINOS_3M" ToolTip="Prinos u 3 mjeseca [%]" VisibleIndex="11" Width="60px">
                        <HeaderStyle HorizontalAlign="Center" />
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="1g[%]" FieldName="PRINOS_1G" Name="PRINOS_1G" ToolTip="Prinos u 1 godinu [%]" VisibleIndex="12" Width="60px">
                        <HeaderStyle HorizontalAlign="Center" />
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="3g[%]" FieldName="PRINOS_3G" Name="PRINOS_3G" ToolTip="Prinos u 3 godine [%]" VisibleIndex="13" Width="60px">
                        <HeaderStyle HorizontalAlign="Center" />
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn Caption="PGP[%]" FieldName="PGP" Name="PGP" ToolTip="Prosječni godišnji prinos [%]" VisibleIndex="14" Width="70px">
                        <PropertiesTextEdit DisplayFormatString="{0:n}">
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn FieldName="KATEGORIJA_ID" VisibleIndex="99">
                    </dx:GridViewDataTextColumn>

                    <%--<dx:GridViewCommandColumn Caption="#" Name="FOND_USPOREDI" VisibleIndex="11" Width="25px">
                            <CustomButtons>
                                <dx:GridViewCommandColumnCustomButton ID="cbUsporedi" Text="Usporedi">
                                </dx:GridViewCommandColumnCustomButton>
                            </CustomButtons>
                            <HeaderStyle HorizontalAlign="Center" />
                            <CellStyle HorizontalAlign="Left">
                            </CellStyle>
                        </dx:GridViewCommandColumn>--%>

                    <dx:GridViewDataTextColumn Caption="Usporedi" Name="FOND_USPOREDI2" ToolTip="Odaberite fondove za usporedbu" VisibleIndex="15" Width="20px" HeaderStyle-HorizontalAlign="Center">
                        <HeaderStyle HorizontalAlign="Center" />
                        <CellStyle HorizontalAlign="Center"></CellStyle>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewCommandColumn ButtonType="Image" Caption="Kupi" Name="FOND_KUPI" VisibleIndex="16" Width="25px" HeaderStyle-HorizontalAlign="Center" ToolTip="Kupi">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="cbKupi" Text="Kupi">
                                <Image Url="~/Images/kupi.png" ToolTip="Kupi"></Image>
                            </dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>
                        <HeaderStyle HorizontalAlign="Center" />
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    </dx:GridViewCommandColumn>

                    <dx:GridViewCommandColumn Caption="#" Name="FavoritOznaka" ButtonType="Image" ToolTip="Favorit" VisibleIndex="17" Width="25px">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="btnFavorit" Text="Favorit"></dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>
                    </dx:GridViewCommandColumn>

                    <dx:GridViewDataTextColumn FieldName="FAVORIT" VisibleIndex="99" Visible="false">
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewCommandColumn Name="Portfelj" ButtonType="Image" VisibleIndex="18" Width="25px" HeaderStyle-HorizontalAlign="Center" ToolTip="Portfelj fonda">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="btnFondPortfelj" Text="Portfelj">
                                <Image Url="~/Images/table_light.png" ToolTip="Portfelj fonda"></Image>
                            </dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>
                        <HeaderStyle HorizontalAlign="Center" />
                    </dx:GridViewCommandColumn>

                    <dx:GridViewCommandColumn Name="Brisanje" ButtonType="Image" VisibleIndex="19" Width="25px" HeaderStyle-HorizontalAlign="Center">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="btnDelete" Text="Brisanje" >
                                <Image Url="~/Images/trash_light.png" ToolTip="Brisanje"></Image>
                            </dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>
                        <HeaderStyle HorizontalAlign="Center" />
                    </dx:GridViewCommandColumn>

                    <dx:GridViewCommandColumn Name="Ispravka" ButtonType="Image" VisibleIndex="20" Width="25px" HeaderStyle-HorizontalAlign="Center" ShowNewButtonInHeader="true">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="btnEdit" Text="Ispravka">
                                <Image Url="~/Images/pencil.png" ToolTip="Ispravka"></Image>
                            </dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>
                        <HeaderStyle HorizontalAlign="Center" />
                        <HeaderTemplate>
                            <asp:Button ID="btnNovi" runat="server" Text="Novi" ToolTip="Novi fond" UseSubmitBehavior="false" CssClass="btn_grid_akcija right" OnClick="btnNovi_Click" />
                        </HeaderTemplate>
                    </dx:GridViewCommandColumn>

                    <dx:GridViewDataTextColumn Caption="X" Name="Sakriveni" ToolTip="Označite sakrivene fondove" VisibleIndex="21" Width="20px" HeaderStyle-HorizontalAlign="Center">
                        <HeaderStyle HorizontalAlign="Center" />
                        <CellStyle HorizontalAlign="Center"></CellStyle>
                    </dx:GridViewDataTextColumn>

                </Columns>
                <SettingsPager Mode="ShowAllRecords">
                </SettingsPager>
                <SettingsLoadingPanel ImagePosition="Left" ShowImage="true" Text="Učitavanje..." Mode="Default" Delay="300" />
                <Settings ShowGroupButtons="False" GroupFormat="{1}" />
                <SettingsText EmptyDataRow="Nema podataka za zadane uvjete pretraživanja." Title="PREGLED FONDOVA" />
                <SettingsDataSecurity AllowDelete="false" AllowEdit="true" AllowInsert="False" />
                <SettingsBehavior ConfirmDelete="true" />
                <Styles Header-Wrap="True">
                    <Header Wrap="True">
                    </Header>
                    <CommandColumnItem Font-Underline="False">
                    </CommandColumnItem>
                    <TitlePanel HorizontalAlign="Left"></TitlePanel>
                </Styles>
                <ClientSideEvents CustomButtonClick="function(s,e){ if(e.buttonID == 'btnDelete'){ e.processOnServer = confirm('Želite li obrisati fond? Ova akcija je nepovratna.');}else e.processOnServer = true; }" />
            </dx:ASPxGridView>

            <asp:Label ID="lblLog" runat="server"></asp:Label>

        </div>
    </ContentTemplate>
</asp:UpdatePanel>

<asp:EntityDataSource ID="EntityDataSource1" runat="server" ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" ContextTypeName="InvestApp.DAL.FondEntities"
    EnableFlattening="False" EntitySetName="FondPodaci" EntityTypeFilter="FondPodatak">
</asp:EntityDataSource>








