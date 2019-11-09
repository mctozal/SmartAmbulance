import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/managerState.dart';

String email = 'Select an e-mail';

class RoutePanel extends StatefulWidget {
  @override
  _RoutePanelState createState() => _RoutePanelState();
}

class _RoutePanelState extends State<RoutePanel> {
  @override
  Widget build(BuildContext context) {
    final managerState = Provider.of<ManagerState>(context);
    return Scaffold(
        body: Container(height: 700,width: 700,alignment: Alignment.center,
          child: FutureBuilder(
              future: managerState.showUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData == true
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Icon(Icons.adjust),
                            title: Text(snapshot.data[index].toString()),
                          );
                        },
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              }),
        ));
  }
}
