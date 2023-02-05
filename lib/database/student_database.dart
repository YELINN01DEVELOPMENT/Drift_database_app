import 'dart:io';
import 'package:database_app/database/student_dao.dart';
import 'package:database_app/database/student_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

part 'student_database.g.dart';
@DriftDatabase(tables: [StudentTable],daos: [StudentDao])
class StudentDatabase extends _$StudentDatabase{
  StudentDatabase():super(_database());

  

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;

}

LazyDatabase _database(){
  return LazyDatabase(() async{
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbFile = File(join(dbFolder.path,"student.db"));
    return NativeDatabase(dbFile);
  });
}