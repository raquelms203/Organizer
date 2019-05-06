import 'package:flutter/material.dart';
import 'package:organizer/controller/form_disciplina.dart';
import './view_disciplina.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/model/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:organizer/controller/form_tarefa.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:organizer/model/obj_tarefa.dart';

class ListaTarefas extends StatefulWidget {
  List<Tarefa> listaTarefa;
  
//  ListaTarefa({this.listaTarefa});

  @override
  State createState() => new _ListaTarefas();
}

class _ListaTarefas extends State<ListaTarefas> {
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override  
  Widget build(BuildContext context) {
    if (widget.listaTarefa == null)
      widget.listaTarefa = List<Tarefa>();
      else 
       // atualizarListView();

    return Scaffold( 
      appBar: AppBar(  
        title: Text("Tarefas"),
      ),
    );
  }
}