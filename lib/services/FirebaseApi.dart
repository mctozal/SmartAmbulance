import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  // This class will be used for every request from Firestore
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  FirebaseApi(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data, String id) {
    return ref.document(id).setData(data);
  }
    Future<void> addDocument2(Map data, String id) {
    return ref.document(id).setData(data);   // dongu ile hastane eklemek icin eklendi
  }
  Future<DocumentReference> updateDocument(Map data, String id) {
    if (data['isOnline'] == null) {
      data.remove('isOnline');
    }
    if (data['name'] == null) {
      data.remove('name');
    }
    if (data['position'] == null) {
      data.remove('position');
    }
    if (data['role'] == null) {
      data.remove('role');
    }
    if (data['time'] == null) {
      data.remove('time');
    }
    if (data['uid'] == null) {
      data.remove('uid');
    }
     if (data['mail'] == null) {
      data.remove('mail');
    }
    if (data['password'] == null) {
      data.remove('password');
    }
    return ref.document(id).updateData(data);
  }
}
