function setMap(div, mapLatitude, mapLongitude, zoom) {
    var myOptions = {
        zoom: zoom,
        center: new google.maps.LatLng(mapLatitude, mapLongitude),
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    return new google.maps.Map(document.getElementById(div), myOptions);
    $.ajax({
        url: '/neighborhoods.xml',
        dataType: 'xml'
    }).success(function (data) {
        var latitude = 0;
        var longitude = 0;
        $(data).find('neighborhood').each(function() {
            latitude = $(this).find('latitude').text();
            longitude = $(this).find('longitude').text();
        });
        
    }).error(function (error) {
        $('#'+div).append(error);
    });
}