/*
import 'package:flutter/material.dart';
import 'package:smart_ambulance/states/hospitalState.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:smart_ambulance/ui/hospitalList.dart';

  bool  _isChecked = false;
  String roomAvailable="Not Available";
  String doctorAvailable = "Available";
  String  distance='5000';
  

class FilterUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter Hospitals',
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
      body: FilterPage(),
    );
  }
}

  

class FilterPage extends StatefulWidget{
  @override
  _FilterPageState createState()=> _FilterPageState();
}

class _FilterPageState extends State<FilterPage>
{
  

void onChanged(bool value)
{
  setState(() {
    _isChecked=value;
  });
  if(_isChecked==true)
    {
      roomAvailable="Available";
    }
  
}

  @override
  Widget build(BuildContext context) {
        final hospitalState = Provider.of<HospitalState>(context);
    final mapState = Provider.of<MapState>(context, listen: false);
   return  
   Scaffold(body:new Container(
     padding: new EdgeInsets.all(32.0),
     child: new Center(
       child: 
       new Column(
         children: <Widget>[
           new Row(
             children: <Widget>[
               new Text("Avaible Surgery:"),
                new Checkbox(value: _isChecked, onChanged: (bool value ){onChanged(value);},),
             ],
           ),
           new Row(
             children: <Widget>[
             new Text("Select Available Doctor:  "),            
               DropdownButton<String>(
                    value: doctorAvailable,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.deepPurple
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        doctorAvailable = newValue;
                      });
                    },
                    items: <String>["Available", "Not Available"]
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                  ),
                          ],),
                            new Row(
             children: <Widget>[
             new Text("Selecet Distance For Hospital(Meter):  "),            
               DropdownButton<String>(
                    value: distance,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.deepPurple
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        distance = newValue;
                      });
                    },
                    items: <String>['5000','10000', '20000', '30000']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                  ),
                          ],),
                          Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () => {hospitalState.showDistance(mapState.initialPosition,distance: 5000,doctorAvailable: doctorAvailable,roomAvailable: roomAvailable),
                         Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalUI()),
                )
                  }
                                            
                ),
                          ),
         ],
         
       ),
     ),
     
   ),
   );
}
    
  }
  

*/