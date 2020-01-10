import 'package:flutter/material.dart';
import 'package:smart_ambulance/states/hospitalState.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/mapState.dart';

class HospitalUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Nearby Hospitals',
        style: TextStyle(
          fontSize: 16,
        ),
      )),
      body: HospitalList(),
    );
  }
}

class HospitalList extends StatefulWidget {
  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  @override
  Widget build(BuildContext context) {
    final hospitalState = Provider.of<HospitalState>(context);
    final mapState = Provider.of<MapState>(context, listen: false);
    return hospitalState.list.isNotEmpty
        ? Scaffold(
            body: FutureBuilder(
                future: hospitalState.showDistance(mapState.initialPosition),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData == true
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            hospitalState
                                .showDistance(mapState.initialPosition);
                            return ListTile(
                              title: Text(
                                  snapshot.data[index].duration.toString() +
                                      ' duration(sec)'), 
                              subtitle: Text(
                                  snapshot.data[index].distance.toString() + ' meter (m)'),
                            );
                          },
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                }))
        : Positioned(child: Container());
  }
}
