import 'package:flutter/material.dart';
import 'package:todo/modules/Archive.dart';
import 'package:todo/modules/Done.dart';
import 'package:todo/modules/Tasks.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentModules = 0;
  List<Widget> Modules = [Tasks(), DoneTasks(), ArchiveTasks()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Modules[currentModules],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentModules,
        onTap: (index) {
          setState(() {
            currentModules = index;
          });
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
    );
  }
}
