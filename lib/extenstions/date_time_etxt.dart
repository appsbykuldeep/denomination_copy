import 'package:intl/intl.dart';

extension KdDateTimeExt on DateTime? {
  String dateFormater(String format) {
    if (this == null) return "-";
    return DateFormat(format, "en_US").format(this!);
  }
}
