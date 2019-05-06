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

class ListaDisciplinas extends StatefulWidget {
  List<Disciplina> listaDisciplina;
  List<Tarefa> listaTarefa;

  ListaDisciplinas({this.listaDisciplina});

  @override
  State createState() => new _ListaDisciplinas(this.listaDisciplina);
}

class _ListaDisciplinas extends State<ListaDisciplinas> {
  int count = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Disciplina> listaDisciplina;

  _ListaDisciplinas(this.listaDisciplina);

  @override
  Widget build(BuildContext context) {
    if (listaDisciplina == null)
      listaDisciplina = List<Disciplina>();
    else
      atualizarListView();

    return Scaffold(
      appBar: AppBar(
        title: Text("Organizer"),
        backgroundColor: Colors.purple[300],
        actions: <Widget>[
          FlatButton(
              child: Icon(Icons.remove_red_eye),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormTarefa.add(listaTarefa: widget.listaTarefa, acao: "a");
                }));
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return FormDisciplina.add(
              acao: "a",
              listaDisciplina: listaDisciplina,
            );
          }));

          if (result == true) atualizarListView();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        tooltip: "Adicionar Disciplina",
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          txtListaVazia(listaDisciplina.length),
          carregarLista()
        ],
      )),
    );
  }

  Container txtListaVazia(int tam) {
    if (tam == 0) {
      return Container(
        padding: EdgeInsets.only(top: 260.0),
        alignment: Alignment.center,
        child: Text(
          "Não há disciplinas cadastradas!",
          style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
        ),
      );
    } else {
      return Container();
    }
  }

//getDisciplinaListView
  Expanded carregarLista() {
    return Expanded(
      child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.assignment, size: 40.0),
                  title: Text(listaDisciplina[index].getDisciplina()),
                  subtitle: Text(listaDisciplina[index].getCod()),
                  trailing: Text("0.0/100",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[400])),
                  onTap: () async {
                    bool result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewDisciplina(disciplina: listaDisciplina[index]);
                    }));
                    if (result == true) atualizarListView();
                  },
                ),
              ),
            );
          }),
    );
  }

  Visibility disableTxtVazia(Container cont) {
    return Visibility(child: cont, visible: false);
  }

  void atualizarListView() {
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<Disciplina>> disciplinaListFuture =
          databaseHelper.getDisciplinaLista();
      disciplinaListFuture.then((listaDisciplina) {
        setState(() {
          this.listaDisciplina = listaDisciplina;
          this.count = listaDisciplina.length;
        });
      });
    });
  }
}
