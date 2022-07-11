import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mykidsprogress/mainscreen.dart';
import 'package:mykidsprogress/newchapter.dart';
import 'package:mykidsprogress/newtask.dart';
import 'package:mykidsprogress/newtest.dart';
import 'package:mykidsprogress/subject.dart';
import 'package:mykidsprogress/task.dart';
import 'package:mykidsprogress/taskstatus.dart';
import 'package:mykidsprogress/test.dart';
import 'package:mykidsprogress/testresultsscreen.dart';
import 'package:mykidsprogress/user.dart';
import 'package:http/http.dart' as http;

class TestsScreen extends StatefulWidget {
  final User user;
  final Subject subject;

  const TestsScreen({Key key, this.user, this.subject}) : super(key: key);

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> with WidgetsBindingObserver {
  String grade = '';
  String marks = '';
  bool _isStaff = false;
  bool _isTeacher = true;
  List _testList;
  List _classStudentList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  bool _statusPending = true;
  bool _isAdmin = false;
  TextEditingController _testController = new TextEditingController();
  TextEditingController _fmarksController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    checkStaff();
    WidgetsBinding.instance.addObserver(this);
    _testasync();
    print("Init tab 3");
  }

  @override
  void dispose() {
    print("in dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) =>
                    MainScreen(user: widget.user, subject: widget.subject)));
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 3,
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
                      child: Text(widget.subject.classid,
                          style: TextStyle(
                            fontSize: 16,
                          )),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _isTeacher,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("Teacher",
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
                        child: Text(widget.user.name,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey[350],
                height: 2,
                thickness: 1.5,
              ),
              if (_testList == null)
                Flexible(child: Center(child: Text(titleCenter)))
              else
                Flexible(
                    child: OrientationBuilder(builder: (context, orientation) {
                  return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: _isTeacher ? 4.3 : 2.9,
                      children: List.generate(_testList.length, (index) {
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                            child: Container(
                                child: InkWell(
                                onTap: () async { 
                                  if(widget.user.role=="Parent"){
                                    return;
                                  }else{
                                Navigator.of(context).pop();
                                Test _test = Test(
                                  testid: _testList[index]['testid'],
                                  testname: _testList[index]['test'],
                                  testmarks: _testList[index]['fmarks'],
                                );
                                http.post(
                                    Uri.parse(
                                        "https://crimsonwebs.com/s272033/mykidsprogress/php/updatetestdetails2.php"),
                                    body: {
                                      "testid": _testList[index]['testid'],
                                      "subjectid": widget.subject.subjectid,
                                    }).then((response) {});
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => TestResultsScreen(
                                          user: widget.user,
                                          subject: widget.subject,
                                          test: _test)),
                                );
                                }
                              },
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 0, 0, 0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(20, 5, 5, 5),
                                                    child: Text(
                                                        _testList[index]
                                                            ['test'],
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                  if (_classStudentList == null)
                                                    Visibility(
                                                        visible: false,
                                                        child: Flexible(
                                                            child: Center(
                                                                child: Text(
                                                                    marks =
                                                                        ''))))
                                                  else
                                                    Visibility(
                                                        visible: false,
                                                        child: Flexible(
                                                            child: Center(
                                                                child: Text(marks =
                                                                    _classStudentList[
                                                                            index]
                                                                        [
                                                                        'marks'])))),
                                                  if (_classStudentList == null)
                                                    Visibility(
                                                        visible: false,
                                                        child: Flexible(
                                                            child: Center(
                                                                child: Text(
                                                                    grade =
                                                                        ''))))
                                                  else
                                                    Visibility(
                                                        visible: false,
                                                        child: Flexible(
                                                            child: Center(
                                                                child: Text(grade =
                                                                    _classStudentList[
                                                                            index]
                                                                        [
                                                                        'grade'])))),
                                                  Visibility(
                                                    visible: widget.user.role ==
                                                        'Parent',
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          40, 5, 5, 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              flex: 5,
                                                              child: Text(
                                                                  "Marks",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ))),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(":",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ))),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Text(
                                                                marks + " %",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: widget.user.role ==
                                                        'Parent',
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          40, 5, 5, 0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              flex: 5,
                                                              child: Text(
                                                                  "Grade",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ))),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(":",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                  ))),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Text(grade,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(40, 5, 5, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                            flex: 5,
                                                            child: Text(
                                                                "Full Marks",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Text(":",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ))),
                                                        Expanded(
                                                          flex: 7,
                                                          child: Text(
                                                              _testList[index][
                                                                      'fmarks'] +
                                                                  " %",
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
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 10, 0),
                                              child: Column(
                                                children: [
                                                  Visibility(
                                                    visible: _isTeacher,
                                                    child: PopupMenuButton(
                                                      icon: Icon(
                                                        Icons.more_horiz,
                                                        color:
                                                            Colors.indigo[900],
                                                      ),
                                                      onSelected: (result) {
                                                        if (result == 0) {
                                                          _editTestDialog(
                                                              index);
                                                        } else if (result ==
                                                            1) {
                                                          _deleteTestDialog(
                                                              index);
                                                        }
                                                      },
                                                      itemBuilder: (BuildContext
                                                          context) {
                                                        return [
                                                          PopupMenuItem(
                                                            child: Text('Edit'),
                                                            value: 0,
                                                          ),
                                                          PopupMenuItem(
                                                            child:
                                                                Text('Delete'),
                                                            value: 1,
                                                          ),
                                                        ];
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))),
                            )));
                      }));
                })),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: _isTeacher,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTestForm(
                          user: widget.user, subject: widget.subject)));
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> _testasync() async {
    checkAdmin();
    _loadTest();
    _loadClassStudents();
  }

  void _loadTest() {
    http.post(
      Uri.parse(
          "https://crimsonwebs.com/s272033/mykidsprogress/php/loadtests.php"),
      body: {
        "classid": widget.subject.classid,
        "subjectid": widget.subject.subjectid
      },
    ).then((response) {
      if (response.body == "nodata") {
        setState(() {
            titleCenter = "No Data";
        });
        return;
      } else {
        var jsondata = json.decode(response.body);
        _testList = jsondata["tests"];
        titleCenter = "Loading...";
        setState(() {});
        print(_testList);
      }
    });
  }

  void _editTestDialog(int index) {
    _testController.text = _testList[index]['test'];
    _fmarksController.text = _testList[index]['fmarks'];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit This Test?"),
            content: SingleChildScrollView(
              child: new Container(
                height: 120,
                width: 240,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _testController,
                        decoration: InputDecoration(
                          labelText: "Test Name",
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
                        controller: _fmarksController,
                        decoration: InputDecoration(
                          labelText: "Full Marks",
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
                  _editTest(index);
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

  void _editTest(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/edittest.php"),
        body: {
          "testid": _testList[index]['testid'],
          "test": _testController.text.toString(),
          "fmarks": _fmarksController.text.toString(),
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Edit Test Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadTest();
      } else {
        Fluttertoast.showToast(
            msg: "Edit Test Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void checkAdmin() {
    setState(() {
      if (widget.user.email == 'xnlee1999@gmail.com') {
        _isAdmin = true;
      }
    });
  }

  _deleteTestDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete This Test?',
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
                      _deleteTest(index);
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

  void _deleteTest(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/deletetest.php"),
        body: {
          "testid": _testList[index]['testid'],
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Delete Test Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadTest();
      } else {
        Fluttertoast.showToast(
            msg: "Delete Test Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void checkStaff() {
    print(widget.user.role);
    setState(() {
      if (widget.user.role == 'Teacher') {
        _isStaff = true;
        _isTeacher = true;
      }
      if (widget.user.role == 'Parent') {
        _isStaff = false;
        _isTeacher = false;
      }
      if (widget.user.role == 'Principal') {
        _isStaff = true;
        _isTeacher = false;
      }
      print(_isStaff);
      print(_isTeacher);
    });
  }

  void _loadClassStudents() {
    String subjectid = widget.subject.subjectid;
    String classid = widget.subject.classid;
    String studentid = widget.user.id;
    print(studentid);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadstudenttestresult.php"),
        body: {
          "subjectid": subjectid,
          "classid": classid,
          "studentid": studentid,
        }).then((response) {
      if (response.body == "nodata") {
        setState(() {
            titleCenter = "No Data";
        });
        return;
      } else {
        var jsondata = json.decode(response.body);
        _classStudentList = jsondata["tasktudents"];
        titleCenter = "Contain Data";
        setState(() {});
        print(_classStudentList);
      }
    });
  }
}
