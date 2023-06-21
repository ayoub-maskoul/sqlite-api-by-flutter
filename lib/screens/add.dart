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
  var status = true;

  DateTime? _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
      });
    });
  }

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
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30),
              
              ElevatedButton(
            onPressed: _presentDatePicker, child: const Text('Select Date')),
              const SizedBox(height: 30),
              Center(child: Text(_selectedDate ==null ? " ":_selectedDate.toString().substring(0, 10))),
              const SizedBox(height: 30),
              const Center(child: Text("Status")),
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
              
              var t =Task(_titlcontroller.text, _selectedDate.toString().substring(0, 10), s);
              SqlHelper.instance!.insert(t);
              Navigator.pop(context,"res");
              }, child: const Text("Save"))


            ],
          ),
        ),
        )
      ;
}}