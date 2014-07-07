<%@ Page Title="" Culture="de-DE" UICulture="hr" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondRealizacija.aspx.cs" Inherits="InvestApp.Web.FondRealizacija" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <h1 id="formHeader" class="form_header bar" runat="server">Ručna realizacija</h1>

    <div class="form_body">

        <asp:FormView ID="fvPromet" runat="server" DefaultMode="Insert" DataSourceID="EntityDataSourcePromet" RenderOuterTable="False" 
            OnDataBound="fvPromet_DataBound" 
            OnItemInserted="fvPromet_ItemInserted" 
            OnModeChanging="fvPromet_ModeChanging" >
            <InsertItemTemplate>

                <div class="form_item" id="divTipZahtjeva" runat="server" >
                    <asp:RadioButtonList ID="rblTipZahtjeva" runat="server" CssClass="form_item_value_edit" RepeatDirection="Horizontal" SelectedValue='<%# Bind("TIP_TRANSAKCIJE") %>' RepeatLayout="Flow">
                        <asp:ListItem Value="K" Selected="True">Kupnja</asp:ListItem>
                        <asp:ListItem Value="P">Prodaja</asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit" for="ddlFondovi">Fond:</label>
                    <asp:DropDownList ID="ddlFondovi" runat="server" CssClass="form_item_value_edit" DataSourceID="EntityDataSourceFondovi" DataTextField="NAZIV" DataValueField="ID" SelectedValue='<%# Bind("FOND_ID") %>'>
                    </asp:DropDownList>
                </div>

                <div class="form_item">
                    <label class="form_item_label_edit">Datum:</label>
                    <asp:TextBox ID="txtDatum" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("DATUM") %>' />

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtDatum" ErrorMessage="Datum mora biti upisan" runat="server" Display="Dynamic" CssClass="validate_error_inline">
                    </asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" ControlToValidate="txtDatum" Type="Date" Operator="DataTypeCheck"
                        ErrorMessage="Datum mora biti u formatu 25.12.1999" runat="server" CssClass="validate_error_inline" Display="Dynamic">
                    </asp:CompareValidator>
                </div>

                <div id="divKupnja" runat="server">

                    <div class="form_item">
                        <label class="form_item_label_edit" for="TextBox1">Iznos (kn):</label>
                        <asp:TextBox ID="txtIznos" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("IZNOS_KN", "n2") %>' />

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtIznos" ErrorMessage="Iznos mora biti upisan" runat="server" Display="Dynamic" CssClass="validate_error_inline">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator3" ControlToValidate="txtIznos" Type="Currency" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Iznos mora biti u formatu 1234,00" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>
                    </div>

                    <div class="form_item">
                        <label class="form_item_label_edit" for="ddlFondovi">Broj udjela:</label>
                        <asp:TextBox ID="txtBrojUdjela" runat="server" CssClass="form_item_value_edit" Text='<%# Bind("BROJ_UDJELA", "n4") %>' />

                        <asp:RequiredFieldValidator ID="valBrojUdjelaReq" ControlToValidate="txtBrojUdjela" ErrorMessage="Broj udjela mora biti upisan" runat="server" Display="Dynamic" CssClass="validate_error_inline">
                        </asp:RequiredFieldValidator>

                        <asp:CustomValidator ID="valBrojUdjela" runat="server" Display="Dynamic" ErrorMessage="Broj udjela nije ispravan" 
                                        OnServerValidate="valBrojUdjela_ServerValidate" ControlToValidate="txtBrojUdjela" 
                                        CssClass="validate_error_inline"></asp:CustomValidator>

                        <%--<asp:CompareValidator ID="CompareValidator2" ControlToValidate="txtBrojUdjela" Type="Integer" Operator="DataTypeCheck" runat="server"
                            ErrorMessage="Broj udjela mora biti u formatu 1234,0000" CssClass="validate_error_inline" Display="Dynamic">
                        </asp:CompareValidator>--%>
                    </div>

                </div>

                <div class="btn_navigation_group">
                    <asp:Button ID="UpdateButton" CssClass="btn_navigation save" runat="server" CausesValidation="True" CommandName="Insert" Text="Unesi" />&nbsp;
                    <asp:Button ID="UpdateCancelButton" CssClass="btn_navigation cancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" />
                </div>

            </InsertItemTemplate>
        </asp:FormView>

    </div>



    <asp:EntityDataSource ID="EntityDataSourceFondovi" runat="server"
        ContextTypeName="InvestApp.DAL.FondEntities"
        ConnectionString="name=FondEntities"
        DefaultContainerName="FondEntities"
        EnableFlattening="False"
        EntitySetName="Fondovi"
        EntityTypeFilter="Fond"
        OrderBy="it.[NAZIV]"
        Where="it.INDEKSNI IS NULL OR it.INDEKSNI = FALSE" >
    </asp:EntityDataSource>

    <asp:EntityDataSource ID="EntityDataSourcePromet" runat="server" 
        ContextTypeName="InvestApp.DAL.FondEntities" 
        ConnectionString="name=FondEntities" 
        DefaultContainerName="FondEntities" 
        EnableFlattening="False" 
        EnableInsert="True" 
        EntitySetName="FondPrometi" 
        EntityTypeFilter="FondPromet" OnInserting="EntityDataSourcePromet_Inserting">
    </asp:EntityDataSource>

</asp:Content>
