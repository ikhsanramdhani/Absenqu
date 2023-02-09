import 'package:get/get.dart';

import '../controllers/update_student_controller.dart';

class UpdateStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateStudentController>(
      () => UpdateStudentController(),
    );
  }
}
