<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="Blog.aspx.cs" Inherits="InvestApp.Web.Novosti" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

    <script type="text/javascript" src='<%= ResolveUrl("~/Scripts/tinymce.min.js") %>'></script>

    <script type="text/javascript">
        tinymce.init({
            content_css: "../Content/css/site_content.css",
            theme_advanced_font_sizes: "10px,12px,13px,14px,16px,18px,20px",
            font_size_style_values: "10px,12px,13px,14px,16px,18px,20px",
            selector: ".html_edit",
            plugins: "link image",
            entity_encoding: "raw",
            height: 350,
            menubar: false,
            toolbar: ["bold italic underline strikethrough alignleft aligncenter alignright alignjustify styleselect formatselect fontsizeselect",
                      "cut copy paste bullist numlist outdent indent removeformat subscript superscript link unlink image"]
        });
    </script>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="blog_container">

        <asp:Button ID="btnNovi" runat="server" CausesValidation="True" Text="Novi" CssClass="btn_navigation btn_blog_novi" OnClick="btnNovi_Click" />

        <div id="divNovi" runat="server" visible="false" class="blog_item">

            <asp:FormView ID="fvBlogNovi" runat="server" 
                DataSourceID="EntityDataSourceNovosti" DataKeyNames="ID" 
                DefaultMode="Insert" 
                OnModeChanging="fvBlogNovi_ModeChanging" OnItemInserting="fvBlogNovi_ItemInserting" OnItemInserted="fvBlogNovi_ItemInserted"
                RenderOuterTable="false" >

                <InsertItemTemplate>

                    <div id="Div1" class="form_item" runat="server">
                        <label class="form_item_label_edit small">Naslov:</label>
                        <asp:TextBox ID="txtNaslov" runat="server" Text='<%# Bind("NASLOV") %>' CssClass="form_item_value_edit" />
                    </div>

                    <div id="Div2" class="form_item" runat="server">
                        <asp:TextBox ID="txtTekst" runat="server" Text='<%# Bind("TEKST") %>' CssClass="form_item_value_edit html_edit" TextMode="MultiLine" />
                    </div>

                    <div class="btn_navigation_group">
                        <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Spremi" CssClass="btn_navigation save" />
                        <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" CssClass="btn_navigation cancel" />
                    </div>

                </InsertItemTemplate>

            </asp:FormView>

            <asp:Label ID="lblNoviPoruka" runat="server" CssClass="validate_error_inline"></asp:Label>

        </div>

        <asp:Repeater ID="repeaterNovosti" runat="server" DataSourceID="EntityDataSourceNovosti" OnItemDataBound="repeaterNovosti_ItemDataBound" OnItemCommand="repeaterNovosti_ItemCommand">

            <HeaderTemplate>
            </HeaderTemplate>

            <ItemTemplate>

                <div class="blog_item">

                    <asp:LinkButton ID="btnEdit" runat="server" CssClass="blog_button edit" ToolTip="Uredi" CommandName="EditBlog"></asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="blog_button delete" ToolTip="Obriši" CommandName="DeleteBlog" OnClientClick='<%# Eval("NASLOV", "return confirm(\"Želite li obrisati \\\"{0}\\\"?\"); ")  %>' ></asp:LinkButton>

                    <asp:FormView ID="fvBlog" runat="server" 
                        DataSourceID="EntityDataSourceNovost" DataKeyNames="ID" 
                        DefaultMode="ReadOnly" 
                        OnItemUpdating="fvBlog_ItemUpdating"
                        RenderOuterTable="false">
                        <ItemTemplate>

                            <h1 class="blog_title"><%# Eval("NASLOV") %></h1>
                            <div class="blog_info">
                                <span class="blog_time"><%# Eval("VRIJEME_KREIRANJA", "{0:dd.MM.yyyy HH.mm}") %></span>
                            </div>

                            <div class="blog_text"><%# Eval("TEKST") %></div>
                        </ItemTemplate>
                        <EditItemTemplate>

                            <div class="form_item" runat="server">
                                <label class="form_item_label_edit small">Naslov:</label>
                                <asp:TextBox ID="txtNaslov" runat="server" Text='<%# Bind("NASLOV") %>' CssClass="form_item_value_edit" />
                            </div>

                            <div class="form_item" runat="server">
                                <asp:TextBox ID="txtTekst" runat="server" Text='<%# Bind("TEKST") %>' CssClass="form_item_value_edit html_edit" TextMode="MultiLine" />
                            </div>

                            <div class="btn_navigation_group">
                                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Spremi" CssClass="btn_navigation save" />
                                <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Odustani" CssClass="btn_navigation cancel" />
                            </div>

                        </EditItemTemplate>

                    </asp:FormView>

                    <asp:EntityDataSource ID="EntityDataSourceNovost"
                        AutoGenerateWhereClause="True" runat="server"
                        ContextTypeName="InvestApp.DAL.FondEntities"
                        ConnectionString="name=FondEntities"
                        DefaultContainerName="FondEntities"
                        EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
                        EntitySetName="Novosti"
                        EntityTypeFilter="Novost">
                    </asp:EntityDataSource>

                </div>

            </ItemTemplate>

            <FooterTemplate>
            </FooterTemplate>

        </asp:Repeater>

    </div>

    <asp:EntityDataSource ID="EntityDataSourceNovosti"
                        AutoGenerateWhereClause="True" runat="server"
                        ContextTypeName="InvestApp.DAL.FondEntities"
                        ConnectionString="name=FondEntities"
                        DefaultContainerName="FondEntities"
                        EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True"
                        EntitySetName="Novosti"
                        EntityTypeFilter="Novost" OrderBy="it.VRIJEME_KREIRANJA desc">
                    </asp:EntityDataSource>

</asp:Content>
