import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as geoloc;
import 'package:map_view/map_view.dart';

import '../main.dart';
import '../ui/login_screen.dart';

class CustomerMap extends StatefulWidget {
  final FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  _CustomerMapState createState() => _CustomerMapState();
}

class _CustomerMapState extends State<CustomerMap> {
  //MapView mapView = new MapView();
  //CameraPosition cameraPosition;
  //var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri _staticMapUri;
  LocationData _locationData;
  RouteInfo _routeInfo;

  final FocusNode _addressInputFocusNode = FocusNode();
  final TextEditingController _addressInputController = TextEditingController();

  @override
  initState() {
    //getStaticMap();
    getStaticMap(data['Company Address']);
    _addressInputFocusNode.addListener(_updateLocation);
    _routeInfo = RouteInfo("", "", "", "");
    super.initState();
//    cameraPosition = new CameraPosition(Locations.portland, 2.0);
//    staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
//        width: 900, height: 400, mapType: StaticMapViewType.roadmap);
  }

  void getStaticMap(String address) async {
    //String address = '${data['Company Address']}';
    if (address.isEmpty) {
      return;
    }
    // String API_KEY = ''; //This is already defined in main.dart so therefore do not need this here again
    final location = geoloc.Location();
    final currentLocation = await location.getLocation();
    //print(data['Company Address']); This prints null
    final Uri uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {
      'address': address,
      'key': API_KEY
    }); //Address hardcoded for now until data issue sorted

    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    //print(decodedResponse);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    //print(formattedAddress);
    //print(decodedResponse);
    final coords = decodedResponse['results'][0]['geometry']['location'];
    _locationData = LocationData(
        //You can toggle between user location and set location using geocode
        address: formattedAddress,
        latitude: coords['lat'],
        //latitude: currentLocation['latitude'],
        longitude: coords['lng']);
    //longitude: currentLocation['longitude']);

    final Uri uri2 =
        Uri.https('maps.googleapis.com', '/maps/api/distancematrix/json', {
      'origins':
          '${currentLocation['latitude']},${currentLocation['longitude']}',
      'destinations': '${_locationData.latitude},${_locationData.longitude}',
      'key': API_KEY
    });
    final http.Response response2 = await http.get(uri2);
    final decodedResponse2 = json.decode(response2.body);

    final distance = decodedResponse2['rows'][0]['elements'][0]['distance'];
    final duration = decodedResponse2['rows'][0]['elements'][0]['duration'];
    final origin = decodedResponse2['origin_addresses'][0];
    final destination = decodedResponse2['destination_addresses'][0];

    _routeInfo =
        RouteInfo(duration['text'], distance['text'], destination, origin);

    final StaticMapProvider staticMapProvider = StaticMapProvider(API_KEY);
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers([
      Marker('position', 'Position', _locationData.latitude,
          _locationData.longitude),
      Marker('position', 'Position', currentLocation['latitude'],
          currentLocation['longitude']),
    ],
        center: Location(_locationData.latitude, _locationData.longitude),
        width: 900,
        height: 600,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      _addressInputController.text = _locationData.address;
      _staticMapUri = staticMapUri;
    });
  }

  void _updateLocation() {
    if (!_addressInputFocusNode.hasFocus) {
      getStaticMap(_addressInputController.text);
      //getStaticMap(data['Company Address']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Map View"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
            alignment: Alignment.topCenter,
            child: ListView(children: <Widget>[
              new Padding(padding: const EdgeInsets.all(1.0)),
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _staticMapUri == null
                        ? Container()
                        : Image.network(_staticMapUri.toString()),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    new Center(
                      child: Text(
                        "Origin: ${_routeInfo.origin}",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    Text(
                      "Destination: ${_routeInfo.destination}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    Text(
                      "Distance from Origin: ${_routeInfo.distance}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    Text(
                      "Estimated Time: ${_routeInfo.duration}",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]),
            ])

//        body: new Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            EnsureVisibleWhenFocused(
//              focusNode: _addressInputFocusNode,
//              child: TextFormField(
//                focusNode: _addressInputFocusNode,
//                controller: _addressInputController,
//                validator: (String value) {
//                  if (_locationData == null || value.isEmpty) {
//                    return 'No valid location found.';
//                  }
//                },
//                decoration: InputDecoration(labelText: 'Address'),
//              ),
//            ),
//
//            SizedBox(
//              height: 10.0,
//            ),
//            _staticMapUri == null
//                ? Container()
//                : Image.network(_staticMapUri
//                    .toString()), //this throws an error first time around, need to look at
//          ],
////          children: <Widget>[
////            new Container(
////              height: 250.0,
////              child: new Stack(
////                children: <Widget>[
////                  new Center(
////                      child: new Container(
////                    child: new Text(
////                      "You are supposed to see a map here.\n\nAPI Key is not valid.\n\n"
////                          "To view maps in the example application set the "
////                          "API_KEY variable in example/lib/main.dart. "
////                          "\n\nIf you have set an API Key but you still see this text "
////                          "make sure you have enabled all of the correct APIs "
////                          "in the Google API Console. See README for more detail.",
////                      textAlign: TextAlign.center,
////                    ),
////                    padding: const EdgeInsets.all(20.0),
////                  )),
////                  new InkWell(
////                    child: new Center(
////                      child: new Image.network(_staticMapUri.toString()),
////                    ),
////                    onTap: showMap,
////                  )
////                ],
////              ),
////            ),
////            new Container(
////              padding: new EdgeInsets.only(top: 10.0),
////              child: new Text(
////                "Tap the map to interact",
////                style: new TextStyle(fontWeight: FontWeight.bold),
////              ),
////            ),
////            new Container(
////              padding: new EdgeInsets.only(top: 25.0),
////              child: new Text("Camera Position: \n\nLat: ${cameraPosition.center
////                  .latitude}\n\nLng:${cameraPosition.center
////                  .longitude}\n\nZoom: ${cameraPosition.zoom}"),
////            ),
////          ],
//        ));
            ));
  }

//  showMap() {
//    mapView.show(
//        new MapOptions(
//            mapViewType: MapViewType.normal,
//            showUserLocation: true,
//            initialCameraPosition: new CameraPosition(
//                new Location(45.5235258, -122.6732493), 14.0),
//            title: "Recently Visited"),
//        toolbarActions: [new ToolbarAction("Close", 1)]);
//  }
}

class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  LocationData({this.latitude, this.longitude, this.address});
}

class RouteInfo {
  final String duration;
  final String distance;
  final String origin;
  final String destination;

  RouteInfo(this.duration, this.distance, this.destination, this.origin);
}
