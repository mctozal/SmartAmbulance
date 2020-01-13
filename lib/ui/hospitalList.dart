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
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            final hospitalState =
                Provider.of<HospitalState>(context, listen: false);
            hospitalState.listDistance.clear();
            Navigator.of(context).pop();
          },
        ),
      ),
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
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 16.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 50,
                                                width: 160,
                                                child: Text(
                                                  hospitalState.hospitalName(
                                                      snapshot.data[index]
                                                          .destinationId),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Wrap(
                                            spacing: 2.0,
                                            runSpacing: 10.0,
                                            children: <Widget>[
                                              Icon(
                                                Icons.local_hospital,
                                                size: 25,
                                              ),
                                              Text(
                                                  '${snapshot.data[index].destinationAddress}'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10.0,
                                    right: 0.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            '${snapshot.data[index].duration} sec',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${snapshot.data[index].distance} meter ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                                color: Colors.grey),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.directions),
                                            onPressed: () => hospitalState
                                                .showDetailedHospital(
                                                    snapshot.data[index]
                                                        .destinationId,
                                                    context),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
