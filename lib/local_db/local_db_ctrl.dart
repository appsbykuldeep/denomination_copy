import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/models/basic/saved_denominations.dart';

import 'local_db.dart';

class LocalDbCtrl extends GetxService {
  late AppDatabase db;
  var savedDenominatons = <SavedDenomination>[].obs;

  @override
  void onReady() {
    _setDb();
    super.onReady();
  }

  Future<void> updateSavedDenomination() async {
    savedDenominatons.value =
        (await denominationDao.findAllSavedDenominations())
            .map((e) => e.setDenominationByJsonStr())
            .toList();
  }

  Future<void> removeSingleDeno(SavedDenomination data) async {
    await denominationDao.removeSingleDeno(data);
    await updateSavedDenomination();
  }

  Future<void> _setDb() async {
    db = await $FloorAppDatabase.databaseBuilder('app_database1.db').build();
    await updateSavedDenomination();
  }

  SavedDenominationDao get denominationDao => db.denominationDao;
}
