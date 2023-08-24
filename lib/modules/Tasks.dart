import 'package:flutter/material.dart';
import 'package:todo/shared/variable.dart';

class Tasks extends StatelessWidget {
  Tasks() {}

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              child: Text(
                "${listOfTasks?[i]['Time']}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${listOfTasks?[i]['title']}",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "${listOfTasks?[i]['due']}",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
      separatorBuilder: (context, i) => SizedBox(height: 20),
      itemCount: listOfTasks!.length,
    );
  }
}
