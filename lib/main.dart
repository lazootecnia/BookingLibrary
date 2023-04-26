import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserve_library/gui/booking/booking_binding.dart';
import 'package:reserve_library/gui/booking/booking_gui.dart';
import 'package:reserve_library/gui/bookings/bookings_binding.dart';
import 'package:reserve_library/gui/bookings/bookings_gui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Reserva de Horas',
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: "/",
        getPages: [
          GetPage(
            name: "/",
            page: () => BookingsGui(),
            binding: BookingsBinding(),
          ),
          GetPage(
            name: "/BOOKING",
            page: () => BookingGui(),
            binding: BookingBinding(),
          ),
        ]);
  }
}

initServices() async {
  print('starting services ...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  Firebase.apps.forEach((e) => print("${e.name}"));


  // FirebaseFirestore.instance

  print('All services started...');
}
