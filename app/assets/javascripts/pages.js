// Gets all cafes visible on the map.
function retrievePlaces() {
  clearMarkers();
  $("#cafeList").empty();
  
  var request = {
    bounds: map.getBounds(),
    types: ["cafe", "restaurant"],
  };
  placesService.search(request, function(results, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
      console.log(results);
      
      for (var i = 0; i < results.length; i++) {
        var place = results[i];
        createMarker(place); 
        createListEntry(place)
      }
    } else {
      console.log(status);
    }
  });
}


// From http://code.google.com/apis/maps/documentation/javascript/overlays.html#RemovingOverlays.
function clearMarkers() {
  if (markersArray) {
    for (i in markersArray) {
      markersArray[i].setMap(null);
    }
    markersArray.length = 0;
  }
}


var cafeListEntryTemplate = _.template("<li class='entry'><span><%= place.name %></span><a href='javascript:runTest(\"<%- place.name %>\", \"<%= place.geometry.location.lat() %>\", \"<%= place.geometry.location.lng() %>\", \"<%= place.id %>\")'>run test</a></li>");
function createListEntry(place) {
  var entryHtml = cafeListEntryTemplate({ place: place });
  $("#cafeList").append($(entryHtml));
}


// Puts a marker on the map.
function createMarker(place) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });
  markersArray.push(marker);

  google.maps.event.addListener(marker, "click", function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
  });
}


// Run the bandwidth and speed test.
function runTest(place_name, place_latitude, place_longitude, place_google_id) {
  
  var NDT = document.applets["NDT"];
  var ssid;
  
  // Set up the function to POST results when the applet completes.
  var waitOrSendResults = function() {
    var isReady = NDT.isReady();
    if (isReady == "no") {
      setTimeout(waitOrSendResults, 50);
      return;
    } else if (isReady == "failed") {
      console.log("Error running NDT applet.");
    } else if (isReady == "yes") {
      var uploadMbps = NDT.get_c2sspd();
      var downloadMbps = NDT.get_s2cspd();
      var lossRate = NDT.get_loss();

      uploadTestResults(place_google_id, place_name, place_latitude, place_longitude, uploadMbps, downloadMbps, lossRate, ssid);
      // POST the results.
      console.log("Done!");
    } else {
      console.log("This should never happen.");
    }
  }

  // Run the test, as soon as the applet loads.
  var waitOrRunApplet = function() {
    if (NDT.run_test === undefined) {
      setTimeout(waitOrRunApplet, 50);
      return;
    }

    NDT.run_test();
    waitOrSendResults();
  }
  
  function runActualTest(ssid) {
    $("#ndt-dialog").dialog("option", {
      open: function(event, ui) {
        waitOrRunApplet();
      }
    });
    $("#ndt-dialog").dialog("open");
  }
  
  // First, collect the network's SSID.
  $("#ssid-dialog").dialog("option", {
    buttons: {
      "Run test": function() {
        ssid = $(this).find("input[name='ssid']").val();
        $(this).dialog("close");
        runActualTest(ssid);
      }
    }
  });
  $("#ssid-dialog").dialog("open");
    
}


function uploadTestResults(cafe_google_id, cafe_name, cafe_latitude, cafe_longitude, uploadMbps, downloadMbps, lossRate, ssid) {
  $("#testResults>input[name='cafe[google_id]']").val(cafe_google_id);
  $("#testResults>input[name='cafe[name]']").val(cafe_name);
  $("#testResults>input[name='cafe[latitude]']").val(cafe_latitude);
  $("#testResults>input[name='cafe[longitude]']").val(cafe_longitude);
  $("#testResults>input[name='test_result[upload_mbps]']").val(uploadMbps);
  $("#testResults>input[name='test_result[download_mbps]']").val(downloadMbps);
  $("#testResults>input[name='test_result[loss_rate]']").val(lossRate);
  $("#testResults>input[name='test_result[ssid]']").val(ssid);
  $("#testResults").submit();
}