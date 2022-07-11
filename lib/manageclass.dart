import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mykidsprogress/mydrawer.dart';
import 'package:mykidsprogress/newclass.dart';
import 'package:mykidsprogress/newparticipants.dart';
import 'package:mykidsprogress/newstudent.dart';
import 'user.dart';

class ManageClassScreen extends StatefulWidget {
  final User user;

  const ManageClassScreen({Key key, this.user}) : super(key: key);

  @override
  _ManageClassScreenState createState() => _ManageClassScreenState();
}

class _ManageClassScreenState extends State<ManageClassScreen> {
  List _subjectList, _classStudentList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  TextEditingController _srcController = new TextEditingController();
  int cartitem = 0;
  bool _isAdmin = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _teacherController = new TextEditingController();
  TextEditingController _sub1Controller = new TextEditingController();
  TextEditingController _sub2Controller = new TextEditingController();
  TextEditingController _sub3Controller = new TextEditingController();
  TextEditingController _sub4Controller = new TextEditingController();
  TextEditingController _sub5Controller = new TextEditingController();

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
        title: Text("Manage Class"),
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Class In Charged : " + _subjectList[0]['classid'],
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[350],
            height: 2,
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 10, 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Teachers:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          if (_subjectList == null)
            Flexible(child: Center(child: Text(titleCenter)))
          else
            Flexible(child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 7,
                  children: List.generate(_subjectList.length, (index) {
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
                                                5, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
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
                                                          flex: 4,
                                                          child: Text(
                                                              _subjectList[
                                                                      index][
                                                                  'subjectname'],
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
                                                            _subjectList[index]
                                                                ['teacher'] == null ? "-" : _subjectList[index]
                                                                ['teacher'],
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
                                                  Icons.delete,
                                                  color: Colors.indigo[900],
                                                ),
                                                onTap: () =>
                                                    {_removeTeacherDialog(index)},
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )))));
                  }));
            })),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Divider(
              color: Colors.black,
              height: 2,
              thickness: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 10, 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Students:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          if (_classStudentList == null)
            Flexible(child: Center(child: Text(titleCenter)))
          else
            Flexible(child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 5,
                  children: List.generate(_classStudentList.length, (index) {
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
                                                5, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 0, 0, 5),
                                                  child: Text(
                                                      _classStudentList[index]
                                                          ['studentname'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        
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
                                                          flex: 4,
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
                                                            _classStudentList[index]
                                                                ['studentid'],
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
                                                  Icons.delete,
                                                  color: Colors.indigo[900],
                                                ),
                                                onTap: () =>
                                                    {_removeStudentDialog(index)},
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
                  builder: (context) =>
                      NewParticipantsForm(user: widget.user)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _loadSubjects() {

    String staffid = widget.user.id;
    print(staffid);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadsubjects.php"),
        body: {"staffid": staffid}).then((response) {
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
        _subjectList = jsondata["subjects"];
        titleCenter = "Contain Data";
        if(mounted){
          setState(() {});
        }
        print(_subjectList);
      }
    });
  }

  void _loadClassStudents() {
    String staffid = widget.user.id;
    print(staffid);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadclassstudent.php"),
        body: {"staffid": staffid}).then((response) {
      if (response.body == "nodata") {
        setState(() {
            titleCenter = "No Data";
        });
        return;
      } else {
        var jsondata = json.decode(response.body);
        _classStudentList = jsondata["classstudents"];
        titleCenter = "Contain Data";
        if(mounted){
          setState(() {});
        }
        
        print(_classStudentList);
      }
    });
  }

  Future<void> _testasync() async {
    _loadSubjects();
    _loadClassStudents();
  }

  void _editClassDialog(int index) {
    _nameController.text = _subjectList[index]['name'];
    _teacherController.text = _subjectList[index]['teacher'];
    _sub1Controller.text = _subjectList[index]['sub1'];
    _sub2Controller.text = _subjectList[index]['sub2'];
    _sub3Controller.text = _subjectList[index]['sub3'];
    _sub4Controller.text = _subjectList[index]['sub4'];
    _sub5Controller.text = _subjectList[index]['sub5'];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit This Classes?"),
            content: SingleChildScrollView(
              child: new Container(
                // height: 320,
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
                        controller: _teacherController,
                        decoration: InputDecoration(
                          labelText: "Teacher In Charged (StaffID)",
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
                        controller: _sub1Controller,
                        decoration: InputDecoration(
                          labelText: "Subject 1",
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
                        controller: _sub2Controller,
                        decoration: InputDecoration(
                          labelText: "Subject 2",
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
                        controller: _sub3Controller,
                        decoration: InputDecoration(
                          labelText: "Subject 3",
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
                        controller: _sub4Controller,
                        decoration: InputDecoration(
                          labelText: "Subject 4",
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
                        controller: _sub5Controller,
                        decoration: InputDecoration(
                          labelText: "Subject 5",
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
                  _editClass(index);
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

  void _editClass(int index) {
    String classid = _subjectList[index]['classid'];
    String name = _nameController.text.toString();
    String teacher = _teacherController.text.toString();
    String sub1 = _sub1Controller.text.toString();
    String sub2 = _sub2Controller.text.toString();
    String sub3 = _sub3Controller.text.toString();
    String sub4 = _sub4Controller.text.toString();
    String sub5 = _sub5Controller.text.toString();

    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/editclasses.php"),
        body: {
          "classid": classid,
          "name": name,
          "teacher": teacher,
          "sub1": sub1,
          "sub2": sub2,
          "sub3": sub3,
          "sub4": sub4,
          "sub5": sub5,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Edit Class Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadSubjects();
      } else {
        Fluttertoast.showToast(
            msg: "Edit Class Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  _removeStudentDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Remove This Participants?',
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
                      _removeStudent(index);
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

  void _removeStudent(int index) {
    String studentid = _classStudentList[index]['studentid'];
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/removeclassstudent.php"),
        body: {
          "studentid": studentid,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Remove Participants Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadClassStudents();
      } else {
        Fluttertoast.showToast(
            msg: "Remove Participants Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  _removeTeacherDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Remove This Participants?',
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
                      _removeTeacher(index);
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

  void _removeTeacher(int index) {
    String teacherid = _subjectList[index]['teacherid'];
    String classid = _subjectList[index]['classid'];
    String sub = _subjectList[index]['subjectname'];
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/removeclassteacher.php"),
        body: {
          "classid": classid,
          "teacherid": teacherid,
          "sub": sub,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Remove Participants Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadSubjects();
      } else {
        Fluttertoast.showToast(
            msg: "Remove Participants Failed",
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
