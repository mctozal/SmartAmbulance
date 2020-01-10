import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/model/users.dart';
import 'package:smart_ambulance/services/FirebaseApi.dart';
import 'package:smart_ambulance/model/hospitalsInfo.dart';

class CRUDState  {

  FirebaseApi _firebaseApi = new FirebaseApi('users');
   FirebaseApi _firebaseApi2 = new FirebaseApi('hospitalsInfo');

  List<User> products;

  Future<List<User>> fetchProducts() async {
    var result = await _firebaseApi.getDataCollection();
    products = result.documents
        .map((doc) => User.fromMap(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _firebaseApi.streamDataCollection();
  }

  Future<User> getProductById(String id) async {
    var doc = await _firebaseApi.getDocumentById(id);
    return  User.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
     await _firebaseApi.removeDocument(id) ;
     return ;
  }

  Future updateProduct(User data,String id) async{
    await _firebaseApi.updateDocument(data.toMap(), id) ;
    return ;
  }

  Future addProduct(User data,String uid) async{
    var result  = await _firebaseApi.addDocument(data.toMap(),uid);
    return result;
  }

   Future addHospital(HospitalsInfo data,String uid) async{
    var result  = await _firebaseApi2.addDocument2(data.toMap(),uid);
    return result;
  }


}

