import 'dart:convert';

import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/extenstions/localdb_ext.dart';
import 'package:denomination_app/extenstions/num_ext.dart';
import 'package:easy_debounce/easy_debounce.dart';

List<DenominationModel> getDenominationModelList(dynamic data) {
  if (data == null) return [];
  try {
    return List<DenominationModel>.from(
        (data as List<dynamic>).map((e) => DenominationModel.fromJson(e)));
  } catch (e) {
    return [];
  }
}

class DenominationModel {
  DenominationModel({
    this.currencyAmount = 0,
    this.currencyCount = 0,
    this.totalAmount = 0,
    this.exampleStr = "",
    required this.node,
  });

  num currencyAmount;
  int currencyCount;
  num totalAmount;
  String exampleStr;
  FocusNode node;

  DenominationModel setTotalAmount() =>
      this..totalAmount = currencyAmount * currencyCount;

  String get _currText => [
        ...currencyAmount.gtCurrencyText.split(""),
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",
        " ",
        ".",
      ].join().substring(0, 8);

  String get denominationText =>
      "$_currText x ${currencyCount.toInt()} = ${totalAmount.gtCurrencyText}";

  DenominationModel copyWith({
    num? currencyAmount,
    int? currencyCount,
    num? totalAmount,
  }) =>
      DenominationModel(
        currencyAmount: currencyAmount ?? this.currencyAmount,
        currencyCount: currencyCount ?? this.currencyCount,
        totalAmount: totalAmount ?? this.totalAmount,
        exampleStr: exampleStr,
        node: FocusNode(),
      );

  factory DenominationModel.fromJson(Map<String, dynamic> json) =>
      DenominationModel(
        currencyAmount: json["CurrencyAmount"],
        currencyCount: json["CurrencyCount"],
        totalAmount: json["TotalAmount"],
        exampleStr: json["exampleStr"],
        node: FocusNode(),
      );

  Map<String, dynamic> toJson() => {
        "CurrencyAmount": currencyAmount,
        "CurrencyCount": currencyCount,
        "TotalAmount": totalAmount,
        "exampleStr": exampleStr,
      };
}

extension KdDenominationModelList on List<DenominationModel> {
  double get grandTotal =>
      fold<double>(0, (p, c) => p + (c.currencyAmount * c.currencyCount));
  int get noteCounts =>
      fold<double>(0, (p, c) => p + c.currencyCount.abs()).toInt();

  void boxSaveLocal() {
    EasyDebounce.debounce("boxSaveLocalList", const Duration(seconds: 1), () {
      if (noteCounts != 0) {
        jsonEncode(map((e) => e.setTotalAmount().toJson()).toList())
            .boxHomeDenomination;
      }
    });
  }
}

List<DenominationModel> indianCurrency = [
  DenominationModel(
    currencyAmount: 2000,
    exampleStr: "Try 6",
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 500,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 200,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 100,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 50,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 20,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 10,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 5,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 2,
    node: FocusNode(),
  ),
  DenominationModel(
    currencyAmount: 1,
    node: FocusNode(),
  ),
];
