import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:todo/modules/Archive.dart';
import 'package:todo/modules/Done.dart';
import 'package:todo/modules/Tasks.dart';

import 'package:todo/shared/variable.dart';

class Home extends StatelessWidget {
  //CONROLLERS
  var TitleController = TextEditingController();
  var TimeController = TextEditingController();
  var DateController = TextEditingController();

  //TOGGLES
  bool AddTaskState = false;
  int currentModules = 0;
  bool AddIcon = true;

  //KEYS
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var AddForm = GlobalKey<FormState>();

  late Database database;
  List<Widget> Modules = [Tasks(), DoneTasks(), ArchiveTasks()];

  void OpenDB() async {
    database = await openDatabase(
      'Todo.db',
      version: 1,
      onOpen: (database) {
        print("""DB IS OPENED""");
        getData(database).then((value) {
          listOfTasks = value;
        });
      },
      onCreate: (database, v) async {
        print("""NEW DB CREATED""");
        // tasks table
        await database.execute(
            'CREATE TABLE tasks(task_id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,Time TEXT,due TEXT);');
      },
    );
  }

  void insert(
      {required String title,
      required String time,
      required String date}) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert('INSERT INTO tasks (title,Time,due)'
              'VALUES("$title","$time","$date");')
          .then((value) {
        print("$value is inserted");
      }).catchError((error) {
        print("the error is $error");
      });
    });
  }

  Future<List<Map<String, dynamic>>> getData(database) async {
    List<Map<String, dynamic>> value =
        await database.rawQuery('SELECT * FROM tasks');
    return value;
  }


  @override
  Widget build(BuildContext contex4t) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: listOfTasks!.length == 0
          ? Center(child: CircularProgressIndicator())
          : Modules[currentModules],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentModules,
        onTap: (index) {
          currentModules = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "Archive",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(AddIcon ? Icons.add : Icons.arrow_downward_outlined),
        onPressed: () {
          if (AddTaskState) {
            AddTaskState = !AddTaskState;
            AddIcon = !AddIcon;
          } else {
            AddTaskState = !AddTaskState;
            AddIcon = !AddIcon;
            scaffoldKey.currentState
                ?.showBottomSheet(
                  elevation: 30,
                  (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: AddForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: TitleController,
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              labelText: "Title",
                              prefixIcon: Icon(Icons.title_sharp),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return "add Text";
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: TimeController,
                            keyboardType: TextInputType.none,
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                TimeController.text = value!.format(context);
                              });
                            },
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              labelText: "Time",
                              prefixIcon: Icon(Icons.access_time),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return "add Text";
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: DateController,
                            keyboardType: TextInputType.none,
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(4000),
                              ).then((value) {
                                DateController.text = formatDate(
                                    value!, [yyyy, '/', mm, '/', dd]);
                              });
                            },
                            style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              labelText: "Date",
                              prefixIcon: Icon(Icons.date_range),
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return "add Text";
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 50,
                            color: Colors.lightBlueAccent,
                            width: double.infinity,
                            child: MaterialButton(
                              child: Text("Save"),
                              onPressed: () {
                                if (AddForm.currentState!.validate()) {
                                  insert(
                                    title: TitleController.text,
                                    time: TimeController.text,
                                    date: DateController.text,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .closed
                .then((value) {
              AddTaskState = false;
              AddIcon = true;
            });
          }
        },
      ),
    );
  }
}
