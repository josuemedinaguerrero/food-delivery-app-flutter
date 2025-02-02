import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection('users').doc(id).set(userInfoMap);
  }

  Future updateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance.collection('users').doc(id).update({'Wallet': amount});
  }

  Future addFoodItem(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance.collection('items').add(userInfoMap);
  }

  Stream<QuerySnapshot> getFoodItem(String name) {
    return FirebaseFirestore.instance.collection('items').where("Type", isEqualTo: name).snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection('users').doc(id).collection('cart').add(userInfoMap);
  }
}
