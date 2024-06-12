import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);
  // make only one instance from cubit class to get it any else where

  var addTextController = TextEditingController();
  //to be able to take the text as string from inside text field and put it in the table

initSql () async {

  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'goals.db');

  // open the database
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            '''CREATE TABLE Goals
             (id INTEGER PRIMARY KEY,
              name TEXT
              )''');
      });
}

  List<Map> goalslist = [];

getData () async {

  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'goals.db');

  // open the database
  Database database = await openDatabase(path);

  // Get the records
  await database.rawQuery('SELECT * FROM Goals').then((value){

goalslist=value;

emit(GetDataSuccessState());

  }).catchError((onError){
    emit(GetDataErrorState());
    print(onError.toString());
  });

  // Close the database
  database.close();
}

insertData (String name) async {
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'goals.db');

  // open the database
  Database database = await openDatabase(path);

  // Insert some records in a transaction

  await database.rawInsert(
        'INSERT INTO Goals(name) VALUES(?)',
        [name]).then((value) {
          emit(InsertDataSuccessState());
  }).catchError((onError) {
    emit(InsertDataErrorState());
    print(onError.toString());
  });
  database.close();
}

removeData (id) async {
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'goals.db');

  // open the database
  Database database = await openDatabase(path);
  await database.rawDelete('DELETE FROM Goals WHERE id = ?',
      ['$id']).then((value) {
        emit(RemoveDataSuccessState());
  }).catchError((onError) {
        emit(RemoveDataErrorState());
        print(onError.toString());
  });



}


}

