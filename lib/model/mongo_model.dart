// To parse this JSON data, do

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoModel welcomeFromJson(String str) => MongoModel.fromJson(json.decode(str));

String welcomeToJson(MongoModel data) => json.encode(data.toJson());

class MongoModel {
  ObjectId id;
  String firstname;
  String lastname;
  String address;

  MongoModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
  });

  factory MongoModel.fromJson(Map<String, dynamic> json) => MongoModel(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "address": address,
      };
}
