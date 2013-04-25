(function () {

Map = {};

var gMap = null;
var previousInfoWindow = null;
var eventMarkers = {};
var iconSize = 30;
var iconHalfSize = iconSize/2;

Map.setMap = function (div, mapLatitude, mapLongitude, zoom) {
    var myOptions = {
        zoom: zoom,
        center: new google.maps.LatLng(mapLatitude, mapLongitude),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    gMap = new google.maps.Map(document.getElementById(div), myOptions);
};

Map.createMarker = function(latLng, title, draggable, imageStrip, iconLocation) {
    if (imageStrip == null) {
        imageStrip = "/assets/mapNoPage_avail.png";
    }
    if (iconLocation == null) {
        iconLocation = 0;
    }

    // Create a custom marker icon
    var icon = new google.maps.MarkerImage(
        imageStrip,
        new google.maps.Size(iconSize, iconSize), // Image size
        new google.maps.Point(0, iconLocation), // Sprite origin
        new google.maps.Point(iconHalfSize, iconHalfSize) // Mark the item in the middle
        );

    return new google.maps.Marker({
        position: latLng,
        map: gMap,
        title: title,
        draggable: draggable != null,
        animation: google.maps.Animation.DROP,
        icon: icon
        });
}


Map.showMapFromElement = function(element, i, useLetters, eventCallback) {
    var latitude = 0;
    var longitude = 0;

    latitude = element.find('latitude').text();
    longitude = element.find('longitude').text();
    name = element.find('name').text();
    var attending = element.find('user-participates').text();

    var imageStrip = useLetters ?  "mapStrip" : "mapNoPage";
    imageStrip += attending == "true" ? "_signedUp" : "_avail";
    imageStrip = "/assets/" + imageStrip + ".png"

    var latLng = new google.maps.LatLng(latitude, longitude);
    var iconLocation = useLetters ? iconSize*i : 0;

    var eventXml = element;
    var eventId = eventXml.find('id').text();
    eventMarkers[eventId] = Map.createMarker(latLng, name, null, imageStrip, iconLocation);

    if (eventCallback) {
        google.maps.event.addListener(marker, 'click', function () {
            eventCallback(eventId);
        });
    }
}

Map.addMoveableMarker = function(latitude, longitude, dragCallback, dragEndCallback) {
    var latLng = new google.maps.LatLng(latitude, longitude);

    var marker = Map.createMarker(latLng, null, true);

    if (dragCallback != null) {
        google.maps.event.addListener(marker, 'drag', function (event) 
        {
            gMap.panTo(marker.getPosition());
            dragCallback(marker)
        });
    }

    if (dragEndCallback != null) {
        google.maps.event.addListener(marker, 'dragend', function (event) 
        {
            dragEndCallback(marker)
        });
    }

    return marker;
}

Map.addPoints = function (urlSource, useLetters, eventCallback, completeCallback) {
    $.ajax({
        url: urlSource,
        dataType: 'xml'
    }).success(function (data) {
        $(data).find('event').each(function(i) {
            Map.showMapFromElement($(this), i, useLetters, eventCallback)
        });
        if (completeCallback != null)
        {
            completeCallback();
        }
    });
};

Map.centerOnMarker = function(marker) {
    gMap.panTo(marker.getPosition());
}

Map.geocodeMarker = function(marker, address, callback) {
    geocoder = new google.maps.Geocoder();

    geocoder.geocode( { 'address': address }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        gMap.panTo(results[0].geometry.location);

        if (marker) {
            marker.setPosition(results[0].geometry.location);
        }

        if (callback) { 
            callback(results[0].geometry.location); 
        }
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
}

Map.reverseGeocode = function(latLng, callback) {
    geocoder = new google.maps.Geocoder();

    geocoder.geocode( { 'latLng': latLng }, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[0]) {
            callback(results[0].formatted_address);
        } else if (results[1]) {
            callback(results[0].formatted_address);
        }
      }
    });
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