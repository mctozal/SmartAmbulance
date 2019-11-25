import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/states/authenticationState.dart';
import 'package:smart_ambulance/states/settingState.dart';

class SettingsUI extends StatefulWidget {
  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    final settingState = Provider.of<SettingState>(context);
    final authenticationState = Provider.of<AuthenticationState>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Settings',
        style: TextStyle(
          fontSize: 16,
        ),
      )),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQIY-DSBnzMRXqwKFnrCNTyiAMR2AqeiOb9Y6L9MuEyWNgPQgIK"),
              ),
              title: Text('Dark Mode'),
              trailing: ChangeNotifierProvider<SettingState>(
                builder: (_) => SettingState(),
                child: Switch(
                  value: settingState.darkModeEnabled,
                  onChanged: (newValue) {
                    settingState.setTheme(newValue);
                  },
                ),
              )),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn0.iconfinder.com/data/icons/team-and-management-glyph/160/creative-team-512.png"),
            ),
            title: Text('Creators'),
          ),
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://png.pngtree.com/element_our/sm/20180509/sm_5af29f0524f68.png")),
            title: Text("Contact"),
          ),
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcR9EraXc--8tPahHj7HYlNSGyFMyXdD5kENptlcy-R5tPIXgBT_")),
            title: Text("About Us"),
          ),
          ListTile(
            onTap: () async {
              await authenticationState.signOut();
              final current = ModalRoute.of(context);
              Navigator.removeRoute(context, current);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.redAccent,
            ),
            title: Text("Sign Out"),
          ),
        ]).toList(),
      ),
    );
  }
}
