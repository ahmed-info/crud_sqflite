import 'package:crud_sqflite/editnotes.dart';
import 'package:crud_sqflite/sqldb.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.of(context).pushNamed("addnotes");
          }),
          child: const Icon(Icons.add)),
      body: ListView(
        children: [
          ListView.builder(
              itemCount: notes.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Card(
                    child: ListTile(
                        title: Text("${notes[i]['title']}"),
                        subtitle: Text("${notes[i]['note']}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  // int response = await sqlDb.deleteData(
                                  //     "DELETE FROM notes WHERE id =${notes[i]['id']}");
                                  int response = await sqlDb.delete(
                                      "notes", "id =${notes[i]['id']}");
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[i]['id']);
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditNotes(
                                            id: notes[i]['id'],
                                            title: notes[i]['title'],
                                            note: notes[i]['note'],
                                            color: notes[i]['color'],
                                          )));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                )),
                          ],
                        )));
              })
        ],
      ),
    );
  }
}
