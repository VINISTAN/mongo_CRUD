import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:flutterprojects/Database/mongodb_connection.dart';
import 'package:flutterprojects/model/mongo_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import 'display.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          "Insert Data",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextField(
                controller: fnameController,
                decoration: const InputDecoration(
                  hintText: "First Name",
                ),
              ),
              TextField(
                controller: lnameController,
                decoration: const InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  hintText: "Phone Number",
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _fakeData();
                      },
                      child: const Text("Dummy Data")),
                  ElevatedButton(
                      onPressed: () {
                        _insertData(fnameController.text, lnameController.text,
                            addressController.text);
                      },
                      child: const Text("Insert Data"))
                ],
              ),

              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  DisplayData()),
                    );
                  }, child: Text("View Data"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(String fName, String lName, String addres) async {
    var _id = M.ObjectId();
    final data =
        MongoModel(id: _id, firstname: fName, lastname: lName, address: addres);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted Id :" + _id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }

  void _fakeData() {
    var fake = Faker();
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          "${faker.address.city()} ${fake.address.country()}";

      print("first name : ${fnameController.text}");
      print("last name : ${lnameController.text}");
      print("address : ${addressController.text}");
    });
  }
}
