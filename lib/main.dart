import 'package:flutter/material.dart';
import 'package:organizer/view/lista_disciplinas.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/view/lista_tarefas.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  List<Disciplina> listaDisciplinas = List<Disciplina>();

 // List<Tarefa> listaTarefas = List<Tarefa>();
    runApp(
      MaterialApp(
        title: "Organizer",
       home: ListaDisciplinas(listaDisciplina: listaDisciplinas,),
      // home: ListaTarefas(listaTarefa:listaTarefas,)
       localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
          const Locale('pt', 'BR'),
          const Locale('en', 'US'),

      ],
    
    ),
  );
}

