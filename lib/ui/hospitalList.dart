import 'package:flutter/material.dart';
import 'package:smart_ambulance/states/hospitalState.dart';
import 'package:provider/provider.dart';

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

    return hospitalState.list.isNotEmpty
        ? Scaffold(
            body: FutureBuilder(
                future: hospitalState.showHospitals(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData == true
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(snapshot.data[index].name.toString()),
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
