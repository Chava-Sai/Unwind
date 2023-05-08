import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'editnote.dart';
import 'note.dart';
import 'notecard.dart';
import 'notedetail.dart';
import 'notes_database.dart';


class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    // NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    // appBar: AppBar(
    //   shape: ContinuousRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(90),
    //       bottomRight: Radius.circular(90),
    //     ),
    //   ),
    //   toolbarHeight: 70.0,
    //   title: Text(
    //     'Notes',
    //     style: TextStyle(fontSize: 24),
    //   ),
    // ),
    body: SafeArea(

      child: Stack(
        children: [
          Image.asset(
            'Assets/image/chatback32.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: isLoading
                ? CircularProgressIndicator() : notes.isEmpty
                ? Text('No Notes', style: TextStyle(color: Colors.white, fontSize: 24),) : buildNotes(),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(Icons.add),
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddEditNotePage()),
        );

        refreshNotes();
      },
    ),
  );

  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: notes.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final note = notes[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteDetailPage(noteId: note.id!),
          ));

          refreshNotes();
        },
        child: NoteCardWidget(note: note, index: index),
      );
    },
  );
}