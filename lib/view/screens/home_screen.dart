// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:online_61_revision/cubits/notes/notes_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _notesBottomSheet(BuildContext context){
    var notesCubit = BlocProvider.of<NotesCubit>(context);
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (context){
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20 , MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: notesCubit.titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  prefixIcon: Icon(Icons.title)
                ),
              ),
              TextField(
                controller: notesCubit.contentController,
                decoration: InputDecoration(
                  hintText: "Content",
                  prefixIcon: Icon(Icons.notes)
                ),
              ),
              SizedBox(height: 20,),
              CircleAvatar(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: IconButton(
                  onPressed: (){
                    notesCubit.addNote();
                  }, 
                  icon: Icon(Icons.add),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state){
            return Visibility(
              visible: notesCubit.notes.isNotEmpty,
              replacement: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.network(
                      "https://lottie.host/9699a74a-80d0-44dc-8b07-e22b0c42e616/rszeITW73Y.json",
                      width: 200,
                    ),
                    //SizedBox(height: 20,),
                    Text("No notes yet.."),
                  ],
                ),
              ),
              child: ListView.separated(
                itemBuilder: (context, i){
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[800]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notesCubit.notes[i].title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            notesCubit.notes[i].content,
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }, 
                separatorBuilder: (context, i) => SizedBox(height: 10,), 
                itemCount: notesCubit.notes.length,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _notesBottomSheet(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }
}