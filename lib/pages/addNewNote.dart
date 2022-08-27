import 'package:flutter/material.dart';
import 'package:notesapp/models/noteModel.dart';
import 'package:notesapp/providers/notesProvider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final NoteModel? noteModel;
  AddNewNote({Key? key, required this.isUpdate, this.noteModel})
      : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    NoteModel newNote = NoteModel(
        id: Uuid().v1(),
        userid: "mahmoodimtiaz",
        title: _titleController.text,
        content: _contentController.text,
        dateadded: DateTime.now());
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.noteModel!.title = _titleController.text;
    widget.noteModel!.content = _contentController.text;
    widget.noteModel!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false)
        .updateNote(widget.noteModel!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      _titleController.text = widget.noteModel!.title!;
      _contentController.text = widget.noteModel!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (widget.isUpdate) {
                updateNote();
              } else {
                addNewNote();
              }
            },
          ),
        ],
        title: Text(widget.isUpdate == true ? 'Update Note' : 'Add New Note'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  autofocus: (widget.isUpdate == true) ? false : true,
                  onSubmitted: (val) {
                    noteFocus.requestFocus();
                  },
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: 'Title', border: InputBorder.none),
                ),
                Expanded(
                  child: TextField(
                    controller: _contentController,
                    focusNode: noteFocus,
                    maxLines: null,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
