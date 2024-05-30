//create a table for storing the recently played 10 songs

import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  static const _databaseName = "user_db";
  static const _databaseVersion = 2;
  //creating the private constructor
  DatabaseHelper._privateconstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateconstructor();

  static Database? _database;
  //creating the getter to get the database
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: oncreate);
  }

  Future oncreate(Database db, int version) async {
    //creation of the recently played song in the database


  
await db.execute('''
  CREATE TABLE IF NOT EXISTS recent_played_songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    artist TEXT,
    album TEXT,
    albumId INTEGER
  )
''');

 

  // creation of the table for storing the facvourite song in the dataabase
  await db.execute('''
  CREATE TABLE IF NOT EXISTS favourite_songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    artist TEXT,
    album TEXT,
    albumId INTEGER
  )''');
// table for cut track song 
  await db.execute('''

  CREATE TABLE IF NOT EXISTS cut_track_songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    artist TEXT,
    album TEXT,
    albumId INTEGER
  )''');
    
  }
  //function to insert in the table cut track songs 
  Future<int> insertCutTrack(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert('cut_track_songs', row);
  }

  //function to query all the rows in the table cut track songs
  Future<List<Map<String, dynamic>>> queryAllCutTrackRows() async {
    Database? db = await instance.database;
    return await db!.query('cut_track_songs', orderBy: 'id DESC');
  }

  //function to insert in the table favourite songs
  Future<int> insertFavourite(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert('favourite_songs', row);
  }
  //function to query all the rows in the table favourite songs
  Future<List<Map<String, dynamic>>> queryAllFavouriteRows() async {
    Database? db = await instance.database;
    return await db!.query('favourite_songs', orderBy: 'id DESC');
  }
  //function to delete a row in the table favourite songs
  Future<int> deleteFavourite(int id) async {
    Database? db = await instance.database;
    return await db!.delete('favourite_songs', where: 'id = ?', whereArgs: [id]);
  }

//function to insert in the table recently played songs
 //function to insert in the table recently played songs
Future<int> insert(Map<String, dynamic> row) async {
  Database? db = await instance.database;
  
  // Check if the song already exists
  var existingSong = await db!.query('recent_played_songs', where: 'title = ? AND artist = ? AND album = ?', whereArgs: [row['title'], row['artist'], row['album']]);
  if (existingSong.isNotEmpty) {
    // If the song exists, delete it
    await db.delete('recent_played_songs', where: 'id = ?', whereArgs: [existingSong.first['id']]);
  }

  // Insert the new song
  int result = await db.insert('recent_played_songs', row);

  // Check the total number of songs
  var count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM recent_played_songs'));
  if (count != null && count > 30) {
    // If the total number of songs exceeds 30, delete the oldest song
    var oldestSong = await db.query('recent_played_songs', orderBy: 'id ASC', limit: 1);
    await db.delete('recent_played_songs', where: 'id = ?', whereArgs: [oldestSong.first['id']]);
  }

  return result;
}

//funtion to delete all the rows in the table recently played songs
Future<int> deleteAll() async {
  Database? db = await instance.database;
  return await db!.delete('recent_played_songs');
}
  //function to query all the rows in the table recently played songs
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    return await db!.query('recent_played_songs', orderBy: 'id DESC');
  }

  //function to delete a row in the table recently played songs
  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete('recent_played_songs', where: 'id = ?', whereArgs: [id]);
  }

  //function to get the no of row in the table recently played songs
  Future<int?> getRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM recent_played_songs'));
  }

//function to get last played song from the recent_played_song
  Future<Map<String, dynamic>> getLastPlayedSong() async {
    Database? db = await instance.database;
    var result = await db!.query('recent_played_songs', orderBy: 'id DESC', limit: 1);
    return result.first;
  }
 

}