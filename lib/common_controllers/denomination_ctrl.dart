import 'package:denomination_app/constants/const_data.dart';
import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/constants/find_ctrl.dart';
import 'package:denomination_app/extenstions/localdb_ext.dart';
import 'package:denomination_app/extenstions/system_chrome.dart';
import 'package:denomination_app/function/app_update.dart';
import 'package:denomination_app/function/encode_decode_json.dart';
import 'package:denomination_app/models/basic/denomination_model.dart';
import 'package:denomination_app/models/basic/saved_denominations.dart';
import 'package:flutter_tts/flutter_tts.dart';

final _localDb = FindCtrl.localdb;

class DenominationCtrl extends GetxService {
  final homeDenomination = <DenominationModel>[].obs;
  final homeGrandTotal = 0.0.obs;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  TextEditingController remarkCtrl = TextEditingController();
  SavedDenomination deno = SavedDenomination();
  String selectedDenoCategory = denoSavedCategories.first;
  FocusNode totalFocus = FocusNode();

  FlutterTts flutterTts = FlutterTts();

  @override
  void onReady() {
    fullScreenMode();
    checkForUpdate();
    _speachSetup();
    super.onReady();
  }

  @override
  void onClose() {
    homeDenomination.boxSaveLocal();
    super.onClose();
  }

  void setSavedDeno() {
    deno
      ..createOn = DateTime.now().toString()
      ..denominations = homeDenomination
      ..remark = remarkCtrl.text.trim()
      ..denoCategory = selectedDenoCategory
      ..setDenominationJsonStrByList();
  }

  void _speachSetup() async {
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.setSpeechRate(0.5);
  }

  void focusonNex(int index) {
    if ((index + 1) < homeDenomination.length) {
      homeDenomination[index + 1].node.requestFocus();
    } else {
      totalFocus.requestFocus();
    }
  }

  void saveToLocalDb() async {
    setSavedDeno();
    await _localDb.denominationDao.insertSingleDenomination(deno);
    await _localDb.updateSavedDenomination();
    resetHomeDenomination();
  }

  Future<void> shareDenomination() async {
    setSavedDeno();
    await deno.shareDenomination();
  }

  void openEditSavedDeno(SavedDenomination data) {
    deno = data.setDenominationByJsonStr();
    selectedDenoCategory = data.denoCategory;
    homeDenomination.value = deno.denominations;
    setHomeGrandTotal();
    if (deno.denominations.isNotEmpty) {
      Get.back();
    }
  }

  void setHomeDenominationByLocalDb() {
    final dt =
        getDenominationModelList(tryDecodeJsonOrNull("".boxHomeDenomination));
    if (dt.length == indianCurrency.length) {
      homeDenomination.value = dt;
    } else {
      resetHomeDenomination();
    }
    setHomeGrandTotal();
  }

  void setHomeGrandTotal() {
    homeGrandTotal.value = homeDenomination.grandTotal;
    if ((deno.id ?? 0) == 0) {
      homeDenomination.boxSaveLocal();
    }
  }

  void resetHomeDenomination() {
    homeDenomination.value = indianCurrency.map((e) => e.copyWith()).toList();
    homeGrandTotal.value = 0;
    deno = SavedDenomination();
    remarkCtrl.clear();
    "--".boxHomeDenomination;
    selectedDenoCategory = denoSavedCategories.first;
  }
}
