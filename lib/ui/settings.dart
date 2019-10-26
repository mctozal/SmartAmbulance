
import 'package:flutter/material.dart';



class SettingsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
          title: Text(
        'Settings',
        style: TextStyle(
          fontSize: 16,
        ),
      )), 
       body: ListView(
  children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
      leading: CircleAvatar(
          backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQIY-DSBnzMRXqwKFnrCNTyiAMR2AqeiOb9Y6L9MuEyWNgPQgIK"),
        ),
        title: Text('Dark Mode'),
      ),
        ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://cdn0.iconfinder.com/data/icons/team-and-management-glyph/160/creative-team-512.png"),
            ),
            title: Text('Creators'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage:NetworkImage("https://png.pngtree.com/element_our/sm/20180509/sm_5af29f0524f68.png")),
            title: Text("Contact"),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage:NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR9EraXc--8tPahHj7HYlNSGyFMyXdD5kENptlcy-R5tPIXgBT_")),
            title: Text("About Us"),
          ),
          
      ]
         ).toList(),
        ),
        );
  }
}
