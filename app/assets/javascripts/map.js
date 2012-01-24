(function () {

Map = {};

var gMap = null;
var previousInfoWindow = null;
var eventMarkers = {};

Map.setMap = function (div, mapLatitude, mapLongitude, zoom) {
    var myOptions = {
        zoom: zoom,
        center: new google.maps.LatLng(mapLatitude, mapLongitude),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    gMap = new google.maps.Map(document.getElementById(div), myOptions);
};


Map.showMapFromElement = function(element, i, eventCallback) {
    var latitude = 0;
    var longitude = 0;
    latitude = element.find('latitude').text();
    longitude = element.find('longitude').text();
    name = element.find('name').text();
    var attending=element.find('user-participates').text();
    var imageStrip = attending == "true" ? "/assets/green_markers.png" : "/assets/red_markers.png"; 
    var latLng = new google.maps.LatLng(latitude, longitude);

    // Create a custom marker icon
    var icon = new google.maps.MarkerImage(
        imageStrip,
        new google.maps.Size(20, 20), // Image size
        new google.maps.Point(0, i*20), // Sprite origin
        new google.maps.Point(10, 10) // Mark the item in the middle
        );
    var marker = new google.maps.Marker({
        position: latLng,
        map: gMap,
        title: name,
        animation: google.maps.Animation.DROP,
        icon: icon
        });

    var eventXml = element;
    var eventId = eventXml.find('id').text();
    eventMarkers[eventId] = marker;

    if (eventCallback) {
        google.maps.event.addListener(marker, 'click', function () {
            eventCallback(eventId);
        });
    }
}

Map.addPoints = function (urlSource, eventCallback) {
    $.ajax({
        url: urlSource,
        dataType: 'xml'
    }).success(function (data) {
        $(data).find('event').each(function(i) {
            Map.showMapFromElement($(this), i, eventCallback)
        });
    });
};

Map.centerOnEvent = function(eventId) {
    // Goto events page, centered on eventId
}
Map.showPopup = function(eventId) {
    if (previousInfoWindow) {
        previousInfoWindow.close();
        previousInfoWindow = null;
    }

    $.ajax({
        url: "/events/" + eventId + "?map=true",
        dataType: 'html'
    }).success(function (data) {
        var infoWindow = new google.maps.InfoWindow({
            content: data
        });
        var marker = eventMarkers[eventId];
        infoWindow.open(gMap, marker);
        previousInfoWindow = infoWindow;
    });
};

})();