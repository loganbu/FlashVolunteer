function gotoNeighborhood(selection) {
    var form = document.getElementById(selection);
    window.location = "/events/in/" + form[form.selectedIndex].text.replace(", ", "/");
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

function activateContentSection(section) {
    $("#content_sections>div").each(function() { $(this).hide(); });
    $(section+"_content").show();
    $("#link_list li a").each(function () { $(this).removeClass('link_active') } );
    $(section+"_link").addClass('link_active');
}

function addContentHandlers() {
    $("#link_list li a").click(function () {
        $("#content_sections>div").each(function() { $(this).hide(); });
        $($(this).attr("href")+"_content").show();
        $("#link_list li a").each(function () { $(this).removeClass('link_active') } );
        $(this).addClass('link_active');
    });
    if (location.hash != "") {
        activateContentSection(location.hash);
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

function revealModal(id) {
    window.onscroll = function () { document.getElementById(id).style.top = document.body.scrollTop; };
    document.getElementById(id).style.display = "block";
    document.getElementById(id).style.top = document.body.scrollTop;
}
 
function hideModal(id) {
    document.getElementById(id).style.display = "none";
}

function countdownString(dateTime) {
    var second = 1000;
    var minute = second*60;
    var hour = minute*60;
    var day = hour*24;

    var diffObj = function()
    {
        this.value = 0;
    }
    var diff = new diffObj();
    diff.value = dateTime - (new Date());

    var next = function(cumulator, partition) {
        var numPartitions = Math.floor(cumulator.value/partition) | 0;
        cumulator.value -= partition*numPartitions;
        return numPartitions;
    }

    var nextStr = function(total, totalStr) {
        var str = "";
        if (total) {
            if (total > 1) {
                totalStr += "s";
            }
            str = total + " " + totalStr;
        }
        return str;
    }

    var days = next(diff, day);
    var hours = next(diff, hour);
    var minutes = next(diff, minute);
    var seconds = next(diff, second);
    var daysStr = nextStr(days, "Day");
    var hoursStr = nextStr(hours, "Hour");
    var minutesStr = nextStr(minutes, "Minute");

    return daysStr + " " + hoursStr + " " + minutesStr;
}