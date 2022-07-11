import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mykidsprogress/mydrawer.dart';
import 'package:mykidsprogress/newteacher.dart';
import 'package:mykidsprogress/progressscreen.dart';
import 'package:mykidsprogress/subject.dart';
import 'package:mykidsprogress/syllabusscreen.dart';
// import 'package:winfung_gate/newproduct.dart';
// import 'cartpage.dart';
// import 'mydrawer.dart';
import 'user.dart';

class MainScreen extends StatefulWidget {
  final User user;
  final Subject subject;

  const MainScreen({Key key, this.user, this.subject}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _subjectTList;
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
  TextEditingController _emailController = new TextEditingController();
  var arr = ['Student', 'Teacher', 'Class'];
  var c = ['0', '0', '0'];

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
        title: Text("Dashboard"),
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
          child: Column(children: [
            if (_subjectTList == null)
              if (widget.user.role == 'Principal')
                Flexible(
                    child: OrientationBuilder(builder: (context, orientation) {
                  return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      children: List.generate(3, (index) {
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 6, 10, 5),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(arr[index],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(
                                                    "Total: " + c[index],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))),
                            ));
                      }));
                }))
              else
                Flexible(child: Center(child: Text(titleCenter)))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: List.generate(_subjectTList.length, (index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 6, 10, 5),
                          child: Container(
                              child: InkWell(
                            onTap: () async {
                              Navigator.of(context).pop();

                              Subject _subject = Subject(
                                subjectid: _subjectTList[index]['subjectid'],
                                classid: _subjectTList[index]['classid'],
                                subjectname: _subjectTList[index]
                                    ['subjectname'],
                              );
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => ProgressScreen(
                                        user: widget.user, subject: _subject)),
                              );
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
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 7),
                                                  child: Text(
                                                      _subjectTList[index]
                                                          ['subjectname'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          35, 5, 5, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 5,
                                                          child: Text("Class",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text(":",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _subjectTList[index]
                                                                ['classid'],
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ))),
                          )));
                    }));
              })),
          ]),
        ),
      ),
    );
  }

  void _loadTSubjects() {
    String staffid = widget.user.id;
    if (widget.user.role == 'Teacher') {
      http.post(
          Uri.parse(
              "https://crimsonwebs.com/s272033/mykidsprogress/php/loadsubjecttaught.php"),
          body: {"staffid": staffid}).then((response) {
        if (response.body == "nodata") {
          setState(() {
            titleCenter = "No data";
          });

          return;
        } else {
          var jsondata = json.decode(response.body);
          _subjectTList = jsondata["subjects"];
          titleCenter = "Contain Data";
          setState(() {});
          print(_subjectTList);
        }
      });
    } else if (widget.user.role == 'Parent') {
      http.post(
          Uri.parse(
              "https://crimsonwebs.com/s272033/mykidsprogress/php/loadsubjectstudied.php"),
          body: {"staffid": staffid}).then((response) {
        if (response.body == "nodata") {
          setState(() {
            titleCenter = "No data";
          });
          return;
        } else {
          var jsondata = json.decode(response.body);
          _subjectTList = jsondata["subjects"];
          setState(() {
            titleCenter = "Contain data";
          });

          print(_subjectTList);
        }
      });
    }
  }

  Future<void> _testasync() async {
    _loadTSubjects();
    test();
  }

  void checkAdmin() {
    setState(() {
      if (widget.user.email == 'jasminelxn@yahoo.com') {
        _isAdmin = true;
      }
    });
  }

  void test() {
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/counter.php"),
        body: {}).then((response) {
      print(response.body);
      List counter = response.body.split(",");
      setState(() {
        c[0] = counter[0];
        c[1] = counter[1];
        c[2] = counter[2];
      });
    });
  }
}
