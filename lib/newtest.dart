import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mykidsprogress/manageteachers.dart';
import 'package:mykidsprogress/progressscreen.dart';
import 'package:mykidsprogress/subject.dart';
import 'package:mykidsprogress/syllabusscreen.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:mykidsprogress/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class NewTestForm extends StatefulWidget {
  final User user;
  final Subject subject;

  const NewTestForm({Key key, this.user, this.subject}) : super(key: key);

  @override
  _NewTestFormState createState() => _NewTestFormState();
}

class _NewTestFormState extends State<NewTestForm> {
  ProgressDialog pr;
  double screenHeight, screenWidth;

  TextEditingController _testController = new TextEditingController();
  TextEditingController _marksController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Test Form'),
      ),
      body: Container(
        child: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 25, 30, 15),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Test's Details:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _testController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Test Name'),
                  ),
                  TextField(
                    controller: _marksController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Full Marks'),
                  ),
                  
                  SizedBox(height: 30),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: screenWidth,
                      height: 50,
                      child: Text('Add Test',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        postNewTestDialog();
                      },
                      color: Theme.of(context).accentColor),
                  SizedBox(height: 10),
                ],
              ))),
        ),
      ),
    );
  }

  void postNewTestDialog() {
    if (
        _testController.text.toString() == "" ||
            _marksController.text.toString() == "" ) {
      Fluttertoast.showToast(
          msg: "Information not complete!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Add New Test?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _postNewChapter();
                },
              ),
              TextButton(
                  child: Text("Cancel",
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _postNewChapter() async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Adding...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
          height: 20,
          width: 20,
          margin: EdgeInsets.all(10),
          child: CircularProgressIndicator()),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();
    // String base64Image = base64Encode(_image.readAsBytesSync());
    String test = _testController.text.toString();
    String fmarks = _marksController.text.toString();
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newtest.php"),
        body: {
          "test": test,
          "fmarks": fmarks,
          "classid": widget.subject.classid,
          "subjectid": widget.subject.subjectid,
        }).then((response) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
          http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newtestresult.php"),
        body: {

          "subjectid": widget.subject.subjectid,
          "classid": widget.subject.classid,
        }).then((response) {
            http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/updatetestdetails.php"),
        body: {
          "subjectid": widget.subject.subjectid,
        }).then((response) {});
        });
        setState(() {
          _testController.text = "";
          _marksController.text = "";
        });
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => ProgressScreen(user: widget.user, subject: widget.subject)));
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
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
