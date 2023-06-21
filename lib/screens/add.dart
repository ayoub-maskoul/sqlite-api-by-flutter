import 'package:flutter/material.dart';

import '../db/sqlHelper.dart';
import '../model/task.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  final _titlcontroller = TextEditingController();
  final _datecontroller = TextEditingController();
  var status = true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Users"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: [
              const Text("Add new User",style:TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.brown
              ))
              ,
              const SizedBox(height: 30),
              TextFormField(
                controller: _titlcontroller,
                decoration: const InputDecoration(
                  labelText: "Title",
                  prefixIcon: Icon(Icons.account_box),
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _datecontroller,
                decoration: const  InputDecoration(
                  labelText: "Date",
                  errorStyle: TextStyle(color: Colors.red),
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30),
              const Text("Status"),
              const SizedBox(height: 30),
              Checkbox(value: status, onChanged: (value) {
                setState(() {
                  
                status =value!;
                });
              },),
              TextButton(onPressed: () {
              String s ;
              if(status){
                s="terminé";

              }else{
              s="En cours";
              }
              
              var t =Task(_titlcontroller.text, _datecontroller.text, s);
              SqlHelper.instance!.insert(t);
              Navigator.pop(context,"res");
              }, child: const Text("Save"))


            ],
          ),
        ),
        )
      ;
}}