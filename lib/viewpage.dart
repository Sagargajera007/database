import 'package:database/dbhelper.dart';
import 'package:database/insertpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqflite.dart';


class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List<Map<String, Object?>> l = List.empty(growable: true);
  bool status = false;
  Database? db;

  @override
  void initState() {
    super.initState();
    getAllData();
  }


  getAllData() async {
     db = await DBHelper().createDatabase();

    String qry = "select * from Test";
    List<Map<String,Object?>>x = await db!.rawQuery(qry);
    l.addAll(x);
    print(l);

    status = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("contactBook"),
      ),
      body: status ? (l.length > 0 ? ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Map m = l[index];
          return ListTile(
            onLongPress: () {
              showDialog(builder: (context) {
                return AlertDialog(title: Text("Delete"),
                content: Text("are you sure want to delete this contact"),
                  actions: [TextButton(onPressed: () {
                    int id = m['id'];
                    String q = "DELETE FROM Test WHERE id = '$id'";
                    db!.rawDelete(q).then((value) {

                      setState((){
                        l.removeAt(index);
                      });
                    },);
                  }, child: Text("Yes")),
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("No"))
                  ],
                );
              },context: context);
            },
            leading: Text("${m['id']}"),
            title: Text("${m['name']}"),
            subtitle: Text("${m['contact']}"),
            trailing: IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return insertpage("update",map:m,);
              },));
            }, icon: Icon(Icons.edit)),
          );
        },
      ): Center(child: Text("No Data Found")))
          :Center(child:  Lottie.asset('asset/101908-loader-2.zip'),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return insertpage("insert");
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
