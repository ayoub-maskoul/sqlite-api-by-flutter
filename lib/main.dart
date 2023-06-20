import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqfliteapp/details.dart';
import 'package:sqfliteapp/model/todo.dart';
import './db/sqlHelper.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {


   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final tv_controller = TextEditingController();
  
  // Read APi data
  Future <void> getRequest() async {
    String url = "https://my-json-server.typicode.com/youssefyazidi/api3/taches";

    final rep = await http.get(Uri.parse(url));

    var data = json.decode(rep.body);
    SqlHelper.instance!.deleteall();


    for (var task in data){

    setState(() {
      
      var t =Task(task["titre"], task["date"], task["status"]);
      SqlHelper.instance!.insert(t);
    });



    }

  }
  @override
  void initState() {
    getRequest();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
      
        appBar: AppBar(
        
          title: TextField(
            controller: tv_controller ,
          )
          ,),

        body: FutureBuilder(
          future: SqlHelper.instance!.getAll(),
          builder:(context, snapshot){
            


            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: const CircularProgressIndicator(),
              );
            }


            if (snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.data!.length == 0){
              return Center(
                child: Text("no data"),
              );
            }

            return ListView(children: snapshot.data!.map((e) {
              return ListTile(
                onLongPress: () {
                  setState(() {
                    SqlHelper.instance!.delete(e ["id"]);
                  });
                },
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Details(task: Task(e["title"].toString(),e["date"].toString(),e["status"].toString())),));
                },
                title: Row(
                  children: [
                  Container(width: 250,child: Text(e["title"].toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,),)),
                  e["status"].toString() == "terminé" ? Icon(Icons.expand_circle_down_outlined) : Icon(Icons.warning)

                ],)
              );
            }).toList());
            

          },


      
    ),
  
    floatingActionButton: FloatingActionButton( child: Icon(Icons.add,color: Colors.white,) ,onPressed: (){
      setState(() {
        var todo = Task(tv_controller.text, "true","2020");
        SqlHelper.instance!.insert(todo);
      });
    }),
  ));}
}


