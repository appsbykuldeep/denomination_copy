import 'dart:convert';

dynamic tryDecodeJsonOrNull(String source) {
  try {
    return jsonDecode(source);
  } catch (e) {
    return null;
  }
}
