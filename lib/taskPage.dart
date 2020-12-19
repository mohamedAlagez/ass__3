import 'package:ass_3/addNewTask.dart';
import 'package:ass_3/allTasks.dart';
import 'package:ass_3/completeTasks.dart';
import 'package:ass_3/inCompleteTasks.dart';
import 'package:flutter/material.dart';

class taskPage extends StatefulWidget {
  @override
  _taskPageState createState() => _taskPageState();
}

class _taskPageState extends State<taskPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'All Tasks',
                ),
                Tab(
                  text: 'Complete Tasks',
                ),
                Tab(
                  text: 'Incomplete Tasks',
                )
              ],
              isScrollable: true,
            ),
            title: Text('Tasks App'),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return addNewTask();
                }));
              },
              child: Icon(Icons.add)),
          body: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  children: [
                    AllTasks(),
                    CompleteTasks(),
                    InCompleteTasks(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
