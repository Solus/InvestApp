<%@ Page Title="" Language="C#" MasterPageFile="~/InvestMainContent.Master" AutoEventWireup="true" CodeBehind="Rjecnik.aspx.cs" Inherits="InvestApp.Web.Rjecnik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="rjecnik_container">
        <h1 class="large">Rječnik</h1>

        <div class="left">

            <p>
                Otvoreni investicijski fond (UCITS fond) - je subjekt za zajednička ulaganja čija je 
jedina svrha i namjena prikupljanje sredstava javnom ponudom te ulaganje tih 
sredstava u različite vrste imovine u skladu s unaprijed određenom strategijom 
ulaganja investicijskog fonda, a isključivo u korist imatelja udjela u tom 
investicijskom fondu
            </p>

            <span class="dict_group">UPRAVLJANJE</span>

            <ul class="indent">
                <li><span class="term">aktivno</span> – upravitelj fonda koristi dostupne informacije i analize kako bi na
  osnovu njih odabrao što bolje investicije i ostvario bolji prinos od prinosa 
  tržišta (usporedivog indeksa)</li>
                <li><span class="term">pasivno</span> – fond replicira unaprijed zadan portfelj (npr. indeks) tj. cilj fonda 
  je ostvarivati prinos jednak prinosu tržišta</li>
            </ul>

            <span class="dict_group">CILJ PRINOSA</span>
            <ul class="indent">
                <li><span class="term">relativni</span> – cilj fonda je ostvarivanje prinosa boljeg od prinosa tržišta
  (usporedivog indeksa)</li>
                <li><span class="term">apsolutni</span> – cilj fonda je konstantno ostvarivanje pozitivnog prinosa 
  ulaganje</li>
            </ul>
            <ul>
                <li><span class="term">fond fondova</span> – fond koji ulaže u druge fondove</li>
                <li><span class="term">direktno ulaganje</span> – fond ulaže direktno u vrijednosne papire</li>
                <li><span class="term">geografska regija</span> – zemljopisno područje u koje fond ulaže</li>
                <li><span class="term">sektor</span> – vrsta industrije u koju fond ulaže</li>

            </ul>
        </div>

        <div class="right">
            <span class="dict_group">TRŽIŠTE</span>
            <ul>
                <li><span class="term">razvijena tržišta</span> – najrazvijenije države u ekonomskom pogledu i u pogledu
razvijenosti tržišta kapitala. karakterizira ih visoka razina osobnog dohotka,
otvorenost stranom vlasništvu, sloboda kretanja kapitala i visoka efikasnost
tržišnih institucija.</li>
                <li><span class="term">tržišta u nastajanju</span> – države koje imaju pojedine karakteristike razvijenih 
tržišta ali nisu u potpunosti dosegle dovoljnu razinu razvijenosti u svim
elementima razvijenosti.</li>
                <li><span class="term">granična tržišta</span> – države koje tek su započele svoj put prema tržištu u 
nastajanju. u pravilu su manja i nerazvijenija tržišta zemalja u razvoju. 
karakterizira ih visok rizik, ali i mogućnost visokih povrata.
                </li>
            </ul>
            <ul>
                <li><span class="term">PROFIL RIZIČNOSTI I USPJEŠNOSTI</span> – brojčani pokazatelj koji na numeričkoj 
skali (od 1 do 7) predstavlja kategoriju rizičnosti i uspješnosti fonda. izračunava 
se korištenjem povijesne volatilnosti na temelju metodologije sukladne 
propisima EU.  što je veća kategorija veći su očekivani prinos, ali i rizik gubitka 
ulaganja. najniža kategorija ne znači ulaganje bez rizika.</li>
            </ul>
            <a class="large" href="http://www.investiraj.net">www.investiraj.net</a>
        </div>

        <div class="clear-fix"></div>

    </div>
</asp:Content>
