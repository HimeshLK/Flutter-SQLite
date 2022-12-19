import 'package:flutter/material.dart';
import 'package:local_database/models/note_model.dart';
import 'package:local_database/services/database_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;
  const NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final vCommentController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
      vCommentController.text = note!.vcomment;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            note == null ? 'Enter vehical details' : 'Edit vehical details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'Insert New Vehical Record',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.teal),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: titleController,
                maxLines: 2,
                decoration: const InputDecoration(
                    hintText: 'wp CAE 33XX',
                    labelText: 'Vehical Number',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        ))),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: descriptionController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: '(ie. CAR, VAN)',
                    labelText: 'Vehical Type',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7.0),
                        ))),
              ),
            ),

            //Text Field form for vehicale
            TextFormField(
              controller: vCommentController,
              decoration: const InputDecoration(
                  hintText: 'Add a Discription',
                  labelText: 'Car discription',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(7.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 2,
            ),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final title = titleController.value.text;
                      final description = descriptionController.value.text;
                      final vcomment = vCommentController.value.text;

                      if (title.isEmpty ||
                          description.isEmpty ||
                          vcomment.isEmpty) {
                        return;
                      }
                      final Note model = Note(
                          title: title,
                          description: description,
                          vcomment: vcomment,
                          id: note?.id);
                      if (note == null) {
                        await DatabaseHelper.addNote(model);
                      } else {
                        await DatabaseHelper.updateNote(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Color.fromARGB(255, 38, 205, 214),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7.0),
                                )))),
                    child: Text(
                      note == null ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
