
import 'package:database_app/database/student_dao.dart';
import 'package:database_app/database/student_database.dart';
import 'package:drift/drift.dart' as drift; 
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  GlobalKey<FormState> _key = GlobalKey();
  //DatabaseHelper databaseHelper = DatabaseHelper();
  StudentDao studentDao = Get.find();
  String? name, address, phone, age;
  DateTime? birthday;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              const Text('Name'),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              const Text('Address'),
              const SizedBox(height: 8),
              TextFormField(
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
                    initialDate: DateTime(1990),
                    firstDate: DateTime(1990),
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
              // const Text('Email'),
              // const SizedBox(height: 8),
              // TextFormField(
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please Enter Email';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     email = value;
              //   },
              //   decoration: const InputDecoration(
              //       prefixIcon: Icon(Icons.email),
              //       hintText: 'Enter Email',
              //       border: OutlineInputBorder()),
              // ),
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
                      studentDao.insertStudent(
                        StudentTableCompanion(
                          name: drift.Value(name ?? ''),
                          address: drift.Value(address ?? ''),
                          phone: drift.Value(phone ?? ''),
                          age: drift.Value(int.parse(age ?? '0')),
                          birthday: drift.Value(birthday!),
                        )
                      );
                      
                    // int id =await databaseHelper.insertStudent(Student().insertStudent(
                    //     name: name ?? '',
                    //     address: address ?? '',
                    //     email: email ?? '',
                    //     phone: phone ?? ''));
                    //     print(id);
                        Navigator.pop(context,'success');
                  }

                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              )
            ],
          )),
    );
  }
}
