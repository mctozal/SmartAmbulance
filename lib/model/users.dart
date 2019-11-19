import 'dart:convert';

class User {
  bool isOnline;
  String name;
  dynamic position;
  String role;
  DateTime time;
  String uid;
  String mail;
  String password;
  User({
    this.isOnline,
    this.name,
    this.position,
    this.role,
    this.time,
    this.uid,
    this.mail,
    this.password,
  });

  User copyWith({
    bool isOnline,
    String name,
    dynamic position,
    String role,
    DateTime time,
    String uid,
    String mail,
    String password,
  }) {
    return User(
      isOnline: isOnline ?? this.isOnline,
      name: name ?? this.name,
      position: position ?? this.position,
      role: role ?? this.role,
      time: time ?? this.time,
      uid: uid ?? this.uid,
      mail: mail ?? this.mail,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isOnline': isOnline,
      'name': name,
      'position': position,
      'role': role,
      'time': time,
      'uid': uid,
      'mail': mail,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map,String id) {
    if (map == null) return null;
    return User(
      isOnline: map['isOnline'],
      name: map['name'],
      position: map['position'],
      role: map['role'],
      time: map['time'],
      uid: map['uid'],
      mail: map['mail'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source,String id) => fromMap(json.decode(source),json.decode(id));

  @override
  String toString() {
    return 'User isOnline: $isOnline, name: $name, position: $position, role: $role, time: $time, uid: $uid, mail: $mail, password: $password';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.isOnline == isOnline &&
        o.name == name &&
        o.position == position &&
        o.role == role &&
        o.time == time &&
        o.uid == uid &&
        o.mail == mail &&
        o.password == password;
  }

  @override
  int get hashCode {
    return isOnline.hashCode ^
        name.hashCode ^
        position.hashCode ^
        role.hashCode ^
        time.hashCode ^
        uid.hashCode ^
        mail.hashCode ^
        password.hashCode;
  }
}
