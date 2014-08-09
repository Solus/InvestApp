<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FondPortfeljPregledCtrl.ascx.cs" Inherits="InvestApp.Web.FondPortfeljPregledCtrl" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<div class="search_body">

    <div id="divDatum" class="form_item_table" runat="server" visible="false">
        <label for="tbDatum">Datum:</label>
        <span class="iefloatfix">
            <dx:ASPxDateEdit ID="tbDatum" runat="server">
                <CalendarProperties ClearButtonText="Briši" TodayButtonText="Danas">
                </CalendarProperties>
            </dx:ASPxDateEdit>
        </span>
    </div>

    <div class="data_container">

        <dx:ASPxGridView ID="gvPortfelj" runat="server" AutoGenerateColumns="False" EnableTheming="True" KeyFieldName="ID"
            SettingsPager-Mode="ShowPager" Theme="Default" Width="100%" OnDataBinding="gvPortfelj_DataBinding" CssClass="data_table" OnCustomColumnDisplayText="gvPortfelj_CustomColumnDisplayText" OnCustomButtonCallback="gvPortfelj_CustomButtonCallback" OnCustomSummaryCalculate="gvPortfelj_CustomSummaryCalculate">
            <Styles Header-Wrap="True" Header-HorizontalAlign="Right">
                <CommandColumnItem Font-Underline="False">
                </CommandColumnItem>
                <TitlePanel HorizontalAlign="Left"></TitlePanel>
                <AlternatingRow CssClass="dxgvDataRow"></AlternatingRow>
            </Styles>

            <SettingsBehavior EncodeErrorHtml="True" />
            <SettingsText Title="PREGLED PORTFELJA" EmptyDataRow="Nema podataka za zadane uvjete pretraživanja." />
            <SettingsLoadingPanel Text="Učitavanje..." ImagePosition="Left" ShowImage="true" />
            <SettingsPager PageSize="10">
                <Summary AllPagesText="Stranica: {0} - {1} ({2} zapisa)"
                    Text="Stranica {0} od {1} ({2} zapisa)" />
            </SettingsPager>
            <Settings UseFixedTableLayout="True" ShowFooter="True" />

            <TotalSummary>
                <dx:ASPxSummaryItem DisplayFormat="UKUPNA VRIJEDNOST:" FieldName="NAZIV_FONDA"
                    ShowInColumn="naziv_fonda" SummaryType="Count" />
                <dx:ASPxSummaryItem DisplayFormat="{0:N}" FieldName="VRIJEDNOST_UDJELA_KN"
                    ShowInColumn="Vrijednost_udjela_kn" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:N}" FieldName="UDIO"
                    ShowInColumn="Udio" SummaryType="Sum" />
                <dx:ASPxSummaryItem DisplayFormat="{0:N}" FieldName="DOBIT_KN"
                    ShowInColumn="Dobit" SummaryType="Sum" />
                <dx:ASPxSummaryItem ShowInColumn="Prinos" FieldName="PRINOS" SummaryType="Custom" />
            </TotalSummary>

            <StylesPager EnableDefaultAppearance="False"></StylesPager>

            <Columns>

                <dx:GridViewDataTextColumn SortIndex="0" SortOrder="Ascending" Caption="Naziv fonda"
                    VisibleIndex="0" ReadOnly="True" Name="FOND_NAZIV" HeaderStyle-HorizontalAlign="Left"
                    ToolTip="Naziv fonda">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Broj udjela" FieldName="BR_UDJELA"
                    Name="BROJ_UDJELA" ReadOnly="True" ToolTip="Broj udjela" VisibleIndex="2"
                    Width="85px">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Nabavna vrijednost[kn]"
                    FieldName="NABAVNA_VRIJEDNOST_KN" ReadOnly="True"
                    ToolTip="Nabavna vrijednost" VisibleIndex="3" Width="95px" Name="Nabavna">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Zadnja cijena" Name="Cijena" ReadOnly="True"
                    ToolTip="Zadnja cijena" VisibleIndex="4" Width="110px">
                    <CellStyle HorizontalAlign="Right">
                    </CellStyle>
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Valuta" FieldName="VALUTA"
                    ToolTip="Valuta" VisibleIndex="5" Name="Valuta" Width="45px" HeaderStyle-HorizontalAlign="Center">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Promjena[%]" FieldName="POSTOTAK" Name="POSTOTAK"
                    ToolTip="Dnevna promjena cijene" VisibleIndex="6" Width="90px">
                    <PropertiesTextEdit DisplayFormatString="{0:n}">
                    </PropertiesTextEdit>
                </dx:GridViewDataTextColumn>

                <%--<dx:GridViewDataDateColumn Caption="Datum cijene" FieldName="DATUM_ZADNJE_CIJENE"
                    ReadOnly="True"
                    ToolTip="Datum cijene" VisibleIndex="5" Width="75px" Name="Datum">
                    <PropertiesDateEdit AllowUserInput="False" DisplayFormatString="dd.MM.yyyy">
                    </PropertiesDateEdit>
                </dx:GridViewDataDateColumn>--%>

                <%--<dx:GridViewDataTextColumn Caption="Vrijednost<br />udjela"
                    Name="Vrijednost_udjela" ReadOnly="True" ToolTip="Vrijednost udjela"
                    VisibleIndex="6" Width="65px" FieldName="VRIJEDNOST_UDJELA">
                </dx:GridViewDataTextColumn>--%>

                <dx:GridViewDataTextColumn Caption="Vrijednost udjela[kn]"
                    Name="Vrijednost_udjela_kn" ReadOnly="True" ToolTip="Vrijednost udjela [kn]"
                    VisibleIndex="7" Width="95px" FieldName="VRIJEDNOST_UDJELA_KN" PropertiesTextEdit-DisplayFormatString="n2">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Udio[%]"
                    Name="Udio" ReadOnly="True" ToolTip="Udio u portfelju [kn]"
                    VisibleIndex="8" Width="60px" FieldName="UDIO" PropertiesTextEdit-DisplayFormatString="n2">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Dobit[kn]" Name="Dobit" ReadOnly="True"
                    ToolTip="Dobit [kn]" VisibleIndex="9" Width="95px" FieldName="DOBIT_KN" PropertiesTextEdit-DisplayFormatString="n2">
                </dx:GridViewDataTextColumn>

                <dx:GridViewDataTextColumn Caption="Prinos[%]" Name="Prinos" ReadOnly="True"
                    ToolTip="Prinos" VisibleIndex="10" Width="85px" FieldName="PRINOS" PropertiesTextEdit-DisplayFormatString="n2">
                </dx:GridViewDataTextColumn>

                <dx:GridViewCommandColumn ButtonType="Image" Name="Dokupi"
                    ToolTip="Kupi" VisibleIndex="12" Width="30px"
                    AllowDragDrop="False" Caption="#" CellStyle-HorizontalAlign="Center">
                    <ClearFilterButton Visible="True">
                    </ClearFilterButton>
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="cbKupi" Text="Dokupi">
                            <Image Url="~/Images/plus.png" />
                        </dx:GridViewCommandColumnCustomButton>
                    </CustomButtons>
                    <CellStyle CssClass="PtCmdCellBtn">
                    </CellStyle>
                </dx:GridViewCommandColumn>

                <dx:GridViewCommandColumn ButtonType="Image" Name="Prodaj"
                    ToolTip="Prodaj" VisibleIndex="13" Width="30px"
                    AllowDragDrop="False" Caption="#" CellStyle-HorizontalAlign="Center">
                    <ClearFilterButton Visible="True">
                    </ClearFilterButton>
                    <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="cbProdaj" Text="Prodaj">
                            <Image Url="~/Images/minus.png" />
                        </dx:GridViewCommandColumnCustomButton>
                    </CustomButtons>
                    <CellStyle CssClass="PtCmdCellBtn">
                    </CellStyle>
                </dx:GridViewCommandColumn>

                <dx:GridViewDataTextColumn Caption="fond_id" FieldName="FOND_ID"
                    Name="fond_id" ToolTip="fond_id" Visible="False" VisibleIndex="14" Width="1px">
                </dx:GridViewDataTextColumn>

            </Columns>
        </dx:ASPxGridView>

        <asp:Button ID="btnRucno" CssClass="btn_navigation rucna_realizacija" runat="server" UseSubmitBehavior="false" CausesValidation="False" Text="Ručna realizacija" OnClick="btnRucno_Click" />

        <asp:UpdatePanel ID="upNovac" runat="server">
            <ContentTemplate>

                <div class="portfelj_bottom_extra">

                    <div id="divNovacView" runat="server">
                        <label for="txtNovac">Novac:</label>&nbsp;
                        <asp:Label ID="lblNovac" runat="server" Text=""></asp:Label>&nbsp;kn

                        <asp:Button ID="btnNovacEdit" CssClass="btn_navigation small edit" runat="server" CausesValidation="False" Text="" ToolTip="Promijeni" OnClick="btnNovacEdit_Click" />
                    </div>

                    <div id="divNovacEdit" runat="server" visible="false">
                        <label for="txtNovac">Novac[kn]:</label>
                        <asp:TextBox ID="txtNovac" runat="server"></asp:TextBox>

                        <asp:Button ID="btnNovacSave" CssClass="btn_navigation small save" runat="server" CausesValidation="true" Text="" ToolTip="Spremi" OnClick="btnNovacSave_Click" />
                        <asp:Button ID="btnNovacCancel" CssClass="btn_navigation small cancel" runat="server" CausesValidation="False" Text="" ToolTip="Odustani" OnClick="btnNovacCancel_Click" />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator39" ControlToValidate="txtNovac" CssClass="validate_error_inline v2" ErrorMessage="Iznos mora biti upisan" runat="server" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator3" ControlToValidate="txtNovac" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 1234,00" CssClass="validate_error_inline v2" Display="Dynamic">
                        </asp:CompareValidator>

                    </div>

                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>

</div>
