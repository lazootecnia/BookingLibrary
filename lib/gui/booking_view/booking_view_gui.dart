import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reserve_library/gui/booking_view/booking_view_controller.dart';
import 'package:reserve_library/gui/login/login_controller.dart';

class BookingViewGui extends GetView<BookingViewController> {
  late LoginController loginController;

  BookingViewGui({super.key});

  @override
  Widget build(BuildContext context) {
    loginController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ver Horario Reservado"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Borrar',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Alerta"),
                    content: Text("Esta seguro que desea borrar la reserva?"),
                    actions: [
                      TextButton(
                        child: Text("Aceptar"),
                        onPressed: () {
                          controller.delete();
                        },
                      ),
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  );
                  ;
                },
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(
          () => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    _tile(Icons.person, "Nombre:",
                        "${controller.booking.value.lastName} ${controller.booking.value.name}"),
                    _tile(
                        Icons.person, "Email:", controller.booking.value.email),
                    _tile(Icons.person, "Hora Inicio:",
                        _dateFormated(controller.booking.value.start)),
                    _tile(Icons.person, "Hora Final:",
                        _dateFormated(controller.booking.value.end)),
                    _tile(Icons.person, "Reserva Biblioteca:",
                        controller.booking.value.hall ? "Si" : "No"),
                    _tile(Icons.person, "Reserva Videoconferencia:",
                        controller.booking.value.videoConference ? "Si" : "No"),
                  ],
                ),
        ),
      ),
    );
  }

  ListTile _tile(IconData? icon, String title, String text) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
      leading: Icon(
        icon,
      ),
    );
  }

  String _dateFormated(DateTime dateTime) {
    return DateFormat("dd/MM/yy HH:mm").format(dateTime);
  }

}
