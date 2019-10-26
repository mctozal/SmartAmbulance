import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {

  MapType type ;

  @override
  void initState() {
    super.initState();
    type= MapType.normal;
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
                initialCameraPosition: CameraPosition(
                    target: LatLng(40.990178, 28.8233053), zoom: 15),
                onMapCreated: appState.onMapCreated,
                trafficEnabled: true,
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
                      appState.sendRequest(prediction);
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
                      type = type == MapType.hybrid ? MapType.normal : MapType.hybrid;
                    });
                  },
                ),
              ),
              Positioned(
                top: 90,
                right: 5,
                child: Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0)),
                    color: Colors.blue,
                    onPressed: () async {
                      appState.showHospitals(context);
                    },
                    child: Icon(
                      Icons.local_hospital,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 130,
                right: 5,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(100.0)),
                    child: Icon(Icons.my_location, color: Colors.white),
                    color: Colors.blue,
                    onPressed: appState.addGeoPoint),
              ),
            ],
          );
  }
}
