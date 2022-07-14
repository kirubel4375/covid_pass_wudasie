// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo{
  final Timestamp? last_tested;
  final bool? testresult;

  UserInfo({required this.last_tested, required this.testresult});

  UserInfo.fromJson(Map<String, dynamic> json)
  :last_tested = json["last_tested"],
  testresult = json["testresult"];
}