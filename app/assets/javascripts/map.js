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
    var iconSize = 30;
    var iconHalfSize = iconSize/2;

    latitude = element.find('latitude').text();
    longitude = element.find('longitude').text();
    name = element.find('name').text();
    var attending=element.find('user-participates').text();
    var imageStrip = attending == "true" ? "/assets/mapStripSignedUp_medium.png" : 
        "/assets/mapStripAvail_medium.png"; 
    var latLng = new google.maps.LatLng(latitude, longitude);

    var iconLocation = onPage ? iconSize*i : 0;

    // Create a custom marker icon
    var icon = new google.maps.MarkerImage(
        imageStrip,
        new google.maps.Size(iconSize, iconSize), // Image size
        new google.maps.Point(0, iconLocation), // Sprite origin
        new google.maps.Point(iconHalfSize, iconHalfSize) // Mark the item in the middle
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