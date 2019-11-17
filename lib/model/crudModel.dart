import 'package:flutter/foundation.dart';
import 'package:smart_ambulance/services/smartAmbulanceApi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../locator.dart';
import 'users.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<User> products;

  Future<List<User>> fetchProducts() async {
    var result = await _api.getDataCollection();
    products = result.documents
        .map((doc) => User.fromMap(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<User> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  User.fromMap(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
     await _api.removeDocument(id) ;
     return ;
  }

  Future updateProduct(User data,String id) async{
    await _api.updateDocument(data.toMap(), id) ;
    return ;
  }

  Future addProduct(User data) async{
    var result  = await _api.addDocument(data.toMap()) ;
    return ;
  }


}