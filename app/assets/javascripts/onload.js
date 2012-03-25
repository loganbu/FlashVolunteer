$(document).ready(function() { 
    if ($("#account_pulldown_link").length != 0) {
        $("#account_pulldown_link").click(function() {
            $("#account_pulldown").toggle();
            $(".clickeater").toggle();
        });
        $(".clickeater").click(function() {
            $(this).toggle();
            $("#account_pulldown").toggle();
        });
    }
});