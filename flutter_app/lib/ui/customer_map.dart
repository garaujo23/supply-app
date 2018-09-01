import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';
import '../ui/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class CustomerMap extends StatefulWidget {
  @override
  _CustomerMapState createState() => _CustomerMapState();
}

class _CustomerMapState extends State<CustomerMap> {
  //MapView mapView = new MapView();
  //CameraPosition cameraPosition;
  //var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri _staticMapUri;

  @override
  initState() {
    getStaticMap();
    super.initState();
//    cameraPosition = new CameraPosition(Locations.portland, 2.0);
//    staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
//        width: 900, height: 400, mapType: StaticMapViewType.roadmap);

  }
  
  void getStaticMap() async {

    final Uri uri = Uri.https('maps.googleapis.com', '/maps/api/geocode/json', {'address': data['Company Address'], 'key': API_KEY});
    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    print(decodedResponse);
    final coords = decodedResponse['results'][0]['geometry']['location'];


    final StaticMapProvider staticMapProvider = StaticMapProvider(API_KEY);
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers([
      Marker('position', 'Position', 45.5235258, -122.6732493)
    ], center: Location(45.5235258, -122.6732493),
    width: 900, height: 400,
    maptype: StaticMapViewType.roadmap);
    setState(() {
      _staticMapUri = staticMapUri;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Map View"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Image.network(_staticMapUri.toString())
          ],
//          children: <Widget>[
//            new Container(
//              height: 250.0,
//              child: new Stack(
//                children: <Widget>[
//                  new Center(
//                      child: new Container(
//                    child: new Text(
//                      "You are supposed to see a map here.\n\nAPI Key is not valid.\n\n"
//                          "To view maps in the example application set the "
//                          "API_KEY variable in example/lib/main.dart. "
//                          "\n\nIf you have set an API Key but you still see this text "
//                          "make sure you have enabled all of the correct APIs "
//                          "in the Google API Console. See README for more detail.",
//                      textAlign: TextAlign.center,
//                    ),
//                    padding: const EdgeInsets.all(20.0),
//                  )),
//                  new InkWell(
//                    child: new Center(
//                      child: new Image.network(_staticMapUri.toString()),
//                    ),
//                    onTap: showMap,
//                  )
//                ],
//              ),
//            ),
//            new Container(
//              padding: new EdgeInsets.only(top: 10.0),
//              child: new Text(
//                "Tap the map to interact",
//                style: new TextStyle(fontWeight: FontWeight.bold),
//              ),
//            ),
//            new Container(
//              padding: new EdgeInsets.only(top: 25.0),
//              child: new Text("Camera Position: \n\nLat: ${cameraPosition.center
//                  .latitude}\n\nLng:${cameraPosition.center
//                  .longitude}\n\nZoom: ${cameraPosition.zoom}"),
//            ),
//          ],
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
