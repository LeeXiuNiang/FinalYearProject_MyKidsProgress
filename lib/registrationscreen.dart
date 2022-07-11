import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import 'loginscreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _studentIDController = new TextEditingController();
  TextEditingController _passwordControllera = new TextEditingController();
  TextEditingController _passwordControllerb = new TextEditingController();
  bool _isChecked = false;
  bool _obscureText = true;
  double screenHeight, screenWidth;
  ProgressDialog prR;

  @override
  Widget build(BuildContext context) {
    prR = ProgressDialog(context);
    prR.style(
      message: 'Registrating...',
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

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(120, 10, 120, 10),
                child: Image.asset('assets/images/logo.png')
                ),
            SizedBox(
              height: 5,
            ),
            Card(
              margin: EdgeInsets.fromLTRB(30, 5, 30, 15),
              elevation: 10,
              //color: Colors.indigo[50],
              shadowColor: Colors.indigo[900],
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text('Registration',
                        style: Theme.of(context).textTheme.headline1),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _usernameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _studentIDController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Student ID",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _passwordControllera,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          suffix: InkWell(
                            onTap: _togglePass,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.indigo[400],
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _passwordControllerb,
                        decoration: InputDecoration(
                          labelText: "Enter Password Again",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          suffix: InkWell(
                            onTap: _togglePass,
                            child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.indigo[400]),
                          ),
                        ),
                        obscureText: _obscureText,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: _isChecked,
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).accentColor,
                            onChanged: (bool value) {
                              _onChange(value);
                            },
                          ),
                          GestureDetector(
                            onTap: _showEULA,
                            child: Text('I have read and agree to the TERMS',
                                style: Theme.of(context).textTheme.bodyText1),
                          ),
                        ]),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minWidth: 170,
                        height: 50,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _onRegister,
                        color: Theme.of(context).accentColor),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Text("Already Register?", style: TextStyle(fontSize: 16)),
              onTap: _alreadyRegister,
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      )),
    );
  }

  void _onChange(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _alreadyRegister() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }

  void _onRegister() {
    String _email = _emailController.text.toString();
    String _username = _usernameController.text.toString();
    String _phone = _phoneController.text.toString();
    String _studentID = _studentIDController.text.toString();
    String _passworda = _passwordControllera.text.toString();
    String _passwordb = _passwordControllerb.text.toString();


    if (_username.isEmpty ||
        _email.isEmpty ||
        _phone.isEmpty ||
        _studentID.isEmpty ||
        _passworda.isEmpty ||
        _passwordb.isEmpty) {
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

    if (!validateEmail(_email)) {
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
    
    if (_phone.length < 10) {
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

    if (_passworda != _passwordb) {
      Fluttertoast.showToast(
          msg: "Please make sure both passwords are the same.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_passworda.length < 6) {
      Fluttertoast.showToast(
          msg: "Password must be at least 6 characters long.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept TERMS to continue.",
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
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Register New User"),
            content: Text("Are you sure?"),
            actions: [
              TextButton(
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _registerUser(_email, _username, _phone, _studentID, _passworda);
                  }),
              TextButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _registerUser(
    String email, String username, String phone, String studentID, String password) async {
    prR = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await prR.show();
    
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/register_user.php"),
        body: {
          "email": email,
          "username": username,
          "phone": phone,
          "studentID": studentID,
          "password": password
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Registration Success. Please check your email for verification link.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        prR.hide().then((isHidden) {
          print(isHidden);
        });

        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => LoginScreen()));
      }else if (response.body == "noresult") {
        Fluttertoast.showToast(
            msg: "Invalid Student ID",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
        prR.hide().then((isHidden) {
          print(isHidden);
        });
      }else {
        Fluttertoast.showToast(
            msg: "Registration Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[700],
            textColor: Colors.white,
            fontSize: 16.0);
        prR.hide().then((isHidden) {
          print(isHidden);
        });
      }
    });
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("End-User License Agreement (EULA) "),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText2,
                            text:
                                "This End-User License Agreement (EULA) is a legal agreement between you and MyKidsProgress.\n\nThis EULA agreement governs your acquisition and use of our MyKidsProgress software (Software) directly from Universiti Utara Malaysia or indirectly through a Universiti Utara Malaysia authorized reseller or distributor (a Reseller). \n\nPlease read this EULA agreement carefully before completing the installation process and using the MyKidsProgress software. It provides a license to use the MyKidsProgress software and contains warranty information and liability disclaimers.\n\nIf you register for a free trial of the MyKidsProgress software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the MyKidsProgress software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.\n\nIf you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.\n\nThis EULA agreement shall apply only to the Software supplied by Universiti Utara Malaysia herewith regardless of whether other software is referred to or described herein. The terms also apply to any Universiti Utara Malaysia updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.\n\nThis EULA agreement shall apply only to the Software supplied by Universiti Utara Malaysia herewith regardless of whether other software is referred to or described herein. The terms also apply to any Universiti Utara Malaysia updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.\n\nUniversiti Utara Malaysia reserves the right to grant licences to use the Software to third parties.")),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
