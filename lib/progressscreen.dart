import 'package:flutter/material.dart';
import 'package:mykidsprogress/subject.dart';
import 'package:mykidsprogress/syllabusscreen.dart';
import 'package:mykidsprogress/tasksscreen.dart';
import 'package:mykidsprogress/testscreen.dart';


import 'mydrawer.dart';
import 'user.dart';
 

 
class ProgressScreen extends StatefulWidget {
  final User user;
  final Subject subject;

  const ProgressScreen({Key key, this.user, this.subject}) : super(key: key);
  
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int _currentIndex = 0;
  List<Widget> tabchildren;
  String maintitle = "Progress";

  @override
  void initState() {
    super.initState();
    tabchildren = [SyllabusScreen(user: widget.user, subject: widget.subject), TasksScreen(user: widget.user, subject: widget.subject), TestsScreen(user: widget.user, subject: widget.subject)];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[300],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.indigo[900],
          unselectedItemColor: Colors.indigo[900].withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _currentIndex, 
          onTap: onTabTapped,
                    items: [
                      BottomNavigationBarItem(
                        label: 'Syllabus',
                        icon: Icon(Icons.list_alt_rounded),
                      ),
                      BottomNavigationBarItem(
                        label: 'Tasks',
                        icon: Icon(Icons.assignment_turned_in_outlined),
                      ),
                      BottomNavigationBarItem(
                        label: 'Tests',
                        icon: Icon(Icons.rule_rounded),
                      ),
                    ]),
                appBar: AppBar(
                  title: Text(widget.subject.subjectname),
                ),
                body:tabchildren[_currentIndex],
              );
            }
          
              void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      print(_currentIndex);
      if (_currentIndex == 0) {
        maintitle = "Syllabus";
      }
      if (_currentIndex == 1) {
        maintitle = "Tasks";
      }
      if (_currentIndex == 2) {
        maintitle = "Tests";
      }
    });
  }
}