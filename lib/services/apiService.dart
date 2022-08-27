import 'dart:convert';
import 'dart:developer';

import 'package:notesapp/models/noteModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "https://aqueous-sands-47732.herokuapp.com/notes";

  static Future<void> addNote(NoteModel noteModel) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: noteModel.toMap());
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<void> deleteNote(NoteModel noteModel) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: noteModel.toMap());
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<List<NoteModel>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);

    List<NoteModel> notes = [];
    for (var noteMap in decoded) {
      NoteModel newNote = NoteModel.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}
