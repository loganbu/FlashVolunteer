var gMap = null;
var events = new Array();
var previousInfoWindow = null;
function setMap(div, mapLatitude, mapLongitude, zoom) {
    var myOptions = {
        zoom: zoom,
        center: new google.maps.LatLng(mapLatitude, mapLongitude),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    gMap = new google.maps.Map(document.getElementById(div), myOptions);
}


var showPopup = function(latlng) {
    if (previousInfoWindow) {
        previousInfoWindow.close();
        previousInfoWindow = null;
    }
    var event = events[latlng.latLng.toString()];
    $.ajax({
        url: "/events/" + event.eventXml.find('id').text() + "?map=true",
        dataType: 'html'
    }).success(function (data) {
        var infoWindow = new google.maps.InfoWindow({
            content: data
        });
        infoWindow.open(gMap, event.marker);
        previousInfoWindow = infoWindow;
    });
};

function addPoints(urlSource) {
    $.ajax({
        url: urlSource,
        dataType: 'xml'
    }).success(function (data) {
        var latitude = 0;
        var longitude = 0;
        $(data).find('event').each(function() {
            latitude = $(this).find('latitude').text();
            longitude = $(this).find('longitude').text();
            name = $(this).find('name').text();
            var latLng = new google.maps.LatLng(latitude, longitude);
            var marker = new google.maps.Marker({
                position: latLng,
                map: gMap,
                title: name,
                animation: google.maps.Animation.DROP,
                });
            events[latLng.toString()] = {
                eventXml: $(this),
                marker: marker
            };
            google.maps.event.addListener(marker, 'click', showPopup)
        });
    });
}
