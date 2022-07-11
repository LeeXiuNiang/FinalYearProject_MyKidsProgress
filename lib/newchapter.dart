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

class NewChapterForm extends StatefulWidget {
  final User user;
  final Subject subject;

  const NewChapterForm({Key key, this.user, this.subject}) : super(key: key);

  @override
  _NewChapterFormState createState() => _NewChapterFormState();
}

class _NewChapterFormState extends State<NewChapterForm> {
  ProgressDialog pr;
  double screenHeight, screenWidth;

  TextEditingController _chapnoController = new TextEditingController();
  TextEditingController _chapController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Syllabus Form'),
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
                      Text("Chapter's Details:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _chapnoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Chapter Number'),
                  ),
                  TextField(
                    controller: _chapController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Chapter Title'),
                  ),
                  
                  SizedBox(height: 30),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: screenWidth,
                      height: 50,
                      child: Text('Add Syllabus',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        postNewChapterDialog();
                      },
                      color: Theme.of(context).accentColor),
                  SizedBox(height: 10),
                ],
              ))),
        ),
      ),
    );
  }

  void postNewChapterDialog() {
    if (
        _chapnoController.text.toString() == "" ||
            _chapController.text.toString() == "" ) {
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
            title: Text("Add New Chapter?"),
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
    String no = _chapnoController.text.toString();
    String chapter = _chapController.text.toString();
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newsyllabus.php"),
        body: {
          "no": no,
          "chapter": chapter,
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
        setState(() {
          _chapnoController.text = "";
          _chapController.text = "";
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
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

}
