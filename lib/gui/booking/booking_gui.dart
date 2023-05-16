import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reserve_library/gui/booking/booking_controller.dart';

class BookingGui extends GetView<BookingController> {
  BookingGui({super.key});
  bool dobleClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Reservar Horario"),
        ),
        body: Center(
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(DateFormat('dd/MM/yyyyy').format(controller.now)),
                ),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    //https://www.fluttercampus.com/guide/40/how-to-show-time-picker-on-textfield-tap-and-get-formatted-time-in-flutter/
                    TimeOfDay? pickedTime = await showTimePicker(

                      context: context,
                        initialTime: controller
                            .getTimeOfDay(controller.startTimeController),
                    );
                    if (pickedTime != null) {
                      controller.processStart(pickedTime);
                    } else {
                      print("Time is not selected");
                    }
                  },
                  controller: controller.startTimeController,
                  decoration: const InputDecoration(labelText: 'Hora inicial'),
                  validator: controller.startDateValidator,
                ),
                TextFormField(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: controller
                            .getTimeOfDay(controller.endTimeController));
                    if (pickedTime != null) {
                      print(pickedTime);
                      controller.processEnd(pickedTime);
                    } else {
                      print("Time is not selected");
                    }
                  },
                  controller: controller.endTimeController,
                  decoration: const InputDecoration(labelText: 'Hora final'),
                  validator: controller.endDateValidator,
                ),
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: controller.validator,
                ),
                TextFormField(
                  controller: controller.lastNameController,
                  decoration: const InputDecoration(labelText: 'Apellido'),
                  validator: controller.validator,
                ),
                TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: controller.emailValidator),
                FormField(
                  initialValue: controller.hall,
                  builder: (FormFieldState<bool> field) {
                    return SwitchListTile(
                      value: controller.hall,
                      title: Text("Sala"),
                      onChanged: (value) {
                        controller.hall = !controller.hall;
                        field.didChange(value);
                        Get.log("value ${controller.hall}");
                      },
                    );
                  },
                ),
                FormField(
                  validator: controller.videoConferenceValidator,
                  initialValue: controller.videoConference,
                  builder: (FormFieldState<bool> field) {
                    return InputDecorator(
                        decoration: InputDecoration(
                          errorText: field.errorText,
                        ),
                        child: SwitchListTile(
                          value: controller.videoConference,
                          title: Text("Equipo de Video Conferencia"),
                          onChanged: (value) {
                            controller.videoConference =
                                !controller.videoConference;
                            field.didChange(value);
                            Get.log("value ${controller.videoConference}");
                          },
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (controller.loginFormKey.currentState!.validate() && !dobleClick) {
              dobleClick = true;
              controller.save();
            }
          },
          tooltip: 'Guardar',
          child: const Icon(Icons.check),
        ));
  }
}
