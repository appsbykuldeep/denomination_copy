import 'package:denomination_app/constants/const_data.dart';
import 'package:denomination_app/constants/find_ctrl.dart';
import 'package:denomination_app/extenstions/date_time_etxt.dart';
import 'package:denomination_app/extenstions/localdb_ext.dart';
import 'package:denomination_app/extenstions/num_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

extension AppStringExt on String {
  void speak() {
    if (isSpeakMuted) return;
    FindCtrl.denomination.flutterTts.speak(this);
  }

  Future<bool> get gtOpenUrl async {
    return await launchUrl(
      Uri.parse(this),
      mode: LaunchMode.externalApplication,
    );
  }

  Color get denoCategoryColor {
    if (denoSavedCategories[1] == this) return Colors.greenAccent.shade400;
    if (denoSavedCategories[2] == this) return Colors.redAccent.shade400;
    return Get.theme.primaryColor;
  }

  String get gtProperCase {
    return replaceAll(RegExp(' +'), ' ')
        .split(" ")
        .map((str) => inCaps(str))
        .join(" ");
  }

  String inCaps(String value) => value.isNotEmpty
      ? '${value[0].toUpperCase()}${value.toLowerCase().substring(1)}'
      : '';

  DateTime? get convertToDate => DateTime.tryParse(this);
  double get convertTodouble => double.tryParse(this) ?? 0;

  String get gtCurrencyText => convertTodouble.gtCurrencyText;

  String gtcustumDateFormat(String format) =>
      convertToDate.dateFormater(format);
  String get gtDateddmmyyyyhmformat =>
      convertToDate.dateFormater("dd-MMM-yyy hh:mm a");
}
