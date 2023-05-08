import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reserve_library/gui/bookings/bookings_controller.dart';
import 'package:reserve_library/gui/login/login_controller.dart';

class BookingsGui extends GetView<BookingsController> {
  BookingsGui({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Horarios Reservados"),
          actions: <Widget>[
            Obx(
              () => IconButton(
                icon: controller.login.value
                    ? const Icon(Icons.logout_outlined)
                    : const Icon(Icons.login_outlined),
                tooltip: controller.login.value ? 'Salir' : 'Login',
                onPressed: () {
                  if (controller.login.value){
                    Get.log("Desconecto al usuario: ${FirebaseAuth.instance.currentUser!.email}");
                    FirebaseAuth.instance.signOut();

                } else {
                    Get.toNamed("/login");
                  }
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CalendarDatePicker(
                initialDate: controller.now,
                firstDate: controller.firstDate,
                lastDate: controller.lastDate,
                onDateChanged: (newDate) {
                  controller.changeDate(newDate);
                },
                initialCalendarMode: DatePickerMode.day,
              ),
              _list()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("BOOKING", arguments: [controller.now]);
          },
          tooltip: 'Agregar',
          child: const Icon(Icons.add),
        ));
  }

  String _dateFormated(DateTime dateTime) {
    return DateFormat('HH:MM').format(dateTime);
  }

  Widget _list() {
    return GetBuilder<BookingsController>(
      id: "bookings",
      builder: (_) => Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final item = controller.bookings[index];
            return Card(
              child: Column(
                children: [
                  ListTile(
                      title: Text(
                        "${item.lastName} ${item.name}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Desde: ${_dateFormated(item.start)} Hasta: ${_dateFormated(item.end)} "),
                          Text(
                              "Sala: ${item.hall ? 'Si' : 'No'}, Video Conferencia: ${item.videoConference ? 'Si' : 'No'} "),
                        ],
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
