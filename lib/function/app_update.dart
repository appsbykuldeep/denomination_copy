import 'dart:async';

import 'package:denomination_app/constants/custom_libs.dart';
import 'package:in_app_update/in_app_update.dart';

Future<void> checkForUpdate() async {
  try {
    final status = await InAppUpdate.checkForUpdate();

    if (status.updateAvailability == UpdateAvailability.updateAvailable) {
      InAppUpdate.performImmediateUpdate();
    }
  } catch (e) {
    debugPrint("checkForUpdate : $e");
  }
}
