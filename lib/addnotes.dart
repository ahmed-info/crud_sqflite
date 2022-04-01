import 'package:crud_sqflite/home.dart';
import 'package:crud_sqflite/sqldb.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add notes"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(children: [
          Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(hintText: "title"),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(hintText: "note"),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(hintText: "color"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      // int response = await sqlDb.insertData('''
                      //       INSERT INTO notes (`title`, `note`,`color`)
                      //       VALUES ("${title.text}", "${note.text}", "${color.text}")
                      //       ''');
                      int response = await sqlDb.insert("notes", {
                        "title": {title.text},
                        "note": {note.text},
                        "color": {color.text}
                      });
                      //print("response ===================");
                      //print(response);
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                            (route) => false);
                      }
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text("Add note"),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
