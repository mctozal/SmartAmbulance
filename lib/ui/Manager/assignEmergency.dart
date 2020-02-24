import 'package:flutter/material.dart';
import 'package:smart_ambulance/model/patientInfo.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_ambulance/states/managerState.dart';
import 'package:provider/provider.dart';

class AssignEmergency extends StatelessWidget {
  const AssignEmergency({
    Key key,
    @required this.managerState,
  }) : super(key: key);

  final ManagerState managerState;

  @override
  Widget build(BuildContext context) {
    final mapState = Provider.of<MapState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: FutureBuilder<List<Patient>>(
            future: managerState.fetchAllEmergency(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data[index].name),
                    leading: snapshot.data[index].name.isNotEmpty
                        ? Icon(Icons.error_outline)
                        : Icon(Icons.error_outline),
                    trailing: Text(snapshot.data[index].address),
                    onTap: () {
                      double destLat = snapshot.data[index].latitude;
                      double desLon = snapshot.data[index].longitude;
                      final url =
                          //'https://www.google.com/maps/dir/?api=1&origin=${snapshot.data[index].originAddress}&destination=${snapshot.data[index].destinationAddress}&travelmode=driving';
                          'https://www.google.com/maps/dir/?api=1&origin=${mapState.initialPosition.latitude},${mapState.initialPosition.longitude}&destination=${destLat},${desLon}&travelmode=driving';
                      _launchURL(url);
                    },
                  ),
                );
            }),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
