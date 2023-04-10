import 'package:get_storage/get_storage.dart';

final _box = GetStorage();

extension KDLocalDb on String {
  String get boxIsLightTheme => _finder("boxIsLightTheme");
  String get boxMuteSpell => _finder("boxcanSpeak");
  String get boxUserpw => _finder("BoxUserLoginPW");
  String get boxLoginStatus => _finder("BoxIsPrelogin");
  String get boxPrinterMac => _finder("boxPrinterMac");
  String get boxHomeDenomination => _finder("boxHomeDenomination");

  String _finder(String key) {
    if (isEmpty) return _box.read(key) ?? "";
    if (this == "--") {
      _box.write(key, '');
      return "";
    } else {
      _box.write(key, this);
      return "";
    }
  }
}

bool get isSpeakMuted => "".boxMuteSpell == "1";
bool get isLisghtTheme => "".boxIsLightTheme == "1";
