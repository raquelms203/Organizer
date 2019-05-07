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
        backgroundColor: Colors.purple[300],
        actions: <Widget>[ 
         FlatButton(  
           child: Icon(Icons.remove_red_eye),
           onPressed: () => {},
          //   Navigator.push(context, MaterialPageRoute(builder (context) {
          //     return 
          //  })),
         )
        ],
      ),
      floatingActionButton: FloatingActionButton(  
        onPressed: () => {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        tooltip: "Adicionar Tarefa",
      ),
      body: Container(
        child: Column(children: <Widget>[  
          txtListaVazia(widget.listaTarefa.length),
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
        itemCount: widget.listaTarefa.length,
        itemBuilder: (BuildContext context, int index) {
          return Container (  
            child: Card(  
              child: ListTile(  
                leading: Icon(Icons.warning, size: 40.0),
                title: Text(widget.listaTarefa[index].getDisciplina()),
                subtitle: Text(widget.listaTarefa[index].getTipo()),
                trailing: Text(widget.listaTarefa[index].getNota().toString()+"/"+
                widget.listaTarefa[index].getValor().toString()),
                onTap: () => {},

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
      Future<List<Tarefa>> tarefaListFUture = databaseHelper.getTarefaLista();
      tarefaListFUture.then((listaTarefa) {
        setState(() {
         listaTarefa = widget.listaTarefa;
        });
      });
    });
  }
}