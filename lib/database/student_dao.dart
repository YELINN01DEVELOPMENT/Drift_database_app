
import 'dart:ffi';

import 'package:database_app/database/student_database.dart';
import 'package:database_app/database/student_table.dart';
import 'package:drift/drift.dart';

part 'student_dao.g.dart';
@DriftAccessor(tables: [StudentTable])
class StudentDao extends DatabaseAccessor<StudentDatabase> with _$StudentDaoMixin{
  StudentDao(StudentDatabase studentDatabase) :super(studentDatabase);
  Future<int> insertStudent(StudentTableCompanion s) async{
    return await into(studentTable).insert(s);
  } 
 
  Stream<List<Student>> getAllStudent({OrderingMode? mode, bool? over25, bool? under25 }){
    if(mode == null && over25 == null && under25 == null){
      return select(studentTable).watch(); 
    }
    else if(over25 != null && over25 == true){
      return (select(studentTable)
      .. where((tbl) => studentTable.age.isBiggerOrEqualValue(25))
      ).watch();
    }
    else if( under25 != null && under25 == true){
      return (select(studentTable)
      .. where(((tbl) => studentTable.age.isSmallerOrEqualValue(24)))
      ).watch();
    }
    else{
      return (select(studentTable)
    .. orderBy([(studentTable)=> OrderingTerm(expression: studentTable.id,mode: mode!)])
     ).watch();
    }
    
  }

  Future<bool> updateStudent(StudentTableCompanion student) async{
    return update(studentTable).replace(student);
  }

  Future<int> deleteStudent(Student student) async{
    return delete(studentTable).delete(student);
  }

  Future<int> deleteAllStudent() async{
    return await (delete(studentTable)..where((tbl) => tbl.id.isBiggerThanValue(0))).go();
  }
}
