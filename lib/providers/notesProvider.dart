import 'package:flutter/cupertino.dart';
import 'package:notesapp/models/noteModel.dart';
import 'package:notesapp/services/apiService.dart';

class NotesProvider with ChangeNotifier {
  List<NoteModel> notes = [];
  bool isLoading = true;

  void shortData() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  NotesProvider() {
    fetchNote();
  }

  void addNote(NoteModel note) {
    notes.add(note);
    shortData();
    notifyListeners();
    ApiService.addNote(note);
    notifyListeners();
  }

  void updateNote(NoteModel noteModel) {
    int indexOfNote = notes
        .indexOf(notes.firstWhere((element) => element.id == noteModel.id));
    notes[indexOfNote] = noteModel;
    shortData();
    notifyListeners();
    ApiService.addNote(noteModel);
  }

  void deleteNote(NoteModel noteModel) {
    int indexOfNote = notes
        .indexOf(notes.firstWhere((element) => element.id == noteModel.id));
    notes.removeAt(indexOfNote);
    shortData();
    notifyListeners();
    ApiService.deleteNote(noteModel);
  }

  void fetchNote() async {
    notes = await ApiService.fetchNotes('akash');
    shortData();
    isLoading = false;
    notifyListeners();
  }

  List<NoteModel> getFilterdNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
