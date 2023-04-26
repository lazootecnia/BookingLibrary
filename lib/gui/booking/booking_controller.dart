import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reserve_library/data/booking.dart';

class BookingController extends GetxController {
  final CollectionReference _bookingCollection =
      FirebaseFirestore.instance.collection('bookings');
  late DateTime now;

  final String FORMAT_HOUR = "H:mm";

  final loginFormKey = GlobalKey<FormState>();

  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  bool hall = true;

  late bool videoConference = false;

  BookingController() {
    now = DateTime.now();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) now = Get.arguments[0];
  }

  void save() {
    Booking booking = Booking(
        start: _date(now, startTimeController.value.text),
        end: _date(now, endTimeController.value.text),
        name: nameController.value.text,
        lastName: lastNameController.value.text,
        email: emailController.value.text,
        hall: hall,
        videoConference: videoConference);

    Get.log("Datos a Guardar: ${booking.toMap()}");

    _bookingCollection.add(booking.toMap()).then(
      (value) {
        Get.log("Save Booking");

        Get.back();
        Get.offNamed("/");

        Get.snackbar(
          'Reserva Guardada',
          'Se guardó correctamente la reserva',
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
          icon: const Icon(Icons.info_outline),
          duration: const Duration(seconds: 3),
        );
      },
    ).catchError(
      (error) {
        Get.log("Error al guardar la reserva: $error");
        Get.snackbar(
          'Error',
          'Se produjo un error en la reserva.',
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
          icon: const Icon(Icons.error_outline),
          duration: const Duration(seconds: 3),
        );
      },
    );
  }

  String? validator(String? value) {
    if (value!.isEmpty) {
      return 'No puede dejar el campo vacío.';
    }
    return null;
  }

  String? startDateValidator(String? value) {
    if (value!.isEmpty) {
      return 'No puede dejar el campo vacío.';
    }
    return null;
  }

  String? endDateValidator(String? value) {
    if (value!.isEmpty) {
      return 'No puede dejar el campo vacío.';
    }
    DateTime start = _date(now, startTimeController.value.text);
    DateTime end = _date(now, endTimeController.value.text);
    if (start.compareTo(end) != -1) {
      return 'La fecha inicial no puede ser menor o igual a la fecha final';
    }

     return null;
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'El mail no debe estar vacío.';
    }
    if (!EmailValidator.validate(value)) {
      return "El mail no es válido.";
    }

    return null;
  }

  String? videoConferenceValidator(bool? value) {
    if (value! && !hall) {
      return 'Se debe seleccionar la Sala.';
    }
    return null;
  }

  processStart(TimeOfDay? pickedTime) {
    if (pickedTime != null) {
      DateTime dateTime = DateTime.utc(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      startTimeController.text = _dateFormated(dateTime);
      if (endTimeController.text.isEmpty) {
        endTimeController.text = _dateFormated(dateTime);
      }
    }
  }

  processEnd(TimeOfDay? pickedTime) {
    if (pickedTime != null) {
      DateTime dateTime = DateTime.utc(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      endTimeController.text = _dateFormated(dateTime);
    }
  }

  TimeOfDay getTimeOfDay(TextEditingController controller) {
    if (controller.value.text.isEmpty) {
      return TimeOfDay.now();
    } else {
      Get.log("${controller.value.text} - ${DateFormat(FORMAT_HOUR).parse(controller.value.text)} - ${DateFormat.Hm().parse(controller.value.text)}");

      return TimeOfDay.fromDateTime(
          DateFormat(FORMAT_HOUR).parse(controller.value.text));
    }
  }

  String _dateFormated(DateTime dateTime) {
    return DateFormat(FORMAT_HOUR).format(dateTime);
  }

  DateTime _date(DateTime date, String time) {
    DateTime hours = DateFormat('HH:mm').parse(time);
    return DateTime(date.year, date.month, date.day, hours.hour, hours.minute);
  }
}
