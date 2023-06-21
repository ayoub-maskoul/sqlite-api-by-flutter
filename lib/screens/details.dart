import 'package:flutter/material.dart';
import 'package:test/db/sqlHelper.dart';
import 'package:test/model/task.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
    Details({super.key,required this.task,required this.id});
    Task task;
    int id;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var status = false;
  @override
  void initState() {
    // ignore: unused_local_variable
    var status2 = widget.task.status.toString();
    if(widget.task.status=="terminé"){
    status=true;
    }else{
      status = false;
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var status2 = widget.task.status.toString();
    return Scaffold(
    appBar: AppBar(title: const Text("Details the Task"),),
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
            Text(status2),
            Checkbox(value: status, onChanged: (value) {
                setState(() {
                if(!status){
                
                var t = Task(widget.task.title.toString(), widget.task.date.toString(), "terminé");
                  SqlHelper.instance!.update(t,widget.id);
                status2="terminé";

                Navigator.pop(context,"finsing");
                }else{
                  
                var t = Task(widget.task.title.toString(), widget.task.date.toString(), "En cours");
                
                SqlHelper.instance!.update(t,widget.id);
                status2="En cours";
                Navigator.pop(context,"finsing");
                
                }
                  
                status =value!;
                });
              },),
            
        ],)
        ),
    );
  }
}