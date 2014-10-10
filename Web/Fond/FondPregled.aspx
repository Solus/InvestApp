<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondPregled.aspx.cs" Inherits="InvestApp.Web.FondPregled" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register src="~/Kontrole/FondPregledCtrl.ascx" tagname="FondPregledCtrl" tagprefix="uc1" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dxe" %>

<asp:Content runat="server" ContentPlaceHolderID="HeadContent">

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="divSiteEnter" class="site_enter" runat="server">

        <div class="inner_box">
            <a class="box_button help" href="../Dokumenti/investiraj.net_upute_02.pdf" target="_blank">Kako funkcionira?</a>
            <a class="box_button register" runat="server" href="~/Account/Register">Registriraj se</a>
            <a class="button_more" href="#zasto">saznaj više >></a>
        </div>

    </div>

    <div class="form_header bar">Pregled fondova</div>

    <div class="form_body_table">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <asp:Label ID="lblLog" runat="server" Visible="false"></asp:Label>

            </ContentTemplate>
        </asp:UpdatePanel>

        <uc1:FondPregledCtrl ID="fondPregledControl" runat="server" />

    </div>

    <div id="divIntro" runat="server" class="site_introduction">
        <h1 id="zasto" class="title_zasto">Zašto investiraj.net?</h1>
        <div class="columns">

            <div class="column jednostavno">
                <h2 class="title">Jednostavno</h2>
                <p class="text">
                    investiraj.net omogućuje kupnju ili prodaju udjela u investicijskim fondovima na 
                    najjednostavniji mogući način. Nakon vaše prve kupnje ili prodaje vaši podaci bit 
                    će sačuvani što će vam omogućiti daljnje kupnje ili prodaje na najbrži način bez 
                    potrebe ponovnog unošenja vaših podataka!
                </p>
            </div>

            <div class="column pouzdano">
                <h2 class="title">Pouzdano</h2>
                <p class="text">
                    Vaš set dokumenata potreban za kupnju udjela bit će generiran direktno iz naše 
                    aplikacije i na taj način pomoći ćemo Vam osigurati točnost i cjelovitost podataka. 
                    Vaši podaci i dokumenti bit će pohranjeni sigurno na našim serverima zaštićeni Vašom lozinkom.
                </p>
            </div>

            <div class="column podrska">
                <h2 class="title">Podrška</h2>
                <p class="text">
                    Spremi smo pomoći savjetima u svim fazama procesa kupnje ili prodaje udjela u 
                    investicijskim fondovima. Ako trebate pomoć slobodno nas kontaktirajte telefonom, 
                    e-mailom ili nas osobno posjetite u našim uredima. Svaki Vaš set dokumenata provjerit 
                    ćemo prije prosljeđivanja društvu za upravljanje fondovima kako bi osigurali točnost i potpunost!
                </p>
            </div>

        </div>
    </div>

    <div id="divBlogBanner" runat="server" class="blog_banner">
        <h1 class="title_blog">Neka Vaš novac radi za Vas!</h1>
        <p class="text">
            Najbrži i najjednostavniji način upravljanja vašim udjelima u fondovima. 
            Pročitajte naš blog o investiranju u investicijske fondovima i događanjem 
            vezanim uz fondovsku industriju.
        </p>

        <a class="blog_link" runat="server" href="~/Blog.aspx">Blog</a>
    </div>

</asp:Content>