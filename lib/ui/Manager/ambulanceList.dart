import 'package:flutter/material.dart';
import 'package:smart_ambulance/model/users.dart';
import 'package:smart_ambulance/states/managerState.dart';

class AmbulanceList extends StatelessWidget {
  const AmbulanceList({
    Key key,
    @required this.managerState,
  }) : super(key: key);

  final ManagerState managerState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: FutureBuilder<List<User>>(
            future: managerState.fetchAllUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data[index].name),
                    leading: snapshot.data[index].isOnline == true
                        ? Icon(Icons.offline_bolt)
                        : Icon(Icons.offline_pin),
                    trailing: Text(snapshot.data[index].mail),
                  ),
                );
            }),
      ),
    );
  }
}
