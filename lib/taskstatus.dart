import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mykidsprogress/mydrawer.dart';
import 'package:mykidsprogress/newstudent.dart';
import 'package:mykidsprogress/progressscreen.dart';
import 'package:mykidsprogress/subject.dart';
import 'package:mykidsprogress/task.dart';
import 'package:mykidsprogress/tasksscreen.dart';
// import 'package:winfung_gate/newproduct.dart';
// import 'cartpage.dart';
// import 'mydrawer.dart';
import 'user.dart';

class TaskStatusScreen extends StatefulWidget {
  final User user;
  final Subject subject;
  final Task task;

  const TaskStatusScreen({Key key, this.user, this.subject, this.task})
      : super(key: key);

  @override
  _TaskStatusScreenState createState() => _TaskStatusScreenState();
}

class _TaskStatusScreenState extends State<TaskStatusScreen> {
  List _classStudentList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');
  int cartitem = 0;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _testasync();
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
                builder: (content) => ProgressScreen(
                    user: widget.user, subject: widget.subject)));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.task.taskname),
        ),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 5, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text("Due Date",
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
                    child: Text(widget.task.taskdue,
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text("Notes",
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
                    child: Text(widget.task.tasknote,
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[350],
              height: 2,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 10, 0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text("ID",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ))),
                      Container(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          )),
                      Expanded(
                        flex: 7,
                        child: Text("Name",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          )),
                      Expanded(
                        flex: 3,
                        child: Text("Status",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          )),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("")],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 375,
              child: Divider(
                color: Colors.black,
                height: 2,
                thickness: 1,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            if (_classStudentList == null)
              Flexible(child: Center(child: Text(titleCenter)))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 9,
                    children: List.generate(_classStudentList.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(_classStudentList[index]
                                            ['studentid'])),
                                    Container(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        )),
                                    Expanded(
                                      flex: 7,
                                      child: Text(_classStudentList[index]
                                          ['studentname']),
                                    ),
                                    Container(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                          _classStudentList[index]['status']),
                                    ),
                                    Container(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            child: Icon(
                                              Icons.check,
                                              color: Colors.indigo[900],
                                            ),
                                            onTap: () =>
                                                {_updateStatusDialog(index)},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.black,
                                  height: 2,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }));
              })),
          ]),
        ),
      ),
    );
  }

  void _loadClassStudents() {
    String subjectid = widget.subject.subjectid;
    String classid = widget.subject.classid;
    String taskid = widget.task.taskid;
    print(taskid);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadtaskstatus.php"),
        body: {"subjectid": subjectid, "classid": classid, "taskid": taskid}).then((response) {
      if (response.body == "nodata") {
        titleCenter = "No data";
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

  Future<void> _testasync() async {
    _loadClassStudents();
  }

  void checkAdmin() {
    setState(() {
      if (widget.user.email == 'jasminelxn@yahoo.com') {
        _isAdmin = true;
      }
    });
  }

  void _updateStatusDialog(int index) {
    if (_classStudentList[index]['status'] == "Completed") {
      Fluttertoast.showToast(
          msg: "Status Updated Failed due to same progress status.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      showDialog(
          builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: new Text(
                    'Update status of this student to \'Completed\'?',
                    style: TextStyle(),
                  ),
                  content: new Text(
                    'Are your sure?',
                    style: TextStyle(),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Yes",
                          style:
                              TextStyle(color: Theme.of(context).accentColor)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _updateTaskStatus(index);
                      },
                    ),
                    TextButton(
                        child: Text("No",
                            style: TextStyle(
                                color: Theme.of(context).accentColor)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ]),
          context: context);
    }
  }

  void _updateTaskStatus(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/updatetaskstatus.php"),
        body: {
          "id": _classStudentList[index]['id'],
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Status Updated Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
            _loadClassStudents();
      } else {
        Fluttertoast.showToast(
            msg: "Status Updated Failed",
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
