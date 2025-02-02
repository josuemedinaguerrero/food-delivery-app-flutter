import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() {
    return auth.currentUser;
  }

  Future signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  deleteUser() async {
    User user = getCurrentUser();
    user.delete();
  }
}
