import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfoMap);
  }

  Future updateUserWallet(String id, String amount) async {
    debugPrint("ID: $id");
    debugPrint("AMOUNT: $amount");
    return await FirebaseFirestore.instance.collection('users').doc(id).update({'Wallet': amount});
  }

  Future addFoodItem(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }
}
