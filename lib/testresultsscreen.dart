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
import 'package:mykidsprogress/test.dart';
import 'user.dart';

class TestResultsScreen extends StatefulWidget {
  final User user;
  final Subject subject;
  final Test test;

  const TestResultsScreen({Key key, this.user, this.subject, this.test})
      : super(key: key);

  @override
  _TestResultsScreenState createState() => _TestResultsScreenState();
}

class _TestResultsScreenState extends State<TestResultsScreen> {
  List _classStudentList;
    TextEditingController _marksController = new TextEditingController();
  TextEditingController _gradeController = new TextEditingController();
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
          title: Text(widget.test.testname),
        ),
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 15, 5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text("Full Marks",
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
                    child: Text(widget.test.testmarks + " %",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(25, 0, 5, 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Expanded(
            //           flex: 3,
            //           child: Text("Avg. Marks",
            //               style: TextStyle(
            //                 fontSize: 16,
            //               ))),
            //       Expanded(
            //           flex: 1,
            //           child: Text(":",
            //               style: TextStyle(
            //                 fontSize: 16,
            //               ))),
            //       Expanded(
            //         flex: 7,
            //         child: Text(widget.task.tasknote,
            //             style: TextStyle(
            //               fontSize: 16,
            //             )),
            //       ),
            //     ],
            //   ),
            // ),
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
                        flex: 5,
                        child: Text("Name",
                            overflow: TextOverflow.ellipsis,
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
                        flex: 2,
                        child: Text("Marks",
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
                        flex: 2,
                        child: Text("Grade",
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
                    childAspectRatio: 8,
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
                                        child: Text(
                                            _classStudentList[index]['studentid'])),
                                    Container(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        )),
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        _classStudentList[index]['studentname'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            _classStudentList[index]['marks'])),
                                    Container(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                          thickness: 1,
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            _classStudentList[index]['grade'])),
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
                                        children: [
                                          GestureDetector(
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                              color: Colors.indigo[900],
                                            ),
                                            onTap: () => {_updateResultsDialog(index)},
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
    String testid = widget.test.testid;
    print(subjectid);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadtestresults.php"),
        body: {"subjectid": subjectid, "classid": classid, "testid": testid}).then((response) {
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

  void _updateResultsDialog(int index) {
    _marksController.text = _classStudentList[index]['marks'];
    _gradeController.text = _classStudentList[index]['grade'];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update Results"),
            content: SingleChildScrollView(
              child: new Container(
                width: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text("ID",
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
                                child: Text(_classStudentList[index]['studentid']),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:20
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text("Name",overflow: TextOverflow
                                                              .ellipsis,
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
                                child: Text(_classStudentList[index]['studentname']),
                              ),
                            ],
                          ),SizedBox(
                            height:15
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text("Marks",overflow: TextOverflow
                                                              .ellipsis,
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
                                child: TextField(
                              controller: _marksController,
                              keyboardType: TextInputType.number,
                              
                            ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:15
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Text("Grade",overflow: TextOverflow
                                                              .ellipsis,
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
                                child: TextField(
                              controller: _gradeController,
                              keyboardType: TextInputType.name,
                              
                            ),
                              ),
                            ],
                          ),
                        ],
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
                  _updateResults(index);
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

  void _updateResults(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/updatetestresults.php"),
        body: {
          "id": _classStudentList[index]['id'],
          "marks": _marksController.text.toString(),
          "grade": _gradeController.text.toString(),
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Update Result Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadClassStudents();
      } else {
        Fluttertoast.showToast(
            msg: "Update Result Failed",
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
