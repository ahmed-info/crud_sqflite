import 'package:crud_sqflite/home.dart';
import 'package:crud_sqflite/sqldb.dart';
import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  final id;
  final title;
  final note;
  final color;
  const EditNotes({Key? key, this.id, this.title, this.note, this.color})
      : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit notes"),
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
                      // int response = await sqlDb.updateData('''
                      //       UPDATE notes SET
                      //       title = "${title.text}",
                      //       note  = "${note.text}",
                      //       color = "${color.text}"
                      //       WHERE id = ${widget.id}
                      //       ''');
                      int response = await sqlDb.update(
                          "notes",
                          {
                            "title": title.text,
                            "note": note.text,
                            "color": color.text,
                          },
                          "id =${widget.id}");
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
                    child: const Text("Update note"),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
