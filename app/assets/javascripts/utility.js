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
    var showContent = function(id) {
        $("#content_sections>div").each(function() { $(this).hide(); });
        $(id+"_content").show();
        $("#link_list li a").each(function () { $(this).removeClass('link_active') } );
        $(id+"_link").addClass('link_active');
    };

    $("#link_list li a").click(function () {
        showContent($(this).attr('href'));
    });

    if (location.hash != "") {
        showContent(location.hash);
    }
}

function setDefaultText(element, defaultText) {
    element.addClass('defaultText');
    element.click(function() {
        $(this).removeClass('defaultText');
        if ($(this).val() == defaultText) {
            $(this).val('');
        }
    });

    element.blur(function() {
        if ($(this).val() == '') {
            $(this).val(defaultText);
            $(this).addClass('defaultText');
        }
    });
    element.val(defaultText);
}