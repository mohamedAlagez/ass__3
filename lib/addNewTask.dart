import 'package:ass_3/DBHelper.dart';
import 'package:ass_3/allTasks.dart';
import 'package:ass_3/taskPage.dart';
import 'package:ass_3/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addNewTask extends StatefulWidget {
  @override
  addNewTaskState createState() => addNewTaskState();
}

class addNewTaskState extends State<addNewTask> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  String _taskName;
  int _isComplete = 0;

  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper.dbHelper;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add new task'),
        ),
        body: Column(children: [
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    onSaved: (value) {
                      _taskName = value;
                    },
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.blue,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "Task Name",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.blue,
                        )),
                  ),
                ),
                Container(
                    child: CheckboxListTile(
                        title: Text('Is Complete Task'),
                        value: _isComplete == 1,
                        onChanged: (value) {
                          if (value == true) {
                            _isComplete = 1;
                          } else {
                            _isComplete = 0;
                          }
                          setState(() {});
                        })),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 200,
                        height: 60,
                        padding: EdgeInsets.all(5),
                        margin:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        child: RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text("ADD NEW TASK"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              if (_formStateKey.currentState.validate()) {
                                _formStateKey.currentState.save();
                                dbHelper.addNewTask(
                                    Task(null, _taskName, _isComplete));
                              }
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(builder: (context) {
                                return taskPage();
                              }));
                            })),
                    Container(
                        width: 120,
                        height: 60,
                        padding: EdgeInsets.all(5),
                        margin:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                        child: RaisedButton(
                            color: Colors.white,
                            textColor: Colors.blue,
                            child: Text("CANCEL"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(builder: (context) {
                                return taskPage();
                              }));
                            })),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
