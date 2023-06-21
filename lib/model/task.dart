import '../global/variable_global.dart';

class Task{
  int? id;
  late String title;
  late String date;
  late String status;

  Task(this.title,this.date,this.status);

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {
      
      VarGlob.columnTitle : title,
      VarGlob.columndate : date,
      VarGlob.columnStatus : status 
    };

    if (id != null){
      map[VarGlob.columnId] = id;
    }

    return map;
  }

  Task.fromMap(Map<String,dynamic> map)  {
      id = map[VarGlob.columnId];
      title = map[VarGlob.columnTitle];
      date = map[VarGlob.columndate];
      status = map[VarGlob.columnStatus];
  }



}