<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="FondPregled.aspx.cs" Inherits="InvestApp.Web.FondPregled" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register src="~/Kontrole/FondPregledCtrl.ascx" tagname="FondPregledCtrl" tagprefix="uc1" %>

<%@ Register assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dxe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="divSiteEnter" class="site_enter" runat="server">

        <div class="inner_box">
            <a class="box_button help" href="#">Kako funkcionira?</a>
            <a class="box_button register" runat="server" href="~/Account/Register">Registriraj se</a>
            <a class="button_more" href="#zasto">saznaj više >></a>
        </div>

    </div>

    <div class="form_header bar">Pregled fondova</div>

    <div class="form_body_table">

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <asp:Label ID="lblLog" runat="server"></asp:Label>

            </ContentTemplate>
        </asp:UpdatePanel>

        <uc1:FondPregledCtrl ID="fondPregledControl" runat="server" />

    </div>

    <div id="divIntro" runat="server" class="site_introduction">
        <h1 id="zasto" class="title_zasto">Zašto investiraj.net?</h1>
        <div class="columns">

            <div class="column jednostavno">
                <h2 class="title">Jednostavno</h2>
                <p class="text">Integer sodales nisi facilisis purus viverra, sit amet posuere dolor posuere. 
                    Donec aliquet, ipsum at blandit lacinia, mi nibh ornare orci, at scelerisque 
                    velit turpis quis ipsum. Nulla in egestas magna. Nunc sed dignissim quam. 
                    Suspendisse purus eros, pellentesque eu lorem at, tempus ullamcorper neque.</p>
            </div>

            <div class="column pouzdano">
                <h2 class="title">Pouzdano</h2>
                <p class="text">Integer sodales nisi facilisis purus viverra, sit amet posuere dolor posuere. 
                    Donec aliquet, ipsum at blandit lacinia, mi nibh ornare orci, at scelerisque 
                    velit turpis quis ipsum. Nulla in egestas magna. Nunc sed dignissim quam. 
                    Suspendisse purus eros, pellentesque eu lorem at, tempus ullamcorper neque.</p>
            </div>

            <div class="column podrska">
                <h2 class="title">Podrška</h2>
                <p class="text">Integer sodales nisi facilisis purus viverra, sit amet posuere dolor posuere. 
                    Donec aliquet, ipsum at blandit lacinia, mi nibh ornare orci, at scelerisque 
                    velit turpis quis ipsum. Nulla in egestas magna. Nunc sed dignissim quam. 
                    Suspendisse purus eros, pellentesque eu lorem at, tempus ullamcorper neque.</p>
            </div>

        </div>
    </div>

    <div id="divBlogBanner" runat="server" class="blog_banner">
        <h1 class="title_blog">Let Your Money Work For You!</h1>
        <p class="text">Najbrži i najjednostavniji način upravljanja vašim udjelima u fondovima. 
            Sed eu ipsum id odio ullamcorper ultricies id ac lectus. Pellentesque vitae quam congue, 
            pharetra nunc id, aliquam massa. </p>

        <a class="blog_link" runat="server" href="~/Blog.aspx">Blog</a>
    </div>

</asp:Content>