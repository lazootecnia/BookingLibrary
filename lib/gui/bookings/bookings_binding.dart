import 'package:get/get.dart';
import 'package:reserve_library/gui/bookings/bookings_controller.dart';

class BookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingsController>(BookingsController(), permanent: true);
  }
}
