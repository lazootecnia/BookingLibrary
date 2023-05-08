import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reserve_library/data/booking.dart';

class BookingsController extends GetxController {
  final CollectionReference _bookingCollection =
      FirebaseFirestore.instance.collection('bookings');
  late DateTime now;

  late List<Booking> bookings = []; //.obs as List<Booking>;

  var login = true.obs;
  var admin = false.obs;

  BookingsController() {
    now = DateTime.now();
    loadBooks();
    print('+++++++++++++++++++++++++++++ ${login.value}');
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        login.value = false;
        print('+++++++++++++++++++++++++++++ ${login.value}');

        print('User is currently signed out!');
      } else {
        login.value = true;
        print('User is signed in!');
      }
    });
  }

  get firstDate => now.subtract(const Duration(days: 5));

  get lastDate => now.add(const Duration(days: 50));

  void changeDate(DateTime newDate) {
    now = newDate;
    loadBooks();

    update(["bookings"]);
  }

  void loadBooks() async {
    print(DateTime(now.year, now.month, now.day));
    bookings.clear();
    await _bookingCollection
        .where('start',
            isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day))
        .where('start',
            isLessThanOrEqualTo:
                DateTime(now.year, now.month, now.day, 23, 59, 59))
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['name']);
        bookings.add(Booking.fromQuerySnapshot(doc));
      });
    });
    update(["bookings"]);
  }
}
