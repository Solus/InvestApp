<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="Upute.aspx.cs" Inherits="InvestApp.Web.Upute" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="upute_container">
        <div class="upute_1">
            <span class="title">KAKO FUNKCIONIRA 
                <a href="http://investiraj.net"><span class="link_site">investiraj</span><span class="link_domain">.net</span></a>
                ?
            </span>
            <ul>
                <li>brzo i lako pregledajte različite vrste fondova</li>
                <li>pregledajte povijesne prinose fondova</li>
                <li>klikom na fond pregledajte detalje o pojedinom fondu</li>
                <li>klikom na graf pogledajte graf cijene udjela u fondu</li>
            </ul>
            <img class="right" src="Images/Upute/ekrani_01_sa_sjenom.png" alt="" />
        </div>

        <div class="upute_2">
            <div class="section prva">
                <h1 id="pretraga">NAPREDNA PRETRAGA</h1>
                <p>lako i brzo pronađite fond koji zadovoljava vaše karakteristike</p>
                <img class="right" src="Images/Upute/01_pregled-fondova_01.png" alt="" />
            </div>

            <div class="section druga">
                <h1 id="usporedba">USPOREDBA</h1>
                <p>usporedite prinose fondova</p>
                <img class="left" src="Images/Upute/02_usporedba-fondova_01.png" alt="" />
            </div>
        </div>

        <div class="upute_3">
            <div class="section prva">
                <h1 id="registracija">REGISTRIRAJ SE</h1>
                <div><p>registracija omogućuje usporedbu većeg broja fondova, kupnju i prodaju fondova, te vođenje vlastitog portfelja</p>
                    </div>
                <img class="left" src="Images/Upute/03_registriraj-se_01.png" alt="" />
            </div>

            <div class="section druga">
                <h1 id="kupnja">KUPNJA & PRODAJA</h1>
                <p>pojednostavite proces kupnje kreiranjem korisničkog računa</p>
                <img class="right" src="Images/Upute/04_account_01.png" alt="" />
            </div>
        </div>

        <div class="upute_4">
            <div class="section prva">
                <h1 id="zahtjevi">ZAHTJEVI</h1>
                <p>pregledajte povijest vaših kupnji i prodaja</p>
                <img class="left" src="Images/Upute/05_realizacija-zahtjeva_01.png" alt="" />
            </div>

            <div class="section druga">
                <h1 id="portfelj">PORTFELJ</h1>
                <p>pratite svoj portfelj i pojedine fondove</p>
                <img class="left" src="Images/Upute/06_portfelj_01.png" alt="" />
            </div>
        </div>

        <div class="upute_5">
            <h1 id="blog">BLOG</h1>
            <p>pratite događanja relevantna za vaše osobne financije i naše poglede na ulaganja</p>
            <img class="right" src="Images/Upute/07_blog_01_s.png" alt="" />
        </div>

        <div class="upute_6">
            <span id="proces" class="title">Proces kupnje i/ili prodaje - <span class="highlight">5 koraka</span></span>

            <div class="koraci">
            <div class="korak prvi">
                <div class="image_top"></div>
                <div class="korak_tekst">
                    <span>Izaberite fond</span>
                </div>
                <div class="image_bottom"></div>
            </div>

            <div class="korak drugi">
                <div class="image_top"></div>
                <div class="korak_tekst">
                    <span>Unesite svoje podatke i iznos ulaganja</span>
                </div>
                <div class="image_bottom"></div>
            </div>

            <div class="korak treci">
                <div class="image_top"></div>
                <div class="korak_tekst">
                    <span>Dodajte svom profilu preslike relevantnih dokumenata</span>
                </div>
                <div class="image_bottom"></div>
            </div>

            <div class="korak cetvrti">
                <div class="image_top"></div>
                <div class="korak_tekst">
                    <span>Preuzmite pristupnu izjavu/zahtjev za otkup udjela i potpišite je/ga</span>
                </div>
                <div class="image_bottom"></div>
            </div>

            <div class="korak peti">
                <div class="image_top"></div>
                <div class="korak_tekst">
                    <span>Predajte presliku potpisane(og) pristupnu izjavu/zahtjeva za otkup udjela</span>
                </div>
                <div class="image_bottom"></div>
            </div>
                </div>
        </div>
    </div>

</asp:Content>
