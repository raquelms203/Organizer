import 'package:flutter/material.dart';
import './lista_disciplinas.dart';
import './obj_disciplina.dart';

void main() {
  List<Disciplina> listaDisciplinas = List<Disciplina>();
  runApp(
    MaterialApp(
      title: "Organizer",
      home: ListaDisciplinas(listaDisciplina: listaDisciplinas,),
    
    ),
  );
}

