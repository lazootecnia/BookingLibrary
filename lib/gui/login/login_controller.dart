import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var admin = false.obs;

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}
