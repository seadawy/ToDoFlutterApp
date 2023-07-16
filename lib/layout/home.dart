import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int x = 1;
  late Database db;
  List<Widget> Screens = [
    Center(child: Text("TASKS")),
    Center(child: Text("ADD NEW TASK")),
    Center(child: Text("ARCHIVE")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("To Do List")),
      ),
      body: Screens[x],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: x,
        onTap: (index) {
          setState(() {
            x = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_outlined),
            label: "Task",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "Archive",
          ),
        ],
      ),
    );
  }
}

class DBClass {
  late Database db;

  DBClass() {
    intiDB();
  }

  void intiDB() async {
    db = await openDatabase(
      "todo.db",
      version: 1,
      onCreate: (dbase, v) async {
        await dbase.execute(
          "CREATE TABLE Test "
          "(id INTEGER PRIMARY KEY, title TEXT,date TEXT,status INTEGER)",
        );
      },
      onOpen: (db) {},
    );
  }

  void insertDB(List<dynamic> values) async {
    await db.transaction(
      (txn) async {
        await txn.rawInsert(
            'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', values);
      },
    );
  }
}
