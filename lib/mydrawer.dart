import 'package:flutter/material.dart';
import 'package:mykidsprogress/loginscreen.dart';
import 'package:mykidsprogress/mainscreen.dart';
import 'package:mykidsprogress/manageclass.dart';
import 'package:mykidsprogress/manageclasses.dart';
import 'package:mykidsprogress/managestudents.dart';
import 'package:mykidsprogress/manageteachers.dart';
import 'package:mykidsprogress/profilescreen.dart';
// import 'package:winfung_gate/loginscreen.dart';
// import 'package:winfung_gate/mainscreen.dart';
// import 'package:winfung_gate/mybooking.dart';
// import 'package:winfung_gate/profilescreen.dart';

// import 'bookingscreen.dart';
// import 'messaging.dart';
// import 'mypurchase.dart';
import 'user.dart';

class MyDrawer extends StatefulWidget {
  final User user;

  const MyDrawer({Key key, this.user}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isAdmin = false;
  bool _isStaff = false;
  bool _isTeacher = true;

  @override
  void initState() {
    super.initState();
    checkStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(widget.user.email),
          currentAccountPicture: CircleAvatar(
            backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Colors.white
                    : Colors.indigo,
            backgroundImage: AssetImage(
              "assets/images/profile.png",
            ),
          ),
          accountName: Text(widget.user.name),
        ),
        ListTile(
            title: Text("Dashboard"),
            leading: Icon(Icons.dashboard_outlined,
                color: Theme.of(context).accentColor),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainScreen(user: widget.user)));
            }),
                Visibility(
          visible: !_isTeacher && _isStaff,
          child: ListTile(
              title: Text("Manage Teachers"),
              leading: Icon(Icons.group_outlined,
                  color: Theme.of(context).accentColor),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ManageTeachersScreen(user: widget.user)));
              }),
        ),
        Visibility(
          visible: _isTeacher,
          child: ListTile(
              title: Text("Manage Students"),
              leading: Icon(Icons.group_outlined,
                  color: Theme.of(context).accentColor),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ManageStudentsScreen(user: widget.user)));
              }),
        ),
        Visibility(
          visible: _isTeacher,
          child: ListTile(
              title: Text("Manage Class"),
              leading: Icon(Icons.school_outlined,
                  color: Theme.of(context).accentColor),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ManageClassScreen(user: widget.user)));
              }),
        ),
        Visibility(
          visible: !_isTeacher && _isStaff,
          child: ListTile(
              title: Text("Manage Classes"),
              leading: Icon(Icons.school_outlined,
                  color: Theme.of(context).accentColor),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => ManageClassesScreen(user: widget.user)));
              }),
        ),

        // Visibility(
        //   visible: !_isAdmin,
        //   child: ListTile(
        //       title: Text("Contact Us"),
        //       leading: Icon(Icons.message_outlined,
        //           color: Theme.of(context).accentColor),
        //       trailing: Icon(Icons.arrow_forward),
        //       onTap: () {
        //         // Navigator.pop(context);
        //         // Navigator.pop(context);
        //         // Navigator.push(
        //         //     context,
        //         //     MaterialPageRoute(
        //         //         builder: (content) =>
        //         //             MessagingScreen(user: widget.user)));
        //       }),
        // ),
        Visibility(
          visible: !_isAdmin,
          child: ListTile(
              title: Text("My Profile"),
              leading: Icon(Icons.person_outline_outlined,
                  color: Theme.of(context).accentColor),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) =>
                            ProfileScreen(user: widget.user)));
              }),
        ),
        Divider(
          color: Colors.black87,
        ),
        ListTile(
            title: Text("Logout"),
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).accentColor,
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              _logoutDialog();
            })
      ],
    ));
  }

  void _logoutDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Do you want logout?',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => LoginScreen()));
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
}
