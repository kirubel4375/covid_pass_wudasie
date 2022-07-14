import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_pass_wudasie/Models/info_model.dart';

import '../Models/user_model.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  uploadInfo(String email, bool result) async {
    try {
      await _firestore
          .collection("users")
          .doc(email)
          .collection("info")
          .doc()
          .set({
        "last_tested": Timestamp.now(),
        "testresult": result,
      });
    } catch (_) {}
  }

  Future<List<UserModel?>> getUsers({String? query}) async {
    List<UserModel?> returnModel = [];
    QuerySnapshot<Map<String, dynamic>> doc = await _firestore.collection("users").get();
    List<Map<String, dynamic>>? data = doc.docs.map((e) => e.data()).toList();
    List<UserModel?> model = data.map((e) => UserModel.fromJson(e)).toList();
    if(query!= null && query.isNotEmpty){
       returnModel.addAll(model.where((element) => element!.email.toLowerCase().contains(query.toLowerCase()) || element.name.toLowerCase().contains(query.toLowerCase())));
    }
    return query!=null && query.isNotEmpty? returnModel: model;
  }

  Future<UserInfo?> getUserInfo(String email, String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection("users")
          .doc(email)
          .collection("info")
          .doc(uid)
          .get();
      Map<String, dynamic>? data = doc.data();
      UserInfo userInfo = UserInfo.fromJson(data!);
      return userInfo;
    } catch (e) {
      return null;
    }
  }

  setUserInfo(String email, String uid, String result)async{
    try{
      await _firestore.collection("users").doc(email).collection("info").doc(uid).set({
        "last_tested": Timestamp.now(),
        "testresult": result == "Negative",
      });
    }catch(_){
      
    }
  }
}
