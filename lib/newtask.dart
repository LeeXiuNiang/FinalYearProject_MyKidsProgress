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

class NewTaskForm extends StatefulWidget {
  final User user;
  final Subject subject;

  const NewTaskForm({Key key, this.user, this.subject}) : super(key: key);

  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  ProgressDialog pr;
  double screenHeight, screenWidth;

  TextEditingController _taskController = new TextEditingController();
  TextEditingController _notesController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  var df = new DateFormat("dd-MM-yyyy hh:mm a");
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Task Form'),
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
                      Text("Task's Details:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _taskController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Task Title'),
                  ),
                  TextField(
                    controller: _notesController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Notes (optional)'),
                  ),
                  SizedBox(height: 10),
                   InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: TextFormField(
                      style: TextStyle(fontSize: 14),
                      //textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      // onSaved: (String val) {
                      //   _setDate = val;
                      // },
                      // controller: _dobController,
                      decoration: InputDecoration(
                          labelText: 'Due Date',
                          suffixIcon: Icon(Icons.calendar_today_outlined)),
                    ),
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
        _taskController.text.toString() == ""||
         _dateController.text.toString() == "" ) {
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
    String task = _taskController.text.toString();
    String notes;
    if(_notesController.text.toString()==""){
        notes = "-";
    }else{
      notes = _notesController.text.toString();
    } 
    String due = _dateController.text.toString();
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newtask.php"),
        body: {
          "task": task,
          "notes": notes,
          "due": due,
          "classid": widget.subject.classid,
          "subjectid": widget.subject.subjectid,
        }).then((response) {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      print(response.body);
      if (response.body == "success") {
        http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newtaskstatus.php"),
        body: {

          "subjectid": widget.subject.subjectid,
          "classid": widget.subject.classid,
        }).then((response) {
          http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/updatetaskdetails.php"),
        body: {

          "subjectid": widget.subject.subjectid,
        }).then((response) {});
        });
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          _taskController.text = "";
          _notesController.text = "";
          _dateController.text = "";
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now().add(Duration(days: 0)),
        lastDate: DateTime(2044));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
  }

}
