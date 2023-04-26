import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reserve_library/gui/bookings/bookings_controller.dart';

class BookingsGui extends GetView<BookingsController> {
  BookingsGui({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Horarios Reservados"),
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
