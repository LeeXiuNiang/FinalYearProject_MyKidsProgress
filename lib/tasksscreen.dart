import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mykidsprogress/mainscreen.dart';
import 'package:mykidsprogress/newchapter.dart';
import 'package:mykidsprogress/newtask.dart';
import 'package:mykidsprogress/subject.dart';
import 'package:mykidsprogress/task.dart';
import 'package:mykidsprogress/taskstatus.dart';
import 'package:mykidsprogress/user.dart';
import 'package:http/http.dart' as http;

class TasksScreen extends StatefulWidget {
  final User user;
  final Subject subject;

  const TasksScreen({Key key, this.user, this.subject}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with WidgetsBindingObserver {
  String status = '';
  bool _isStaff = false;
  bool _isTeacher = true;
  List _taskList;
  List _classStudentList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  bool _statusPending = true;
  bool _isAdmin = false;
  TextEditingController _taskController = new TextEditingController();
  TextEditingController _notesController = new TextEditingController();
  TextEditingController _dueController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    checkStaff();
    WidgetsBinding.instance.addObserver(this);
    _testasync();
    print("Init tab 2");
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
              if (_taskList == null)
                Flexible(child: Center(child: Text(titleCenter)))
              else
                Flexible(
                    child: OrientationBuilder(builder: (context, orientation) {
                  return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: _isTeacher ? 3.7 : 2.9,
                      children: List.generate(_taskList.length, (index) {
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
                            child: Container(
                                child: InkWell(
                              onTap: () async {
                                if(widget.user.role=="Parent"){
                                    return;
                                  }else{
                                Navigator.of(context).pop();
                                Task _task = Task(
                                  taskid: _taskList[index]['taskid'],
                                  taskname: _taskList[index]['task'],
                                  taskdue: _taskList[index]['due'],
                                  tasknote: _taskList[index]['notes'],
                                );
                                http.post(
                                    Uri.parse(
                                        "https://crimsonwebs.com/s272033/mykidsprogress/php/updatetaskdetails2.php"),
                                    body: {
                                      "taskid": _taskList[index]['taskid'],
                                      "subjectid": widget.subject.subjectid,
                                    }).then((response) {});
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => TaskStatusScreen(
                                          user: widget.user,
                                          subject: widget.subject,
                                          task: _task)),
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
                                                        _taskList[index]
                                                            ['task'],
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
                                                                    status =
                                                                        ''))))
                                                  else
                                                    Visibility(
                                                        visible: false,
                                                        child: Flexible(
                                                            child: Center(
                                                                child: Text(status =
                                                                    _classStudentList[
                                                                            index]
                                                                        [
                                                                        'status'])))),
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
                                                              flex: 3,
                                                              child: Text(
                                                                  "Status",
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
                                                            child: Text(status,
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
                                                            flex: 3,
                                                            child: Text(
                                                                "Due Date",
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
                                                              _taskList[index]
                                                                  ['due'],
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(40, 5, 5, 5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                            flex: 3,
                                                            child: Text("Notes",
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
                                                              _taskList[index]
                                                                  ['notes'],
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
                                                          _editTaskDialog(
                                                              index);
                                                        } else if (result ==
                                                            1) {
                                                          _deleteTaskDialog(
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
                      builder: (context) => NewTaskForm(
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
    _loadTask();
    _loadClassStudents();
  }

  void _loadTask() {
    http.post(
      Uri.parse(
          "https://crimsonwebs.com/s272033/mykidsprogress/php/loadtasks.php"),
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
        _taskList = jsondata["tasks"];
        titleCenter = "Loading...";
        setState(() {});
        print(_taskList);
      }
    });
  }

  void _editTaskDialog(int index) {
    _taskController.text = _taskList[index]['task'];
    _notesController.text = _taskList[index]['notes'];
    _dueController.text = _taskList[index]['due'];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit This Task?"),
            content: SingleChildScrollView(
              child: new Container(
                height: 180,
                width: 240,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          labelText: "Task Title",
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
                        controller: _notesController,
                        decoration: InputDecoration(
                          labelText: "Notes (Optional)",
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _dueController,
                        decoration: InputDecoration(
                          labelText: "Due Date",
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
                  _editTask(index);
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

  void _editTask(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/edittask.php"),
        body: {
          "taskid": _taskList[index]['taskid'],
          "task": _taskController.text.toString(),
          "due": _dueController.text.toString(),
          "notes": _notesController.text.toString(),
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Edit Task Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadTask();
      } else {
        Fluttertoast.showToast(
            msg: "Edit Task Failed",
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

  _deleteTaskDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete This Task?',
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
                      _deleteTask(index);
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

  void _deleteTask(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/deletetask.php"),
        body: {
          "taskid": _taskList[index]['taskid'],
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Delete Task Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadTask();
      } else {
        Fluttertoast.showToast(
            msg: "Delete Task Failed",
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
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadstudenttaskstatus.php"),
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
        // titleCenter = "Contain Data";
        setState(() {});
        print(_classStudentList);
      }
    });
  }
}
