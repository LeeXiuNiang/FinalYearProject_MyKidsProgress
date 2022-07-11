import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mykidsprogress/mydrawer.dart';
import 'package:mykidsprogress/newclass.dart';
import 'package:mykidsprogress/newstudent.dart';
import 'user.dart';

class ManageClassesScreen extends StatefulWidget {
  final User user;

  const ManageClassesScreen({Key key, this.user}) : super(key: key);

  @override
  _ManageClassesScreenState createState() => _ManageClassesScreenState();
}

class _ManageClassesScreenState extends State<ManageClassesScreen> {
  List _classList;
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
        title: Text("Manage Classes"),
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              controller: _srcController,
              onChanged: (_srcController) {
                _loadClasses(_srcController);
              },
              decoration: InputDecoration(
                hintText: "Search class...",
                suffixIcon: IconButton(
                  onPressed: () => _searchClasses(_srcController.text),
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.white24)),
              ),
            ),
          ),
          if (_classList == null)
            Flexible(child: Center(child: Text(titleCenter)))
          else
            Flexible(child: OrientationBuilder(builder: (context, orientation) {
              return GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 1.9,
                  children: List.generate(_classList.length, (index) {
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
                                                      _classList[index]
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
                                                          flex: 6,
                                                          child: Text(
                                                              "Class ID",
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
                                                            _classList[index]
                                                                ['classid'],
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
                                                          flex: 6,
                                                          child: Text("Teacher In Charged",
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
                                                            _classList[index]
                                                                ['teachername'],
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 5, 5, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 6,
                                                          child: Text("Subjects",
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
                                                            _classList[index]
                                                                ['sub1']+" , "+_classList[index]
                                                                ['sub2']+" , ",
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
                                                          5, 0, 5, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 6,
                                                          child: Text("",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text("",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _classList[index]
                                                                ['sub3']+" , "+_classList[index]
                                                                ['sub4']+" , ",
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
                                                          5, 0, 5, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                          flex: 6,
                                                          child: Text("",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Text("",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                              ))),
                                                      Expanded(
                                                        flex: 7,
                                                        child: Text(
                                                            _classList[index]
                                                                ['sub5'],
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
                                                    {_editClassDialog(index)},
                                              ),
                                              SizedBox(height: 30),
                                              GestureDetector(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.indigo[900],
                                                ),
                                                onTap: () => {
                                                  _deleteClassDialog(index)
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
                  builder: (context) => NewClassForm(user: widget.user)));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _loadClasses(String name) {
    checkAdmin();
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/loadclasses.php"),
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
        _classList = jsondata["classes"];
        titleCenter = "Contain Data";
        setState(() {});
        print(_classList);
      }
    });
  }

  Future<void> _testasync() async {
    _loadClasses("");
  }

  _searchClasses(String name) {
    _loadClasses(name);
    if (titleCenter == "No data") {
      Fluttertoast.showToast(
          msg: "We couldn't find anything for \" " + _srcController.text + " \"",
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

  void _editClassDialog(int index) {
    _nameController.text = _classList[index]['name'];
    _teacherController.text = _classList[index]['teacher'];
    _sub1Controller.text = _classList[index]['sub1'];
    _sub2Controller.text = _classList[index]['sub2'];
    _sub3Controller.text = _classList[index]['sub3'];
    _sub4Controller.text = _classList[index]['sub4'];
    _sub5Controller.text = _classList[index]['sub5'];
    
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
    String classid = _classList[index]['classid'];
    String name = _nameController.text.toString();
    String oldteacher = _classList[index]['teacher'];
    String teacher = _teacherController.text.toString();
    String sub1 = _sub1Controller.text.toString();
    String sub2 = _sub2Controller.text.toString();
    String sub3 = _sub3Controller.text.toString();
    String sub4 = _sub4Controller.text.toString();
    String sub5 = _sub5Controller.text.toString();

    if (classid.isEmpty ||
        name.isEmpty ||
        teacher.isEmpty ||
        sub1.isEmpty ||
        sub2.isEmpty ||
        sub3.isEmpty ||
        sub4.isEmpty || 
        sub5.isEmpty) {
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

    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/editclasses.php"),
        body: {
          "classid": classid,
          "name": name,
          "oldteacher": oldteacher,
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
        _loadClasses("");
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

  _deleteClassDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete this class?',
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
                      _deleteClass(index);
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

  void _deleteClass(int index) {
    String classid = _classList[index]['classid'];
    String staffid = _classList[index]['teacher'];
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/deleteclasses.php"),
        body: {
          "classid": classid,
          "staffid": staffid,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Delete Class Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        _loadClasses("");
      } else {
        Fluttertoast.showToast(
            msg: "Delete Class Failed",
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
