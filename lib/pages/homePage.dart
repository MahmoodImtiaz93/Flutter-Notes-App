import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/models/noteModel.dart';
import 'package:notesapp/pages/addNewNote.dart';
import 'package:notesapp/providers/notesProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
        centerTitle: true,
      ),
      body: (notesProvider.isLoading == false)
          ? SafeArea(
              child: (notesProvider.notes.length > 0)
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'Search', icon: Icon(Icons.search)),
                          ),
                        ),
                        (notesProvider.getFilterdNotes(searchQuery).length > 0)
                            ? GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: notesProvider
                                    .getFilterdNotes(searchQuery)
                                    .length,
                                itemBuilder: (context, index) {
                                  NoteModel currentNote = notesProvider
                                      .getFilterdNotes(searchQuery)[index];
                                  return GestureDetector(
                                    onTap: () {
                                      //update
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => AddNewNote(
                                            isUpdate: true,
                                            noteModel: currentNote,
                                          ),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      //dialog pop up
                                      //delet

                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              "Do you want to delete this note?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                notesProvider
                                                    .deleteNote(currentNote);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Yes"),
                                            ),
                                          ],
                                          elevation: 24.0,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          border: Border.all(
                                              color: Colors.grey, width: 2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            currentNote.title!,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            currentNote.content!,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey),
                                            maxLines: 4,
                                            overflow: TextOverflow.fade,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            currentNote.dateadded.toString(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.blueAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'No Notes Found',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                      ],
                    )
                  : Center(
                      child: Text('No Notes Added!'),
                    ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => AddNewNote(isUpdate: false)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
