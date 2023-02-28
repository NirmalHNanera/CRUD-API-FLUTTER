import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  AddUser(this.map);

  Map? map;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameController.text =
        widget.map == null ? "" : widget.map!['FirstName'];
    lastNameController.text = widget.map == null ? "" : widget.map!['LastName'];
    emailController.text = widget.map == null ? "" : widget.map!['EmailID'];
    mobileNumberController.text =
        widget.map == null ? "" : widget.map!['PhoneNumber'];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: firstNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter First Name",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: lastNameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Last Name",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.trim().length == 0) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Email ID",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null ||
                                value.trim().length == 0 ||
                                value.length < 10) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          controller: mobileNumberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Mobile Number",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(
                        () async {
                          if (_formKey.currentState!.validate()) {
                            if (widget.map == null) {
                              addUser().then(
                                (value) => Navigator.of(context).pop(true),
                              );
                            } else {
                              updateUser(widget.map!['id']).then(
                                (value) => Navigator.of(context).pop(true),
                              );
                            }
                          }
                        },
                      );
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    Map map = {};
    map['FirstName'] = firstNameController.text;
    map['LastName'] = lastNameController.text;
    map['EmailID'] = emailController.text;
    map['PhoneNumber'] = mobileNumberController.text;

    var response1 = await http.post(
        Uri.parse("https://63f303a6de3a0b242b38cfe8.mockapi.io/students"),
        body: map);
    print(response1.body);
  }

  Future<void> updateUser(id) async {
    Map map = {};
    map['FirstName'] = firstNameController.text;
    map['LastName'] = lastNameController.text;
    map['EmailID'] = emailController.text;
    map['PhoneNumber'] = mobileNumberController.text;

    var response1 = await http.put(
        Uri.parse("https://63f303a6de3a0b242b38cfe8.mockapi.io/students/$id"),
        body: map);
    print(response1.body);
  }
}
