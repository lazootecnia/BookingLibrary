import 'package:get/get.dart';
import 'package:reserve_library/gui/booking_view/booking_view_controller.dart';

class BookingViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingViewController>(BookingViewController());
  }
}
