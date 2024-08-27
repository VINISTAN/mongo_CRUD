import'package:flutter/material.dart';
import 'package:flutterprojects/Database/mongodb_connection.dart';
import 'package:flutterprojects/model/mongo_model.dart';

class DisplayData extends StatefulWidget {
  const DisplayData({super.key});

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Available Data",
        style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                } else {
                  if(snapshot.hasData){
                    var totalData = snapshot.data.length;
                    //return const Text("Data Found");
                    return ListView.builder(
                      itemCount: totalData,
                        itemBuilder: (context, index) {
                        return displayCard(MongoModel.fromJson(snapshot.data[index]));
                        }
                    );

                  }else {
                    return const Center(child: Text("No Data Found"));
                  }
                }
              }
          )
      )
    );
  }

  Widget displayCard(MongoModel data) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${data.id}"),
          Text("${data.firstname}"),
          Text("${data.lastname}"),
          Text("${data.address}"),
        ],
      ),
    );
  }
}
