import 'dart:ffi';

import 'package:drift/drift.dart';
@DataClassName("Student")
class StudentTable extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named("name").withLength(min:3,max:15)();
  TextColumn get address => text().named("address")();
  TextColumn get phone => text().named("phone")();
  IntColumn get age => integer()();
  DateTimeColumn get birthday => dateTime()();
}