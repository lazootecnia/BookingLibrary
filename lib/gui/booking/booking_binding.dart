import 'package:get/get.dart';
import 'package:reserve_library/gui/booking/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingController>(BookingController());
  }
}
