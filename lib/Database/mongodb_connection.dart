import 'dart:developer';

import 'package:flutterprojects/model/mongo_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'db_connection.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<String> insert(MongoModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted Successfully";
      } else {
        return "Failed to insert";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> getData () async {
    final availableData = await userCollection.find().toList();
    return availableData;
  }
}
