import 'package:flutter/material.dart';
import 'package:smart_ambulance/states/hospitalState.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:url_launcher/url_launcher.dart';

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
//aa
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
                                            height: 5.0,
                                          ),
                                          Wrap(
                                            spacing: 2.0,
                                            runSpacing: 5.0,
                                            children: <Widget>[  
                                              IconButton(
                                            icon: Icon(Icons.local_hospital),
                                            onPressed: () => showDialog(context: context,builder: (context){
                                              return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                              elevation: 16,
                                              child: Container(height: 300.0,
                                              width: 360.0,
                                              child: ListView(children: <Widget>[
                                                SizedBox(height: 20,),
                                                Center(child: Text(
                                                '\t\t Information Of Hospital\n\nSurger Availability : '+
                                                  hospitalState.surgeryRoom(
                                                      snapshot.data[index].destinationId)+'\n\n'+
                                                      'Doctor Availability : '+
                                                  hospitalState.availableDoctors(snapshot.data[index].destinationId)+'\n\n'+
                                                     'Emergency Availability : '+
                                                      hospitalState.emergency(snapshot.data[index].destinationId),                                     
                                                style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),)
                                                ,)
                                                ],)
                                                ,)
                                               ,);
                                            })  
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.phone),
                                            onPressed: () => _callPhone(hospitalState.phone(snapshot.data[index].destinationId)),
                                          ),
                                              Text(
                                                  '${snapshot.data[index].destinationAddress}'),
                                            ],
                                            
                                          ),
                                         
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


  _callPhone(String phone) async {
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not Call Phone';
    }
  }