import 'package:flutter/material.dart';

class ManagerState with ChangeNotifier {
  var _uid = <String>[];
  get uid => _uid;

  ManagerState() {}

  getUserId(uid) {
    _uid.add('value');
    return _uid.add(uid) ;
  }
}
