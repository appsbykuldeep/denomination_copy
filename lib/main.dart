import 'package:denomination_app/common_controllers/denomination_ctrl.dart';
import 'package:denomination_app/constants/app_theme.dart';
import 'package:denomination_app/extenstions/localdb_ext.dart';
import 'package:denomination_app/local_db/local_db_ctrl.dart';
import 'package:denomination_app/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  // await initFireBase();
  _putCtrls();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Denomination',
      debugShowCheckedModeBanner: false,
      theme: lighttheme,
      darkTheme: darkTheme,
      // navigatorObservers: <NavigatorObserver>[observer],
      home: const HomePage(),
      themeMode: isLisghtTheme ? ThemeMode.light : ThemeMode.dark,
    );
  }
}

void _putCtrls() {
  Get.put<LocalDbCtrl>(LocalDbCtrl());
  Get.put<DenominationCtrl>(DenominationCtrl()).setHomeDenominationByLocalDb();
}

/*

flutter pub global run rename --appname "Denomination"

 */