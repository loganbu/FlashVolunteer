// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

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