
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/screens/add.dart';
import 'package:test/screens/details.dart';
import 'package:test/model/task.dart';

import '../db/sqlHelper.dart';
import 'package:http/http.dart' as http;


class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {


  //Saev data in sqflite by api
  Future <void> getRequest() async {
    String url = "https://my-json-server.typicode.com/youssefyazidi/api3/taches";

    final rep = await http.get(Uri.parse(url));

    var data = await json.decode(rep.body);
    SqlHelper.instance!.deleteall();

    for (var task in data){

    setState(() {
      
      var t =Task(task["titre"], task["date"], task["status"]);
      SqlHelper.instance!.insert(t);
    });
    }
  }
  @override
  void initState()  {
    setup();
    
    super.initState();
  }
  setup() async{
    await getRequest();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton( child:const Icon(Icons.add,color: Color.fromARGB(255, 255, 255, 255), ) ,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>const Add(),)).then((value) {
              if(value!=null){
                      setState(() {
                        
                      });
                    }
              });
            },
            ),
        appBar: AppBar(
          title:const Text('My app'),
          ),
        body: FutureBuilder(
          future: SqlHelper.instance!.getAll(),
          builder:(context, snapshot){
            
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child:  CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.data!.isEmpty){
              return const Center(
                child: Text("no data"),
              );
            }
            return ListView(children: snapshot.data!.reversed.map((e) {
              return ListTile(
                onLongPress: () {
                    showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Delete'),
                                content: const Text('Are you sure?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      
                                      SqlHelper.instance!.delete(e ["id"]);
                                      setState(() {
                                        
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                },
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Details(task: Task(e["title"].toString(),e["date"].toString(),e["status"].toString()),id:e['id']),)).then((value){
                    if(value!=null){
                      setState(() {
                        
                      });
                    }
                  });
                },
                title: Row(
                  children: [
                  SizedBox(width: 300,child: Text(e["title"].toString(),style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 15,),)),
                  e["status"].toString() == "terminé" ? const Icon(Icons.expand_circle_down_outlined) :const Icon(Icons.warning)

                ],)
              );
            }).toList());
            
          },
      
    ),
  

  );
  }
}
