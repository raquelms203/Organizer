import 'package:flutter/material.dart';
import 'package:organizer/view/lista_disciplinas.dart';
import 'package:organizer/model/obj_disciplina.dart';

void main() {
  List<Disciplina> listaDisciplinas = List<Disciplina>();
  runApp(
    MaterialApp(
      title: "Organizer",
      home: ListaDisciplinas(listaDisciplina: listaDisciplinas,),
    
    ),
  );
}

