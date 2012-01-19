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

Map.addPoints = function (urlSource) {
    $.ajax({
        url: urlSource,
        dataType: 'xml'
    }).success(function (data) {
        var latitude = 0;
        var longitude = 0;
        $(data).find('event').each(function(i) {
            latitude = $(this).find('latitude').text();
            longitude = $(this).find('longitude').text();
            name = $(this).find('name').text();
            var latLng = new google.maps.LatLng(latitude, longitude);

            // Create a custom marker icon
            var icon = new google.maps.MarkerImage(
                "/images/red_markers.png",
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

            var eventXml = $(this);
            var eventId = eventXml.find('id').text();
            eventMarkers[eventId] = marker;

            google.maps.event.addListener(marker, 'click', function () {
                Map.showPopup(eventId);
            });
        });
    });
};

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