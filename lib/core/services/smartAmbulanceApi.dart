import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/core/model/users.dart';

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

  Future<DocumentReference> addDocument(Map data,String id) {
    return ref.document(id).setData(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData({'isOnline': data[0].toString()});
  }

}
