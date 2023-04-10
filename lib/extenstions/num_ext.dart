import 'package:denomination_app/extenstions/string_ext.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words/number_to_words.dart';

extension KdNumExt on num {
  String get gtCurrencyText =>
      "₹ ${NumberFormat("##,##,###.##", "en_US").format(this)}";

  String get gtSpelling {
    return "${this < 0 ? "minus" : ""}${NumberToWord().convert('en-in', toInt().abs())}"
        .trim()
        .gtProperCase;
  }
}
