import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mykidsprogress/mydrawer.dart';
import 'package:mykidsprogress/newstudent.dart';
// import 'package:winfung_gate/newproduct.dart';
// import 'cartpage.dart';
// import 'mydrawer.dart';
import 'user.dart';

class ManageStudentsScreen extends StatefulWidget {
  final User user;

  const ManageStudentsScreen({Key key, this.user}) : super(key: key);

  @override
  _ManageStudentsScreenState createState() => _ManageStudentsScreenState();
}

class _ManageStudentsScreenState extends State<ManageStudentsScreen> {
  List _studentList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  TextEditingController _srcController = new TextEditingController();
  int cartitem = 0;
  bool _isAdmin = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _genderController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _classidController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _testasync();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Students"),
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: _srcController,
              onChanged: (_srcController) {
                _loadStudents(_srcController);
              },
              decoration: InputDecoration(
                hintText: "Search student...",
                suffixIcon: IconButton(
                  onPressed: () => _searchStudents(_srcController.text),
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ),
          if (_studentList == null)
            Flexible(child: Center(child: Text(titleCenter)))
          else
            Flexible(child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 1.9,
                  children: List.generate(_studentList.length, (index) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                        child: Container(
                            child: Card(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.indigo[900],
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 1),
                                          ),
                                        ]),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 7),
                                                  child: Text(
                                                      _studentList[index]
                                                          ['name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationThickness:
                                                            1.5,
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text(
                                                              "Student ID",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _studentList[index]
                                                                ['studentid'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("Gender",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _studentList[index]
                                                                ['gender'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("DOB",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _studentList[index]
                                                                ['dob'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("Parent's Phone",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _studentList[index]
                                                                ['phone'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("Class",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _studentList[index]
                                                                ['classname'] == null ? "-" : _studentList[index]
                                                                ['classname'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.indigo[900],
                                                ),
                                                onTap: () =>
                                                    {_editStudentDialog(index)},
                                              ),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.indigo[900],
                                                ),
                                                onTap: () => {
                                                  _deleteStudentDialog(index)
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )))));
                  }));
            })),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewStudentForm(user: widget.user)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _loadStudents(String name) {
    checkAdmin();
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadstudents.php"),
        body: {"name": name}).then((response) {
      if (response.body == "nodata") {
        setState(() {
            titleCenter = "No Data";
        });
        //Fluttertoast.showToast(
        //    msg: "We couldn't find anything for " + _srcController.text,
        //    toastLength: Toast.LENGTH_SHORT,
        //    gravity: ToastGravity.BOTTOM,
        //    timeInSecForIosWeb: 1,
        //    backgroundColor: Colors.redAccent[700],
        //    textColor: Colors.white,
        //   fontSize: 16.0);
        return;
      } else {
        var jsondata = json.decode(response.body);
        _studentList = jsondata["students"];
        titleCenter = "Contain Data";
        setState(() {});
        print(_studentList);
      }
    });
  }

  Future<void> _testasync() async {
    _loadStudents("");
  }

  _searchStudents(String name) {
    _loadStudents(name);
    if (titleCenter == "No data") {
      Fluttertoast.showToast(
          msg: "We couldn't find anything for \" " + _srcController.text+" \" ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void checkAdmin() {
    setState(() {
      if (widget.user.email == 'jasminelxn@yahoo.com') {
        _isAdmin = true;
      }
    });
  }

  void _editStudentDialog(int index) {
    _nameController.text = _studentList[index]['name'];
    _genderController.text = _studentList[index]['gender'];
    _dobController.text = _studentList[index]['dob'];
    _phoneController.text = _studentList[index]['phone'];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit This Student?"),
            content: SingleChildScrollView(
              child: new Container(
                height: 260,
                width: 300,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _genderController,
                        decoration: InputDecoration(
                          labelText: "Gender",
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          labelText: "DOB",
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Parent's Phone",
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text("Confirm",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed: () {
                  _editStudent(index);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Cancel",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _editStudent(int index) {
    String studentid = _studentList[index]['studentid'];
    String name = _nameController.text.toString();
    String gender = _genderController.text.toString();
    String dob = _dobController.text.toString();
    String phone = _phoneController.text.toString();

    if (studentid.isEmpty ||
        name.isEmpty ||
        gender.isEmpty ||
        dob.isEmpty ||
        phone.isEmpty ) {
      Fluttertoast.showToast(
          msg: "Please enter all the required information.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (phone.length < 10) {
      Fluttertoast.showToast(
          msg: "Invalid. Phone number should be at least 10 numbers",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/editstudents.php"),
        body: {
          "studentid": studentid,
          "name": name,
          "gender": gender,
          "dob": dob,
          "phone": phone,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Edit Student Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadStudents("");
      } else {
        Fluttertoast.showToast(
            msg: "Edit Student Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  _deleteStudentDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete this student?',
                  style: TextStyle(),
                ),
                content: new Text(
                  'Are your sure?',
                  style: TextStyle(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes",
                        style: TextStyle(color: Theme.of(context).accentColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteStudent(index);
                    },
                  ),
                  TextButton(
                      child: Text("No",
                          style:
                              TextStyle(color: Theme.of(context).accentColor)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void _deleteStudent(int index) {
    String studentid = _studentList[index]['studentid'];
    print(studentid);
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/deletestudents.php"),
        body: {
          "studentid": studentid,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Delete Student Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadStudents("");
      } else {
        Fluttertoast.showToast(
            msg: "Delete Student Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }
}
