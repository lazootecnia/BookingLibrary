import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  var login = false.obs;
  var admin = false.obs;

  LoginController() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        login.value = false;
        admin.value = false;
        print('+++++++++++++++++++++++++++++ ${login.value}');

        print('User is currently signed out!');
      } else {
        login.value = true;
        _isAdmin(user.email);
      }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

  _isAdmin(String? email) {
    Get.log("Verifico si es admin");
    if (admin != null) {
      final docRef = _usersCollection.doc(email);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          if (data["roles"] == "admin") {
            admin.value = true;
          } else {
            admin.value = false;
          }
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }
}
