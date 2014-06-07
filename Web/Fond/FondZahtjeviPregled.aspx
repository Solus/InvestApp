<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondZahtjeviPregled.aspx.cs" Inherits="InvestApp.Web.FondZahtjeviPregled" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">

        function SearchReset() {

            $('#ddlTip').val('');
            $('#ddlStatus').val('');
            $('#ddlFond').val('-1');
            tbDatumOd.SetDate(null);
            tbDatumDo.SetDate(null);
        }

    </script>

    <h1 class="form_header bar">Realizacija zahtjeva</h1>

    <div class="form_body wide">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="search_group">

                    <div class="search_item_group block">
                        <label class="search_label" for="ddlTip">Tip:</label>
                        <asp:DropDownList ID="ddlTip" CssClass="search_control" runat="server" ClientIDMode="Static">
                            <asp:ListItem Text="--Svi--" Value=""></asp:ListItem>
                            <asp:ListItem Text="Kupnja" Value="K"></asp:ListItem>
                            <asp:ListItem Text="Prodaja" Value="P"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="search_item_group block">
                        <label class="search_label" for="tbDatumOd">Interval:</label>

                        <dx:ASPxDateEdit CssClass="search_control_date" ID="tbDatumOd" runat="server" ForeColor="#5F5F5F"
                            MaxDate="2100-01-01" MinDate="1900-01-01" ClientInstanceName="tbDatumOd">
                            <CalendarProperties ClearButtonText="Briši" TodayButtonText="Danas">
                            </CalendarProperties>
                        </dx:ASPxDateEdit>

                        <dx:ASPxDateEdit CssClass="search_control_date" ID="tbDatumDo" runat="server" ForeColor="#5F5F5F"
                            MaxDate="2100-01-01" MinDate="1900-01-01" ClientInstanceName="tbDatumDo">
                            <CalendarProperties ClearButtonText="Briši" TodayButtonText="Danas">
                            </CalendarProperties>
                        </dx:ASPxDateEdit>
                    </div>

                    <div class="search_item_group block">
                        <label class="search_label" for="ddlStatus">Status:</label>
                        <asp:DropDownList ID="ddlStatus" CssClass="search_control" runat="server" ClientIDMode="Static">
                            <asp:ListItem Text="--Svi--" Value=""></asp:ListItem>
                            <asp:ListItem Text="Podnesen" Value="UN"></asp:ListItem>
                            <asp:ListItem Text="Realiziran" Value="OB"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="search_item_group block">
                        <label class="search_label" for="ddlFond">Fond:</label>
                        <asp:DropDownList ID="ddlFond" CssClass="search_control" runat="server" DataTextField="NAZIV" DataValueField="ID" ClientIDMode="Static"></asp:DropDownList>
                    </div>

                    <asp:LinkButton ID="btnTrazi" runat="server" CssClass="search_button" OnClick="btnTrazi_Click">Traži</asp:LinkButton>
                    <asp:LinkButton ID="btnResetTrazi" runat="server" ToolTip="Obriši uvjete pretraživanja" CssClass="search_button search_clear" PostBackUrl="javascript: void(0);" OnClientClick="SearchReset(); return false;">X</asp:LinkButton>

                </div>



                <div class="data_container">

                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="200">
                        <ProgressTemplate>
                            <div class="progress_message">Učitavanje...</div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>

                    <dx:ASPxGridView ID="gvZahtjevi" runat="server" AutoGenerateColumns="False" EnableTheming="True" KeyFieldName="ID"
                        SettingsPager-Mode="ShowPager" Theme="Default" Width="100%" CssClass="data_table" ClientInstanceName="gridZahtjevi"
                        OnCustomButtonCallback="gvZahtjevi_CustomButtonCallback"
                        OnDataBinding="gvZahtjevi_DataBinding"
                        SettingsBehavior-ConfirmDelete="true" p OnHtmlEditFormCreated="gvZahtjevi_HtmlEditFormCreated" OnCustomButtonInitialize="gvZahtjevi_CustomButtonInitialize" OnCustomColumnDisplayText="gvZahtjevi_CustomColumnDisplayText">

                        <Styles Header-Wrap="True">
                            <CommandColumnItem Font-Underline="False">
                            </CommandColumnItem>
                            <TitlePanel HorizontalAlign="Left"></TitlePanel>
                            <Header Wrap="True"></Header>

                            <AlternatingRow CssClass="dxgvDataRow"></AlternatingRow>
                        </Styles>

                        <SettingsBehavior EncodeErrorHtml="True" />
                        <SettingsText
                            Title="PREGLED ZAHTJEVA"
                            EmptyDataRow="Nema podataka za zadane uvjete pretraživanja."
                            ConfirmDelete="Želite li obrisati zahtjev?"
                            PopupEditFormCaption="Uređivanje zahtjeva" />
                        <SettingsLoadingPanel Text="Učitavanje..." ImagePosition="Left" ShowImage="true" />
                        <SettingsPager PageSize="10">
                            <Summary AllPagesText="Stranica: {0} - {1} ({2} zapisa)"
                                Text="Stranica {0} od {1} ({2} zapisa)" />
                        </SettingsPager>
                        <Settings UseFixedTableLayout="True" />
                        <Templates>
                            <EditForm>
                                <div class="form_item">
                                    <label class="form_item_label small">Fond:</label>
                                    <asp:Label ID="lblNazivFonda" runat="server" CssClass="form_item_value" Text='<%# Eval("FOND_NAZIV") %>'></asp:Label>
                                </div>
                                <div class="form_item" id="divIznosUdjela" runat="server">
                                    <label class="form_item_label_edit">Iznos udjela:</label>
                                    <asp:TextBox ID="ZELJENI_IZNOS_UDJELATextBox" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("ZELJENI_IZNOS_UDJELA") %>' />
                                </div>

                                <div class="form_item" id="divBrojUdjela" runat="server">
                                    <label class="form_item_label_edit">Broj udjela:</label>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("ZELJENI_BROJ_UDJELA") %>' />
                                </div>

                                <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" ReplacementType="EditFormUpdateButton" runat="server"></dx:ASPxGridViewTemplateReplacement>
                                <dx:ASPxGridViewTemplateReplacement ID="CancelButton" ReplacementType="EditFormCancelButton" runat="server"></dx:ASPxGridViewTemplateReplacement>

                            </EditForm>
                        </Templates>

                        <StylesPager EnableDefaultAppearance="False"></StylesPager>

                        <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
                        <SettingsPopup EditForm-HorizontalAlign="Center" EditForm-VerticalAlign="Middle" EditForm-Width="500">
                            <EditForm Width="500px" HorizontalAlign="Center" VerticalAlign="Middle"></EditForm>
                        </SettingsPopup>

                        <Columns>

                            <dx:GridViewDataTextColumn FieldName="ID" Name="Id" VisibleIndex="0" Visible="false">
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataDateColumn Caption="Datum podnošenja" FieldName="PODNOSENJE_DATUM" ReadOnly="True"
                                ToolTip="Datum podnošenja" VisibleIndex="1" Width="100px" Name="Datum" SortOrder="Descending">
                                <PropertiesDateEdit AllowUserInput="False" DisplayFormatString="dd.MM.yyyy">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>

                            <dx:GridViewDataTextColumn Caption="Tip" FieldName="TIP_ZAHTJEVA_NAZIV"
                                ToolTip="Tip" VisibleIndex="2" ReadOnly="True" Name="Tip" Width="90px">
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn Caption="Naziv fonda" FieldName="FOND_NAZIV"
                                VisibleIndex="3" ReadOnly="True" Name="naziv_fonda"
                                ToolTip="Naziv fonda">
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn Caption="Broj udjela" FieldName="ZELJENI_BROJ_UDJELA"
                                Name="ZELJENI_BROJ_UDJELA" ReadOnly="True" ToolTip="Broj udjela" VisibleIndex="4" HeaderStyle-HorizontalAlign="Right" PropertiesTextEdit-DisplayFormatString="n0"
                                Width="80px">
                                <PropertiesTextEdit DisplayFormatString="n0"></PropertiesTextEdit>

                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataTextColumn Caption="Iznos udjela"
                                FieldName="ZELJENI_IZNOS_UDJELA" Name="IznosUdjela" ReadOnly="True" HeaderStyle-HorizontalAlign="Right" PropertiesTextEdit-DisplayFormatString="n2"
                                ToolTip="Iznos udjela" VisibleIndex="5" Width="100px">
                                <PropertiesTextEdit DisplayFormatString="n2"></PropertiesTextEdit>

                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                            </dx:GridViewDataTextColumn>

                            <dx:GridViewDataDateColumn Caption="Datum realizacije" FieldName="OBRADA_DATUM"
                                Name="Datum obrade" ReadOnly="True" ToolTip="Datum obrade"
                                VisibleIndex="6" Width="100px">
                                <PropertiesDateEdit AllowUserInput="False" DisplayFormatString="dd.MM.yyyy">
                                </PropertiesDateEdit>
                            </dx:GridViewDataDateColumn>

                            <dx:GridViewDataTextColumn Caption="Status" FieldName="STATUS_NAZIV" Name="Status"
                                ReadOnly="True" ToolTip="Status" VisibleIndex="7" Width="90px">
                                <CellStyle HorizontalAlign="Left">
                                </CellStyle>
                            </dx:GridViewDataTextColumn>

                            <%--<dx:GridViewCommandColumn AllowDragDrop="False" ButtonType="Image" Name="ZahtjevPDF" ToolTip="Zahtjev PDF" VisibleIndex="8" Width="30px" HeaderStyle-HorizontalAlign="Center">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="cbZahtjevReport" Text="Zahtjev PDF">
                                <Image Url="~/Images/pdf.gif" />
                            </dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>
                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                    </dx:GridViewCommandColumn>--%>

                            <dx:GridViewDataHyperLinkColumn VisibleIndex="9" Name="ZahtjevPotvrda" ToolTip="Potvrda zahtjeva" 
                                Width="33px" Caption="#" HeaderStyle-HorizontalAlign="Center">
                                <DataItemTemplate>
                                    <asp:HyperLink runat="server" ImageUrl="~/Images/pdf.png" ToolTip="Ispis zahtjeva" NavigateUrl='<%# "~/Reports/ZahtjevIspis.aspx?ID=" + Eval("ID") %>'></asp:HyperLink>
                                </DataItemTemplate>
                            </dx:GridViewDataHyperLinkColumn>

                            <dx:GridViewDataTextColumn Caption="#" VisibleIndex="9" ReadOnly="True" Name="DOKUMENT_URL" HeaderStyle-HorizontalAlign="Center"
                                ToolTip="Potvrda zahtjeva" Width="30px">
                            </dx:GridViewDataTextColumn>

                            <%--<dx:GridViewDataHyperLinkColumn FieldName="DOKUMENT_URL" VisibleIndex="9" Name="ZahtjevPotvrda" ToolTip="Potvrda zahtjeva" Width="30px" Caption="#" HeaderStyle-HorizontalAlign="Center" >
                        <PropertiesHyperLinkEdit ImageUrl="~/Images/document.png" Target="_blank" ></PropertiesHyperLinkEdit>
                    </dx:GridViewDataHyperLinkColumn>--%>

                            <%--<dx:GridViewCommandColumn ButtonType="Image" AllowDragDrop="False" Name="Ispravka"
                        Width="30px" ToolTip="Ispravka zahtjeva" VisibleIndex="11">
                        <ClearFilterButton Visible="True"></ClearFilterButton>
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="cbIspravka" Text="Ispravka zahtjeva">
                                <Image Url="~/Images/edit.gif"></Image>
                            </dx:GridViewCommandColumnCustomButton>
                        </CustomButtons>

                        <CellStyle CssClass="PtCmdCellBtn"></CellStyle>
                    </dx:GridViewCommandColumn>--%>

                            <%--<dx:GridViewCommandColumn ButtonType="Image" AllowDragDrop="False" Name="Brisanje" Caption="#"
                        Width="30px" ToolTip="Brisanje zahtjeva" VisibleIndex="11" HeaderStyle-HorizontalAlign="Center" ShowDeleteButton="true">
                        <DeleteButton Image-Url="~/Images/trash.png" Image-ToolTip="Obriši zahtjev">
                            <Image ToolTip="Obriši zahtjev" Url="~/Images/trash.png"></Image>
                        </DeleteButton>

                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <CellStyle CssClass="cell_btn_zahtjev_izvrsi"></CellStyle>
                    </dx:GridViewCommandColumn>

                    <dx:GridViewCommandColumn ButtonType="Image" AllowDragDrop="False" Name="Ispravka" Caption="#"
                        Width="30px" ToolTip="Ispravka zahtjeva" VisibleIndex="11" HeaderStyle-HorizontalAlign="Center" ShowEditButton="true">
                        <EditButton Image-Url="~/Images/edit.png" Image-ToolTip="Ispravi">
                            <Image ToolTip="Ispravi" Url="~/Images/edit.png"></Image>
                        </EditButton>

                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                        <CellStyle CssClass="cell_btn_zahtjev_izvrsi"></CellStyle>
                    </dx:GridViewCommandColumn>--%>

                            <dx:GridViewCommandColumn ButtonType="Image" AllowDragDrop="False" Name="Realizacija" Caption="#"
                                Width="30px" ToolTip="Realizacija zahtjeva" VisibleIndex="10" HeaderStyle-HorizontalAlign="Center">
                                <CustomButtons>
                                    <dx:GridViewCommandColumnCustomButton ID="cbIzvrsi" Text="Realiziraj">
                                        <Image Url="~/Images/check.png"></Image>
                                    </dx:GridViewCommandColumnCustomButton>
                                </CustomButtons>

                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>

                                <CellStyle CssClass="cell_btn_zahtjev_izvrsi"></CellStyle>
                            </dx:GridViewCommandColumn>

                        </Columns>
                    </dx:ASPxGridView>


                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:EntityDataSource ID="EntityDataSourceZahtjevi" runat="server"
            ConnectionString="name=FondEntities" DefaultContainerName="FondEntities" ContextTypeName="InvestApp.DAL.FondEntities"
            EnableDelete="True" EnableFlattening="False" EnableUpdate="True" EntitySetName="FondZahtjevi" EntityTypeFilter="FondZahtjev"
            Include="Fond">
        </asp:EntityDataSource>

    </div>

</asp:Content>

