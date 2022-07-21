import 'package:database/dbhelper.dart';
import 'package:database/viewpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  State<insertpage> createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  Database? db;

  @override
  void initState() {
    super.initState();
    DBHelper().createDatabase().then((value) {
      db = value;
    },);
  }
  Future<bool> goback(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return viewpage();
    },));
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Contact"),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return viewpage();
          },));
        }, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: WillPopScope(child: ListView(
        children: [
          TextField(
            controller: tname,
          ),
          TextField(
            controller: tcontact,
          ),
          ElevatedButton(onPressed: () async{
            String name = tname.text;
            String contact = tcontact.text;

            String qry = "insert into Test(name,contact)values('$name','$contact')";
            int id = await db!.rawInsert(qry);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return viewpage();
            },));
            print(id);
          }, child: Text("Save"))
        ],
      ), onWillPop: goback),
    );
  }
}
