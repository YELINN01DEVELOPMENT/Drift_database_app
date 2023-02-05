
import 'package:database_app/database/student_dao.dart';
import 'package:database_app/database/student_database.dart';
import 'package:drift/drift.dart' as drift; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({Key? key,required this.student}):super(key: key);
  final Student student;

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  final GlobalKey<FormState> _key = GlobalKey();
  //DatabaseHelper databaseHelper = DatabaseHelper();
  StudentDao studentDao = Get.find();
  String? name, address, phone, age;
  DateTime? birthday;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    birthday = widget.student.birthday;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              const Text('Name'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.student.name,
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'Please Enter Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Enter Name',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 8),
              const Text('Address'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.student.address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: 'Enter Address',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              const Text('Phone'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.student.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Phone';
                  }
                  return null;
                },
                onSaved: (value) {
                  phone = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Enter PhoneNumber',
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 8),
              const Text('Age'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: widget.student.age.toString(),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Age';
                  }
                  return null;
                },
                onSaved: (value) {
                  age = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_add),
                    hintText: 'Enter Age',
                    border: OutlineInputBorder()),
              ),
              IconButton(
                onPressed: ()async{
                    birthday = await showDatePicker(
                    context: context,
                    initialDate: DateTime(1996),
                    firstDate: DateTime(1996),
                    lastDate: DateTime.now());
                    setState(() {
                      
                    });
                },
                 icon: const Icon(Icons.calendar_today)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$birthday'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () async{
                  if(birthday == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Plesase select birthday'))
                    );
                  }
                  else if (_key.currentState != null &&
                      _key.currentState!.validate()) {
                      _key.currentState?.save();
                      studentDao.updateStudent(
                        StudentTableCompanion(
                          id: drift.Value(widget.student.id),
                          name: drift.Value(name ?? ''),
                          address: drift.Value(address ?? ''),
                          phone: drift.Value(phone ?? ''),
                          age: drift.Value(int.parse(age ?? '0')),
                          birthday: drift.Value(birthday!),
                        )
                      );
                      Navigator.pop(context,'success');
                  }

                },
                icon: const Icon(Icons.update),
                label: const Text('Update'),
              )
            ],
          )),
    );
  }
}
