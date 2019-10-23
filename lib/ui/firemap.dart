import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/mapState.dart';

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
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
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                polylines: appState.polyLines,
                compassEnabled: true,
                markers: appState.marker,
              ),
              Positioned(
                right: 10,
                bottom: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: <Widget>[
                    FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0)),
                        child: Icon(Icons.pin_drop, color: Colors.white),
                        color: Colors.blue,
                        onPressed: appState.addGeoPoint),
                    Container(
                      width: 200,
                      height: 50,
                      child: TextField(
                        controller: appState.destinationController,
                        enabled: true,
                        cursorColor: Colors.blue,
                        maxLength: 20,
                        onChanged: (value){appState.sendRequest(value);},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          semanticCounterText: 'Hospital name',
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
