import 'package:sqflite/sqflite.dart';
import "../globals/variable_global.dart";
import "../model/todo.dart";

class SqlHelper{

    SqlHelper._privateConstractur();
    static SqlHelper? _instance;
    static SqlHelper? get instance => _instance ??= SqlHelper._privateConstractur();

    
    Database? _db;
    // Database?  getdb() {
    //    _db ??= await initialiseDatabase();
    // }

    Future<Database?> getDatabase() async {
      if (_db != null){
        return _db;
      }

      _db = await initialiseDatabase();
      return _db;
    }

    Future<Database> initialiseDatabase() async {
      var dir = await getDatabasesPath();
      var path = "${dir}task.db";
      return await openDatabase(path,version: 1,onCreate: _onCreate);
    }

  Future<void> _onCreate(Database db , int? version ) async {
      return await db.execute('''
    CREATE TABLE ${VarGlob.table}(
      ${VarGlob.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${VarGlob.columnTitle} TEXT,
      ${VarGlob.columndate} TEXT,
      ${VarGlob.columnStatus} TEXT
    )
''');
  }

  Future<List<Map>> getAll() async{
    Database? database = await getDatabase();
    return await Future.delayed(Duration(seconds: 0),(){
      return database!.rawQuery("SELECT * FROM ${VarGlob.table}");
    });
  }

  Future<int> delete(int id) async{
    Database? database = await getDatabase();
    return await database!.delete(VarGlob.table,where: "id=$id");
  }
  Future<int> deleteall() async{
    Database? database = await getDatabase();
    return await database!.delete(VarGlob.table,);
  }

  Future<int> insert(Task task) async{
    Database? database = await getDatabase();
    return await database!.insert(VarGlob.table,task.toMap());
  }

}