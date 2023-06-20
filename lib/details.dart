




import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqfliteapp/model/todo.dart';

class Details extends StatefulWidget {
    Details({super.key,required this.task});
    Task task;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text("Details the Task")),
      body: Container(
      padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(children: [
            const Text("Title: "),
          SizedBox(width: 245, child: Text(widget.task.title.toString())),
          
          ],),
            const Text('Date:'),
            Text(widget.task.date.toString()),
            const Text('Status:'),
            Text(widget.task.status.toString()),

        ],)
        ),
    );
  }
}