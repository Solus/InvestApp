$(document).ready(function () {

    if ($.cookie('investapp_accept') == undefined)
        showConsentForm();

});

function showConsentForm() {

    var uvjetiLink = '/UvjetiKoristenja.aspx';

    var $div = $("<div>", { id: "cookie_consent" });
    $div.html("investiraj.net koristi kolačiće za pružanje boljeg korisničkog iskustva, " +
        "funkcionalnosti i prikaza sustava oglašavanja. Cookie postavke mogu se kontrolirati i " +
        "konfigurirati u vašem web pregledniku. Više o ovome možete pročitati u <a target='_blank' href='" + uvjetiLink + "'>uvjetima korištenja</a>. " +
        "Nastavkom pregleda web stranice investiraj.net slažete se sa korištenjem kolačića. " +
        "Za nastavak pregleda i korištenja web stranice investiraj.net kliknite na");

    var $btn = $('<a>', { id: 'cookie_accept' });
    $btn.text('Slažem se');
    //$btn.attr('href', 'javascript: void(0);');
    $btn.click(acceptCookie);

    $div.append($btn);

    $div.click(function (event) {
        event.stopPropagation();
    });

    $('html').click( acceptCookie );

    $(body).append($div);
}

function acceptCookie() {

    $.cookie('investapp_accept', 'true', { expires: 14, path: '/' });

    $('#cookie_consent').fadeOut('fast', function () {
        $(this).remove();
    });

}