import 'package:evan_project/custom_textfield.dart';
import 'package:flutter/material.dart';

class ListSiswa extends StatefulWidget {
  const ListSiswa({super.key});

  @override
  State<ListSiswa> createState() => _ListSiswaState();
}

class Student {
  String firstname;
  String lastname;
  String classes;
  String major;
  Student(this.firstname, this.lastname, this.classes, this.major);
}

class _ListSiswaState extends State<ListSiswa> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController classesController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final List<Student> Students = [];

  void _tambahProduct() {
    setState(
      () {
        if (firstnameController.text.isEmpty ||
            lastnameController.text.isEmpty ||
            classesController.text.isEmpty ||
            majorController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.yellowAccent,
                ),
                child: Center(
                  child: Text(
                    "Field Tidak Boleh Kosong",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
          );
        } else if (firstnameController.text.isNotEmpty ||
            lastnameController.text.isNotEmpty ||
            classesController.text.isNotEmpty ||
            majorController.text.isNotEmpty) {
          Students.add(
            Student(
              firstnameController.text,
              lastnameController.text,
              classesController.text,
              majorController.text,
            ),
          );
          firstnameController.clear();
          lastnameController.clear();
          classesController.clear();
          majorController.clear();
        } else {
          SnackBar(
            content: Text("Error"),
          );
        }
      },
    );
  }

  void _editStudent(int index, Student newStudent) {
    setState(() {
      Students[index] = newStudent;
    });
    firstnameController.clear();
    lastnameController.clear();
    classesController.clear();
    majorController.clear();
  }

  void _deleteStudent(int index) {
    setState(() {
      Students.removeAt(index);
    });
  }

  void _showEdit(int index) {
    final student = Students[index];
    firstnameController.text = student.firstname;
    lastnameController.text = student.lastname;
    classesController.text = student.classes;
    majorController.text = student.major;

    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text("Edit Student"),
            content: Container(
              height: 300,
              width: 200,
              child: Column(
                children: [
                  CustomTextfield(
                    label: "First Name",
                    controller: firstnameController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    label: "Last Name",
                    controller: lastnameController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    label: "classes",
                    controller: classesController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextfield(
                    label: "major",
                    controller: majorController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  firstnameController.clear();
                  lastnameController.clear();
                  classesController.clear();
                  majorController.clear();
                },
                child: const Text("cancel"),
              ),
              TextButton(
                onPressed: () {
                  _editStudent(
                    index,
                    Student(firstnameController.text, lastnameController.text,
                        classesController.text, majorController.text),
                  );
                  Navigator.pop(context);
                },
                child: const Text("save"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Center(
              child: Text(
                "Evan Bani Saputra\nXII - PPLG",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTextfield(
                  label: "First Name",
                  controller: firstnameController,
                ),
                SizedBox(height: 15),
                CustomTextfield(
                  label: "Last Name",
                  controller: lastnameController,
                ),
                SizedBox(height: 15),
                CustomTextfield(
                  label: "Classes",
                  controller: classesController,
                ),
                SizedBox(height: 15),
                CustomTextfield(
                  label: "Major",
                  controller: majorController,
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                  ),
                  onPressed: _tambahProduct,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Students.length,
              itemBuilder: (context, index) {
                final _students = Students[index];
                return Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Text("${_students.firstname} ${Students.last}"),
                      subtitle: Text("${_students.classes} ${_students.major}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => _showEdit(index),
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => _deleteStudent(index),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
