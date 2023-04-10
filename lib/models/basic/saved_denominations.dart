import 'dart:convert';

import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/extenstions/num_ext.dart';
import 'package:denomination_app/extenstions/string_ext.dart';
import 'package:denomination_app/function/encode_decode_json.dart';
import 'package:denomination_app/models/basic/denomination_model.dart';
import 'package:floor/floor.dart';
import 'package:flutter_share/flutter_share.dart';

@entity
class SavedDenomination {
  SavedDenomination(
      {this.id,
      this.createOn = '',
      this.denoCategory = '',
      this.remark = '',
      this.denominationJsonStr = '',
      this.denominations = const []});

  @PrimaryKey(autoGenerate: true)
  int? id;
  String createOn;
  String denoCategory;
  String remark;
  String denominationJsonStr;
  @ignore
  List<DenominationModel> denominations;

  SavedDenomination setDenominationByJsonStr() {
    final data = tryDecodeJsonOrNull(denominationJsonStr);
    if (data != null) {
      denominations = getDenominationModelList(data);
    }
    return this;
  }

  void setDenominationJsonStrByList({
    List<DenominationModel>? data,
  }) {
    denominationJsonStr =
        jsonEncode((data ?? denominations).map((e) => e.toJson()).toList());
  }

  SavedDenomination copyWith({
    int? id,
    String? createOn,
    String? remark,
    List<DenominationModel>? denominationsList,
  }) =>
      SavedDenomination(
        id: id ?? this.id,
        createOn: createOn ?? this.createOn,
        remark: remark ?? this.remark,
        denominationJsonStr: denominationsList == null
            ? denominationJsonStr
            : jsonEncode(denominationsList.map((e) => e.toJson()).toList()),
      );

  factory SavedDenomination.fromJson(Map<String, dynamic> json) =>
      SavedDenomination(
        id: json["Id"],
        createOn: json["CreateOn"],
        denoCategory: json["denoCategory"],
        remark: json["Remark"],
        denominationJsonStr: json["DenominationJsonStr"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "CreateOn": createOn,
        "denoCategory": denoCategory,
        "Remark": remark,
        "DenominationJsonStr": denominationJsonStr,
      };
}

@dao
abstract class SavedDenominationDao {
  @Query('SELECT * FROM SavedDenomination order by id desc')
  Future<List<SavedDenomination>> findAllSavedDenominations();

  @Query('SELECT * FROM SavedDenomination WHERE id = :id')
  Future<SavedDenomination?> findSavedDenominationById(int id);

  @delete
  Future<void> removeSingleDeno(SavedDenomination data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertSingleDenomination(SavedDenomination savedDenomination);
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDenomination(List<SavedDenomination> savedDenomination);
}

extension KdSavedDenoExt on SavedDenomination {
  Future<void> shareDenomination() async {
    String splitter = "---------------------------------------";

    List<String> denomination = [
      denoCategory,
      'Denomination',
      createOn.gtDateddmmyyyyhmformat,
      if (remark.isNotEmpty) remark,
      splitter,
      "Rupee x Counts = Total"
    ];

    final deno = denominations
        .filter((e) => e.currencyCount != 0)
        .map((e) => e.denominationText)
        .toList();
    denomination.addAll(deno);
    denomination.addAll([
      splitter,
      "Total Counts:",
      denominations.noteCounts.toString(),
      "Grand Total Amount:",
      denominations.grandTotal.gtCurrencyText,
      "${denominations.grandTotal.gtSpelling} only/-"
    ]);
    FlutterShare.share(title: "Denomination", text: denomination.join("\n"));
    // await Share.share(denomination.join("\n"), subject: 'Denomination');
  }
}
