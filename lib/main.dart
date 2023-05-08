import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserve_library/gui/booking/booking_binding.dart';
import 'package:reserve_library/gui/booking/booking_gui.dart';
import 'package:reserve_library/gui/booking_view/booking_binding.dart';
import 'package:reserve_library/gui/booking_view/booking_view_gui.dart';
import 'package:reserve_library/gui/bookings/bookings_binding.dart';
import 'package:reserve_library/gui/bookings/bookings_gui.dart';
import 'package:reserve_library/gui/login/login_binding.dart';
import 'package:reserve_library/gui/login/login_controller.dart';
import 'package:reserve_library/gui/login/login_gui.dart';

import 'firebase_options.dart';

late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final providers = [GoogleAuthProvider()];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Reserva de Horas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        initialRoute: "/",
        getPages: [
          GetPage(
            name: "/LOGIN",
            page: () => LoginGui(),
            binding: LoginBinding(),
          ),
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
          GetPage(
            name: "/BOOKING_VIEW",
            page: () => BookingViewGui(),
            binding: BookingViewBinding(),
          ),
        ]);
  }
}

initServices() async {
  print('starting services ...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instance;
  Get.put(LoginController());
  print('All services started...');
}
