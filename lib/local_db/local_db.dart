// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:async';

import 'package:denomination_app/models/basic/saved_denominations.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'local_db.g.dart'; // the generated code will be there

@Database(version: 1, entities: [SavedDenomination])
abstract class AppDatabase extends FloorDatabase {
  SavedDenominationDao get denominationDao;
}
