import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/authenticationState.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  MapType type;
  bool traffic;

  @override
  void initState() {
    super.initState();
    type = MapType.normal;
    traffic = false;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MapState>(context);
    return appState.initialPosition == null
        ? Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: appState.initialPosition, zoom: 15),
                onMapCreated: appState.onMapCreated,
                trafficEnabled: traffic,
                myLocationButtonEnabled: true,
                mapType: type,
                polylines: appState.polyLines,
                compassEnabled: true,
                markers: appState.marker,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0)),
                    color: Colors.blue,
                    onPressed: () async {
                      // show input autocomplete with selected mode
                      // then get the Prediction selected
                      Prediction prediction = await PlacesAutocomplete.show(
                          components: [new Component(Component.country, "tr")],
                          language: "tr",
                          mode: Mode.overlay,
                          context: context,
                          apiKey: appState.apiKey);
                      appState.sendRequest(prediction, context);
                    },
                    child: Icon(Icons.search),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 5,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(100.0)),
                  child: Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    // traffic information changes
                    setState(() {
                      type = type == MapType.hybrid
                          ? MapType.normal
                          : MapType.hybrid;
                    });
                  },
                ),
              ),
              Positioned(
                  top: 90,
                  right: 5,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0)),
                    child: Icon(Icons.my_location, color: Colors.white),
                    color: Colors.blue,
                    onPressed: () {
                      final authenticationState =
                          Provider.of<AuthenticationState>(context);
                      appState.addGeoPoint(authenticationState.uids);
                    },
                  )),
              Positioned(
                top: 130,
                right: 5,
                child: Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0)),
                    color: Colors.blue,
                    onPressed: () async {
                      appState.showAmbulances(context);
                    },
                    child: Icon(
                      Icons.equalizer,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 170,
                right: 5,
                child: Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0)),
                    color: Colors.blue,
                    onPressed: () async {
                      appState.showEmergency(context);
                    }, //ss
                    child: Icon(
                      Icons.accessible_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
