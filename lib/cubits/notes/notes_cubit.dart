// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:online_61_revision/models/note.dart';
import 'package:online_61_revision/models/services/firebase/firestore_services.dart';
import 'package:online_61_revision/models/services/local/offline_database_services.dart';
import 'package:online_61_revision/models/services/web/notes_services.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  List<Note> notes = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  NotesCubit() : super(NotesInitial());

  void addNote(){
    Note newNote = Note(titleController.text, contentController.text);
    notes.add(newNote);
    // add in offline database
    OfflineDatabaseServices().insert();
    // add online in firebase
    FirestoreServices().insert();
    // add online in backend (APIs)
    NoteServices().post();
    
    titleController.clear();
    contentController.clear();
    emit(AddNoteState());
  }
}
