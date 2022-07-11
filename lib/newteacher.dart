import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mykidsprogress/mainscreen.dart';
import 'package:mykidsprogress/manageteachers.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:mykidsprogress/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class NewTeacherForm extends StatefulWidget {
  final User user;

  const NewTeacherForm({Key key, this.user}) : super(key: key);

  @override
  _NewTeacherFormState createState() => _NewTeacherFormState();
}

class _NewTeacherFormState extends State<NewTeacherForm> {
  ProgressDialog pr;
  double screenHeight, screenWidth;
  // File _image;
  // String pathAsset = 'assets/images/camera.png';
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _staffIdController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _accPswController = new TextEditingController();
  int _radioValue = 0;
  String _gender = "Female";
  var df = new DateFormat("dd-MM-yyyy hh:mm a");
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('New Teacher Form'),
      ),
      body: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  // GestureDetector(
                  //   onTap: () => {_onPictureSelectionDialog()},
                  //   child: Container(
                  //       height: screenHeight / 3.2,
                  //       width: screenWidth / 2,
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: _image == null
                  //               ? AssetImage(pathAsset)
                  //               : FileImage(_image),
                  //           fit: BoxFit.scaleDown,
                  //         ),
                  //         border: Border.all(
                  //           width: 3.0,
                  //           color: Colors.grey,
                  //         ),
                  //         borderRadius: BorderRadius.all(Radius.circular(
                  //                 10.0) //         <--- border radius here
                  //             ),
                  //       )),
                  // ),
                  // SizedBox(height: 5),
                  // Text("Click to add product image",
                  //     style: TextStyle(fontSize: 10.0, color: Colors.black)),
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: _staffIdController,
                    decoration: InputDecoration(labelText: 'Staff ID'),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              _handleRadioValueChange(value);
                            },
                          ),
                          Text(
                            "Female",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              _handleRadioValueChange(value);
                            },
                          ),
                          Text("Male",
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: TextFormField(
                      style: TextStyle(fontSize: 14),
                      //textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dobController,
                      // onSaved: (String val) {
                      //   _setDate = val;
                      // },
                      // controller: _dobController,
                      decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          suffixIcon: Icon(Icons.calendar_today_outlined)),
                    ),
                  ),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _accPswController,
                    decoration: InputDecoration(labelText: 'Account Password'),
                  ),
                  SizedBox(height: 15),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: screenWidth,
                      height: 50,
                      child: Text('Add New Teacher',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      onPressed: () {
                        postNewTeacherDialog();
                      },
                      color: Theme.of(context).accentColor),
                  SizedBox(height: 10),
                ],
              ))),
        ),
      
    );
  }

  // _onPictureSelectionDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //           //backgroundColor: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //           content: new Container(
  //             //color: Colors.white,
  //             height: screenHeight / 4,
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Container(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       "Take picture from:",
  //                       style: TextStyle(
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16),
  //                     )),
  //                 SizedBox(height: 5),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Flexible(
  //                         child: MaterialButton(
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(5.0)),
  //                       minWidth: 100,
  //                       height: 100,
  //                       child: Text('Camera',
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                           )),
  //                       //color: Color.fromRGBO(101, 255, 218, 50),
  //                       color: Theme.of(context).accentColor,
  //                       elevation: 10,
  //                       onPressed: () =>
  //                           {Navigator.pop(context), _chooseCamera()},
  //                     )),
  //                     SizedBox(width: 10),
  //                     Flexible(
  //                         child: MaterialButton(
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(5.0)),
  //                       minWidth: 100,
  //                       height: 100,
  //                       child: Text('Gallery',
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                           )),
  //                       //color: Color.fromRGBO(101, 255, 218, 50),
  //                       color: Theme.of(context).accentColor,
  //                       elevation: 10,
  //                       onPressed: () =>
  //                           {Navigator.pop(context), _chooseGallery()},
  //                     )),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ));
  //     },
  //   );
  // }

  // Future _chooseCamera() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(
  //     source: ImageSource.camera,
  //     maxHeight: 800,
  //     maxWidth: 800,
  //   );

  //   if (pickedFile != null) {
  //     _image = File(pickedFile.path);
  //   } else {
  //     print('No image selected.');
  //   }

  //   _cropImage();
  // }

  // _chooseGallery() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(
  //     source: ImageSource.gallery,
  //     maxHeight: 800,
  //     maxWidth: 800,
  //   );

  //   if (pickedFile != null) {
  //     _image = File(pickedFile.path);
  //   } else {
  //     print('No image selected.');
  //   }

  //   _cropImage();
  // }

  // _cropImage() async {
  //   File croppedFile = await ImageCropper.cropImage(
  //       sourcePath: _image.path,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.square,
  //       ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Crop your image',
  //           toolbarColor: Colors.red,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: true),
  //       iosUiSettings: IOSUiSettings(
  //         minimumAspectRatio: 1.0,
  //       ));

  //   if (croppedFile != null) {
  //     _image = croppedFile;
  //     setState(() {});
  //   }
  // }
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _gender = "Female";
          break;
        case 1:
          _gender = "Male";
          break;
      }
    });
  }

  void postNewTeacherDialog() {
    if (
        // _image == null ||
        _nameController.text.toString() == "" ||
            _staffIdController.text.toString() == "" ||
            _dobController.text.toString() == "" ||
            _phoneController.text.toString() == "" ||
            _emailController.text.toString() == "" ||
            _accPswController.text.toString() == "") {
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

    if (!validateEmail(_emailController.text)) {
      Fluttertoast.showToast(
          msg: "Please make sure the email format is correct.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_phoneController.text.length < 10) {
      Fluttertoast.showToast(
          msg: "Invalid. Phone number should be at least 10 numbers",
          toastLength: Toast.LENGTH_LONG,
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
            title: Text("Add New Teacher?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok",
                    style: TextStyle(color: Theme.of(context).accentColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _postNewTeacher();
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

  Future<void> _postNewTeacher() async {
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
    String name = _nameController.text.toString();
    String staffID = _staffIdController.text.toString();
    String gender = _gender;
    String dob = _dobController.text.toString();
    String phone = _phoneController.text.toString();
    String email = _emailController.text.toString();
    String password = _accPswController.text.toString();
    print(name);
    http.post(
        Uri.parse(
            "https://crimsonwebs.com/s272033/mykidsprogress/php/newteacher.php"),
        body: {
          "name": name,
          "staffID": staffID,
          "gender": gender,
          "dob": dob,
          "phone": phone,
          "email": email,
          "password": password,
          // "encoded_string": base64Image
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
          // _image = null;
          _nameController.text = "";
          _staffIdController.text = "";
          _radioValue = 0;
          _dobController.text = "";
          _phoneController.text = "";
          _emailController.text = "";
          _accPswController.text = "";
        });
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => ManageTeachersScreen(user: widget.user)));
      }else if(response.body == "duplicated"){
        Fluttertoast.showToast(
            msg: "Staff ID Duplicated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
      }else {
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
        initialDate: selectedDate,
        // initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1800, 1),
        lastDate: DateTime(2023));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

}
