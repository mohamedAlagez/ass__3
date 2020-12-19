import 'package:ass_3/DBHelper.dart';
import 'package:ass_3/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InCompleteTasks extends StatefulWidget {
  @override
  inCompleteTasksState createState() => inCompleteTasksState();
}

class inCompleteTasksState extends State<InCompleteTasks> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  Future<List<Task>> tasks;

  bool _isComplete = false;

  DBHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper.dbHelper;
    refreshTasksList();
  }

  refreshTasksList() {
    setState(() {
      tasks = dbHelper.getInCompleteTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: tasks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Task Found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView generateList(List<Task> tasks) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Delete'),
            ),
            DataColumn(
              label: Text('Task'),
            ),
            DataColumn(
              label: Text('IsComplete'),
            )
          ],
          rows: tasks
              .map(
                (task) => DataRow(
                  cells: [
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          dbHelper.delete(task.id);
                          refreshTasksList();
                        },
                      ),
                    ),
                    DataCell(
                      Text(task.name),
                    ),
                    DataCell(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              value: task.isComplete == 1,
                              onChanged: (value) {
                                if (value == true) {
                                  task.isComplete = 1;
                                } else {
                                  task.isComplete = 0;
                                }
                                dbHelper.update(task);
                                refreshTasksList();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
