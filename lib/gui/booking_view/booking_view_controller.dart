import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserve_library/data/booking.dart';

class BookingViewController extends GetxController {
  final CollectionReference _bookingCollection =
      FirebaseFirestore.instance.collection('bookings');

  late Rx<Booking> booking;
  var loading = true.obs;

  BookingViewController() {}

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Get.log("Se paso el parametro : ${Get.arguments}");
    if (Get.arguments != null) {
      final docRef = _bookingCollection.doc(Get.arguments);
      docRef.get().then(
        (DocumentSnapshot doc) {
          if (doc.exists) {
            booking = Rx(Booking.fromDocumentSnapshot(
                doc as DocumentSnapshot<Map<String, dynamic>>));
            loading.value = false;
          } else {
            Get.offAllNamed("/");
            Get.snackbar(
              "Error",
              "No se encontró una reserva",
              icon: const Icon(Icons.add_alert),
            );
          }
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } else {
      Get.log("No se paso parametro para la reserva");
      Get.offAllNamed("/");
      Get.snackbar(
        "Error",
        "No se selecciono ninguna reserva.",
        icon: const Icon(Icons.add_alert),
      );
    }
  }

  void delete() {
    if (!booking.isBlank!) {
      final docRef = _bookingCollection.doc(booking.value.uuid);
      docRef.delete().then(
        (doc) {
          Get.offAllNamed("/", arguments: booking.value.start);
          Get.snackbar(
            "Información",
            "Se borro correctamente la reserva.",
            icon: const Icon(Icons.info),
          );
        },
        onError: (e) => print("Error getting document: $e"),
      );
    } else {
      Get.log("No se paso parametro para la reserva");
      Get.offAllNamed("/");
      Get.snackbar(
        "Error",
        "No se selecciono ninguna reserva.",
        icon: const Icon(Icons.add_alert),
      );
    }
  }
}
