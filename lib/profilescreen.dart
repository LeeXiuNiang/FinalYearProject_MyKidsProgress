import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mykidsprogress/mydrawer.dart';
import 'package:mykidsprogress/user.dart';

import 'loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _usernamecontroller = new TextEditingController();
  TextEditingController _currentPasswordcontroller =
      new TextEditingController();
  TextEditingController _newPasswordcontrollerA = new TextEditingController();
  TextEditingController _newPasswordcontrollerB = new TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      drawer: MyDrawer(user: widget.user),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(100, 30, 100, 10),
                child: Image.asset('assets/images/profile.png')),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.email_outlined,
                      color: Theme.of(context).accentColor),
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Text("Email",
                                style: TextStyle(
                                  fontSize: 16,
                                ))),
                        Expanded(
                          flex: 1,
                          child: Text(" : ",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                        Expanded(
                          flex: 10,
                          child: Text(widget.user.email,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.person_outline,
                      color: Theme.of(context).accentColor),
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 5,
                            child: Text("Username",
                                style: TextStyle(
                                  fontSize: 16,
                                ))),
                        Expanded(
                          flex: 1,
                          child: Text(" : ",
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(widget.user.name,
                              style: TextStyle(
                                fontSize: 16,
                              )),
                        ),
                      ],
                    ),
                  ),
                  trailing: GestureDetector(
                      child: Icon(Icons.edit, color: Colors.grey),
                      onTap: _changeUsernameDialog),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.lock_outline,
                      color: Theme.of(context).accentColor),
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Change password",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                                SizedBox(height: 8),
                                Text(
                                    "It's a good idea to change password regularly",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[600],
                                    )),
                              ],
                            )),
                      ],
                    ),
                  ),
                  trailing: GestureDetector(
                      child:
                          Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                      onTap: _changePasswordDialog),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeUsernameDialog() {
    _usernamecontroller.text = widget.user.name;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Change Your Username?"),
            content: SingleChildScrollView(
              child: new Container(
                height: 140,
                width: 300,
                child: Column(
                  children: [
                    Text("You may need to re-login to update your profile.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Text("Enter new username"),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      child: TextField(
                        controller: _usernamecontroller,
                        decoration: InputDecoration(
                          labelText: "New Username",
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          prefixIcon: Icon(Icons.person),
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
                  _changeUsername();
                  //Navigator.of(context).pop();
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

  void _changePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        bool _obscureText = true;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Change Your Password?"),
              content: SingleChildScrollView(
                child: Container(
                  height: 270,
                  width: 300,
                  child: Column(
                    children: [
                      Text("You may need to re-login to update your profile.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Text("Enter your passwords"),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        child: TextField(
                          controller: _currentPasswordcontroller,
                          decoration: InputDecoration(
                            labelText: "Current Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.security_outlined),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
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
                          controller: _newPasswordcontrollerA,
                          decoration: InputDecoration(
                            labelText: "New Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
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
                          controller: _newPasswordcontrollerB,
                          decoration: InputDecoration(
                            labelText: "Retype New Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                  print(_obscureText);
                                });
                              },
                              icon: Icon(
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
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Confirm",
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  onPressed: () {
                    changePassword();
                    //Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Cancel",
                      style: TextStyle(color: Theme.of(context).accentColor)),
                  onPressed: () {
                    _currentPasswordcontroller.text = "";
                    _newPasswordcontrollerA.text = "";
                    _newPasswordcontrollerB.text = "";
                    _obscureText = true;
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _changeUsername() {
    String _newname = _usernamecontroller.text.toString();

    if (_newname.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter new username.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    String role = widget.user.role;
    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/changeusername.php"),
        body: {
          "role": role,
          "email": widget.user.email,
          "newname": _newname,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Change Name Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => LoginScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Change Name Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void changePassword() {
    String role = widget.user.role;
    String _curPass = _currentPasswordcontroller.text.toString();
    String _newPassA = _newPasswordcontrollerA.text.toString();
    String _newPassB = _newPasswordcontrollerB.text.toString();
    print(widget.user.password);

    if (_curPass.isEmpty || _newPassA.isEmpty || _newPassB.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please enter current and new passwords.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_curPass != widget.user.password) {
      Fluttertoast.showToast(
          msg: "Please make sure current password is correct.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_newPassA != _newPassB) {
      Fluttertoast.showToast(
          msg: "Please make sure both new passwords are the same.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent[700],
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    if (_newPassA.length < 6) {
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

    http.post(
        Uri.parse(
            "https://www.crimsonwebs.com/s272033/mykidsprogress/php/changepassword.php"),
        body: {
          "role": role,
          "email": widget.user.email,
          "newpass": _newPassA,
        }).then((response) {
      print(response.body);
      if (response.body == "failed") {
        Fluttertoast.showToast(
            msg: "Change Password Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Change Password Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => LoginScreen()));
      }
    });
  }
}
