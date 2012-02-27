function gotoNeighborhood(selection) {
    var form = document.getElementById(selection);
    window.location = "/events/in/" + form[form.selectedIndex].text;
}

function submitForm(id) {
   var form = document.forms[id].submit();
}

function getParameterByName(name) {

    var match = RegExp('[?&]' + name + '=([^&]*)')
                    .exec(window.location.search);

    return match && decodeURIComponent(match[1].replace(/\+/g, ' '));

}

function closePopup() {
       $(".popup").addClass("hidden");
}



function addContentHandlers() {
    $("#link_list li a").click(function () {
        $("#content_sections div").each(function() { $(this).hide(); });
        $($(this).attr("href")+"_content").show();
        $("#link_list li a").each(function () { $(this).removeClass('link_active') } );
        $(this).addClass('link_active');
    });
}