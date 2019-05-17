import 'package:flutter/material.dart';
import 'package:organizer/view/lista_disciplinas.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/view/lista_tarefas.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:organizer/model/database_helper.dart';

void main() {
  List<Disciplina> listaDisciplinas = List<Disciplina>();
  List<Tarefa> listaTarefas = List<Tarefa>();

  runApp(
    MaterialApp(
      title: "Organizer",
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink[400],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  text: "Tarefas",
                ),
                Tab(
                  text: "Disciplinas",
                )
              ],
            ),
            title: Text("Organizer"),
          ),
          body: TabBarView(
            children: <Widget>[
              ListaTarefas(
                listaTarefa: listaTarefas,
              ),
              ListaDisciplinas(
                listaDisciplina: listaDisciplinas,
              ),
            ],
          ),
        ),
      ),
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
