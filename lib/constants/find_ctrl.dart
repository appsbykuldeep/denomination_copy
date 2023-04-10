import 'package:denomination_app/common_controllers/denomination_ctrl.dart';
import 'package:denomination_app/local_db/local_db_ctrl.dart';
import 'package:get/get.dart';

class FindCtrl {
  static DenominationCtrl denomination = Get.find<DenominationCtrl>();
  static LocalDbCtrl localdb = Get.find<LocalDbCtrl>();
}
