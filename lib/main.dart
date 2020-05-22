import 'package:flutter/material.dart';
import 'package:organizer/view/lista_disciplinas.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/view/lista_tarefas.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:organizer/controller/configuracoes.dart';

void main() {
  List<Disciplina> listaDisciplinas;
  List<Tarefa> listaTarefas = List<Tarefa>();

  runApp(
    MaterialApp(
      theme: ThemeData(  
        primaryColor: Color(0xffF5891F),
        primaryColorBrightness: Brightness.dark,
        accentColor: Color(0xffF5891F),
        floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.white),
        accentColorBrightness: Brightness.dark
      ),
      title: "Organizer",
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 2,
          child: Builder(
            builder: (context) {
              return new Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    FlatButton(
                        child: Icon(
                          Icons.settings,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Configuracoes();
                          }));
                        })
                  ],
                  backgroundColor: Color(0xffF5891F),
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
              );
            },
          )),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
    ),
  );
}
