import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserve_library/data/booking.dart';

class BookingsController extends GetxController {
  final CollectionReference _bookingCollection =
      FirebaseFirestore.instance.collection('bookings');
  late DateTime now;

  late List<Booking> bookings = []; //.obs as List<Booking>;

  BookingsController() {
    now = DateTime.now();
  }

  @override
  void onReady() {
    super.onReady();
    Get.log("Se paso el parametro : ${Get.arguments}");
    if (Get.arguments != null) now = Get.arguments[0];
    loadBooks();
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

  Future<void> view(String? uuid) async {
    var data = await Get.toNamed("/BOOKING_VIEW", arguments: uuid);
    Get.log("++++++++++++++++++++++++++++++++++++++++++++++++++++++$data");
    if (data is String && data.isNotEmpty && data == "success") {
      Get.snackbar(
        "Información",
        "Se borro correctamente la reserva.",
        icon: const Icon(Icons.info),
      );

      loadBooks();
      update(["bookings"]);
    } else if (data is String) {
      Get.log("No se paso parametro para la reserva");
      Get.snackbar(
        "Error",
        "No se selecciono ninguna reserva.",
        icon: const Icon(Icons.add_alert),
      );
    }
  }

  Future<void> add(DateTime now) async {
    var data = await Get.toNamed("BOOKING", arguments: [now]);

    if (data is String && data.isNotEmpty && data == "success") {
      Get.snackbar(
        "Información",
        "Se guardó correctamente la reserva.",
        icon: const Icon(Icons.info),
      );

      loadBooks();
      update(["bookings"]);
    } else if (data is String) {
      Get.log("Se produjo un error al agregar la reserva");
      Get.snackbar(
        "Error",
        "Se produjo un error al guardar la reserva.",
        icon: const Icon(Icons.add_alert),
      );
    }
  }
}
