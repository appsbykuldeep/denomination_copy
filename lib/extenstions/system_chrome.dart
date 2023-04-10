import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void fullScreenMode() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
}

void transparentAppbar() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));
}
