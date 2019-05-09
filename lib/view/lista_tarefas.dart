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
  List<Disciplina> listaDisciplina;
  
  ListaTarefas({this.listaTarefa});

  @override
  State createState() => new _ListaTarefas(this.listaTarefa);
}

class _ListaTarefas extends State<ListaTarefas> {
  int count = 0;

  List<Tarefa> listaTarefa;
  
    DatabaseHelper databaseHelper = DatabaseHelper();

  _ListaTarefas(this.listaTarefa);

  @override  
  Widget build(BuildContext context) {
    if (listaTarefa == null)
      listaTarefa = List<Tarefa>();
      else 
        atualizarListView();

    return Scaffold( 
      appBar: AppBar(  
        title: Text("Tarefas"),
        backgroundColor: Colors.purple[300],
        actions: <Widget>[ 
         FlatButton(  
           child: Icon(Icons.remove_red_eye),
           onPressed: () async {
             bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormTarefa.add(listaTarefa: listaTarefa, acao: "a");
           }));  
           if (result == true) atualizarListView();       
           }),
           FlatButton(
              child: Icon(Icons.book),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FormDisciplina.add(listaDisciplina: widget.listaDisciplina, acao: "a");
                }));
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(  
        onPressed: () async {
          bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormTarefa.add(acao: "a",listaTarefa: listaTarefa,);
          }));
          if (result == true) atualizarListView();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        tooltip: "Adicionar Tarefa",
      ),
      body: Container(
        child: Column(children: <Widget>[  
          txtListaVazia(listaTarefa.length),
          carregarLista()
        ],),),
    );
  }

  Container txtListaVazia(int tam) {
    if (tam==0){
      return Container(  
        padding: EdgeInsets.only(top:260.0),
        alignment: Alignment.center,
        child: Text(  
          "Não há tarefas cadastradas!",
          style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
        ),
      );
    } else {
      return Container();
    }
  }

  //getTarefaListView
  Expanded carregarLista() {
    return Expanded(  
      child: ListView.builder(  
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Container (  
            child: Card(  
              child: ListTile(  
                leading: Icon(Icons.warning, size: 40.0),
                title: Text(listaTarefa[index].getDisciplina()),
                subtitle: Text(listaTarefa[index].getTipo()),
                trailing: Text(listaTarefa[index].getNota().toString()+"/"+
                listaTarefa[index].getValor().toString()),
                onTap: () => {},
                //async {
                //  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    // return ViewTarefa;
                //  }));
                // if (result == true) atualizarListView();

               // },

              ),
            ),
          );
        },
      ),
    );
  }

  Visibility disableTxtVazia(Container cont) {
    return Visibility(child: cont, visible: false,);
  }

  void atualizarListView() {
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<Tarefa>> tarefaListFuture = databaseHelper.getTarefaLista();
      tarefaListFuture.then((listaTarefa) {
        setState(() {
         listaTarefa = listaTarefa;
         this.count = listaTarefa.length;
        });
      });
    });
  }
}