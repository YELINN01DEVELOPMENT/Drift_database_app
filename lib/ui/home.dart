import 'package:database_app/database/student_dao.dart';
import 'package:database_app/database/student_database.dart';
import 'package:database_app/ui/add_student_screen.dart';
import 'package:database_app/ui/update_student_screen.dart';
import 'package:drift/drift.dart' as db;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
    Home({super.key});
   
   
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StudentDao studentDao = Get.find();
   List<Student> studentList = [];
  late Stream<List<Student>> _students;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _students = studentDao.getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Student DB'),
        leading: PopupMenuButton(
          onSelected: (str) {
            if(str == 'default'){
              setState(() {
                _students = studentDao.getAllStudent();
              });
            }else if(str == 'accending'){
              setState(() {
                _students = studentDao.getAllStudent(mode: db.OrderingMode.asc);
              });
            }else if(str == 'descreding'){
              setState(() {
                _students = studentDao.getAllStudent(mode: db.OrderingMode.desc);
              });
            }else if(str == 'age over 25'){
              setState(() {
                _students = studentDao.getAllStudent(over25: true);
              });
            }
            else if(str == 'age under 25'){
              setState(() {
                _students = studentDao.getAllStudent(under25: true);
              });
            }
          },
          child: const Icon(Icons.filter_list),
          itemBuilder: (context) {
          return [
            const PopupMenuItem(value: 'default',child: Text('Default'),),
            const PopupMenuItem(value: 'accending',child: Text('Age by Accending'),),
            const PopupMenuItem(value: 'descreding', child: Text('Age by Descrecing')),
            const PopupMenuItem(value: 'age over 25', child: Text('Age over 25')),
            const PopupMenuItem(value: 'age under 25', child: Text('Age under 25')),
          ];
        },),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (context){
                  return AlertDialog(
                    title: const Text('Are you sure to delete all students?'),
                    actions: [
                      TextButton(
                        onPressed: ()async{
                          await studentDao.deleteAllStudent();
                          Navigator.pop(context);
                        },
                        child: const Text('Yes')
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text('No'))
                    ],
                  );
                });
            },
            icon: const Icon(Icons.delete)),
          IconButton(
            onPressed: (){
              Navigator.push(context,
               MaterialPageRoute(builder:(context) =>  const AddStudent()));
            },
            icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<List<Student>>(
        stream: _students,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            studentList = snapshot.data?? [];
            return _studentList(snapshot.data ?? []);
          }else if(snapshot.hasError){
            return const Text('Error');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
  Widget _studentList(List<Student> student){
    return ListView.builder(
      itemCount: student.length,
      itemBuilder: (context,index) {
      studentList = student;
       return Column(
        children: [
          ListTile(
            leading: IconButton(
              onPressed: (){
                Navigator.push(context,
                 MaterialPageRoute(
                  builder: (_) {
                   return UpdateStudent(student:student[index]);
                  }, ));
              },
              icon:const Icon(Icons.edit) 
              ),
            trailing: IconButton(
              onPressed: () async{
                await studentDao.deleteStudent(student[index]);
              },
              icon:const Icon(Icons.delete) 
              ),
          ),
          const Divider(color: Colors.black),
          CircleAvatar(child: Text(student[index].id.toString())),
          const Divider(color: Colors.black),
          Text(student[index].name),
          const SizedBox(height: 10),
          Text(student[index].address),
          const SizedBox(height: 10),
          Text(student[index].age.toString()),
          const SizedBox(height: 10),
          Text(student[index].birthday.toString()),
          const Divider(color: Colors.black),
        ],
       ); 
      }
    );
  }
}