import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mykidsprogress/mainscreen.dart';
import 'package:mykidsprogress/newchapter.dart';
import 'package:mykidsprogress/subject.dart';
import 'package:mykidsprogress/user.dart';
import 'package:http/http.dart' as http;

class SyllabusScreen extends StatefulWidget {
  final User user;
  final Subject subject;

  const SyllabusScreen({Key key, this.user, this.subject}) : super(key: key);

  @override
  _SyllabusScreenState createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen>
    with WidgetsBindingObserver {
  bool _isStaff = false;
  bool _isTeacher = true;
  List _syllabusList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  bool _statusPending = true;
  bool _isAdmin = false;
  TextEditingController _chapnoController = new TextEditingController();
  TextEditingController _chapterController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    checkStaff();
    WidgetsBinding.instance.addObserver(this);
    _testasync();
    print("Init tab 1");
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
              if (_syllabusList == null)
                Flexible(child: Center(child: Text(titleCenter)))
              else
                Flexible(
                    child: OrientationBuilder(builder: (context, orientation) {
                  return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 4.6,
                      children: List.generate(_syllabusList.length, (index) {
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
                                                              .fromLTRB(
                                                          20, 10, 5, 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              flex: 5,
                                                              child: Text(
                                                                  "Chapter " +
                                                                      _syllabusList[
                                                                              index]
                                                                          [
                                                                          'chapno'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ))),
                                                          Expanded(
                                                              flex: 1,
                                                              child: Text(":",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ))),
                                                          Expanded(
                                                            flex: 7,
                                                            child: Text(
                                                                _syllabusList[
                                                                        index]
                                                                    ['chapter'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          45, 5, 0, 10),
                                                      child: Text(
                                                          _syllabusList[index]
                                                              ['status'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          )),
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
                                                            _editChapterDialog(
                                                                index);
                                                          } else if (result ==
                                                              1) {
                                                            _updateStatusDialog1(
                                                                index);
                                                          } else if (result ==
                                                              2) {
                                                            _updateStatusDialog2(
                                                                index);
                                                          } else if (result ==
                                                              3) {
                                                            _deleteChapterDialog(
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
                                                              child: Text(
                                                                  'Mark as In Progress'),
                                                              value: 1,
                                                            ),
                                                            PopupMenuItem(
                                                              child: Text(
                                                                  'Mark as Completed'),
                                                              value: 2,
                                                            ),
                                                            PopupMenuItem(
                                                              child:
                                                                  Text('Delete'),
                                                              value: 3,
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
                                        )))));
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
                      builder: (context) => NewChapterForm(
                          user: widget.user, subject: widget.subject)));
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Future<void> _testasync() async {
    _loadSyllabus();
    checkAdmin();
  }

  void _loadSyllabus() {
    http.post(
      Uri.parse(
          "https://crimsonwebs.com/s272033/mykidsprogress/php/loadsyllabus.php"),
      body: {
        "classid": widget.subject.classid,
        "subjectid": widget.subject.subjectid
      },
    ).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        setState(() {
            titleCenter = "No Data";
        });
        
        return;
      } else {
        var jsondata = json.decode(response.body);
        _syllabusList = jsondata["syllabus"];
        titleCenter = "Loading...";
        setState(() {});
        print(_syllabusList);
      }
    });
  }

  void _editChapterDialog(int index) {
    _chapnoController.text = _syllabusList[index]['chapno'];
    _chapterController.text = _syllabusList[index]['chapter'];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Edit This Chapter?"),
            content: SingleChildScrollView(
              child: new Container(
                height: 140,
                width: 240,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _chapnoController,
                        decoration: InputDecoration(
                          labelText: "Chapter Number",
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
                        controller: _chapterController,
                        decoration: InputDecoration(
                          labelText: "Chapter Title",
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
                  _editChapter(index);
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

  void _editChapter(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/editchapter.php"),
        body: {
          "chapterid": _syllabusList[index]['chapterid'],
          "chapterno": _chapnoController.text.toString(),
          "chapter": _chapterController.text.toString(),
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Edit Chapter Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadSyllabus();
      } else {
        Fluttertoast.showToast(
            msg: "Edit Chapter Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void _updateStatusDialog1(int index) {
    String status = "In Progress";
    if (_syllabusList[index]['status'] == "In Progress") {
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
                    'Update status of this chapter to \'In Progress\'?',
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
                        _updateChapterStatus(index,status);
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

  void _updateStatusDialog2(int index) {
    String status = "Completed";
    if (_syllabusList[index]['status'] == "Completed") {
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
                    'Update status of this chapter to \'Completed\'?',
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
                        _updateChapterStatus(index,status);
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

  void _updateChapterStatus(int index, String status) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/updatechapterstatus.php"),
        body: {
          "chapterid": _syllabusList[index]['chapterid'],
          "status": status,
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
        _loadSyllabus();
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

  void checkAdmin() {
    setState(() {
      if (widget.user.email == 'xnlee1999@gmail.com') {
        _isAdmin = true;
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

  _deleteChapterDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete This Chapter?',
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
                      _deleteChapter(index);
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

  void _deleteChapter(int index) {
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/deletechapters.php"),
        body: {
          "chapterid": _syllabusList[index]['chapterid'],
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Delete Chapter Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadSyllabus();
      } else {
        Fluttertoast.showToast(
            msg: "Delete Chapter Failed",
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
