import 'package:flutter/material.dart';
import 'package:organizer/controller/form_disciplina.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/model/database_helper.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:organizer/view/lista_tarefas.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class ViewDisciplina extends StatefulWidget {
  Disciplina disciplina;
  List<Disciplina> listaDisciplina;
  int id;

  Container cont;
  ViewDisciplina({this.disciplina});

  @override
  State createState() {
    return _ViewDisciplina();
  }
}

class _ViewDisciplina extends State<ViewDisciplina> {
  List<Tarefa> listaTarefa;
  MediaQueryData mediaQuery;
  int faltas = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    tarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            child: Container(
              height: 5.0,
            ),
            preferredSize: Size(100.0, 15.0),
          ),
          leading: SizedBox(
            height: 20.0,
            width: 20.0,
            child: FlatButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Icon(Icons.arrow_back, color: Colors.white, size: 25.0)),
          ),
          title: Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
                widget.disciplina.getDisciplina() +
                    "\n(" +
                    widget.disciplina.getCod() +
                    ")",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          actions: <Widget>[
            SizedBox(
              height: 30.0,
              width: 50.0,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FormDisciplina.editar(
                          acao: "e",
                          disciplina: widget.disciplina,
                          id: widget.disciplina.getId());
                    }));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 30.0,
                  )),
            ),
            SizedBox(
              height: 30.0,
              width: 50.0,
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      alertApagar(context, widget.disciplina);
                    });
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30.0,
                  )),
            ),
          ],
          backgroundColor: Colors.pink[400],
        ),
        body: ListView(children: <Widget>[
          Card(
              child: ListTile(
                  title: Text("Período"),
                  trailing: Text(
                    widget.disciplina.getPeriodo(),
                    style: TextStyle(
                      color: Colors.blueGrey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
          Card(
              child: ListTile(
                  title: Text("Status"),
                  trailing: textStatus(widget.disciplina.getStatus()))),
          Card(
              child: ListTile(
            title: Text("Meta"),
            trailing: Text(
              widget.disciplina.getMeta().toString(),
              style: TextStyle(
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Container(
            height: 80.0,
            width: mediaQuery.size.width,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //   Padding(padding: EdgeInsets.only(left: 15.0)),
                  Padding(
                    padding: EdgeInsets.only(left: mediaQuery.size.width / 60),
                    child: Text(
                      "Faltas",
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Trojan'),
                    ),
                  ),
                  //   Padding(padding: EdgeInsets.only(right: 30.0)),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 65.0,
                        height: 35.0,
                        child: FlatButton(
                          child: Text(
                            "-",
                            style: TextStyle(fontSize: 30.0, color: Colors.red),
                          ),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          onPressed: () async {
                            faltas = widget.disciplina.getFaltas();
                            setState(() {
                              if (faltas - 1 >= 0) {
                                faltas = faltas - 1;
                              }
                            });
                            widget.disciplina.setFaltas(faltas);
                            await databaseHelper.atualizarFaltas(
                                widget.disciplina.getFaltas(),
                                widget.disciplina.getId());
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                      ),
                      Text(
                        "${widget.disciplina.getFaltas()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                      ),
                      SizedBox(
                        width: 65.0,
                        height: 35.0,
                        child: FlatButton(
                          child: Text(
                            "+",
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.green),
                          ),
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          onPressed: () async {
                            faltas = widget.disciplina.getFaltas();
                            setState(() {
                              if (faltas + 1 <=
                                  widget.disciplina.getLimFaltas()) {
                                faltas = faltas + 1;
                              }
                            });
                            widget.disciplina.setFaltas(faltas);
                            await databaseHelper.atualizarFaltas(
                                widget.disciplina.getFaltas(),
                                widget.disciplina.getId());
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: mediaQuery.size.width / 60),
                    child: Text(
                      "Máx: " + widget.disciplina.getLimFaltas().toString(),
                      style: TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.green[400],
                child: FlatButton(
                  child: Text(
                    "Mostrar Tarefas",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ListaTarefas.visualizar(
                          listaTarefa: listaTarefa, apenasVisualizar: true);
                    }));
                  },
                ),
              ),
            ],
          )),
        ]),
      ),
    );
  }

  Text textStatus(int status) {
    if (status == 1) {
      return Text(
        ("Cursando"),
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (status == 0) {
      return Text(
        ("Encerrada"),
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Text("");
  }

  void alertApagar(BuildContext context, Disciplina disciplina) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Deseja apagar essa disciplina?",
            style: TextStyle(color: Colors.blue[600]),
          ),
          actions: <Widget>[
            FlatButton(
                child: new Text(
                  "Sim",
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                onPressed: () async {
                  await databaseHelper
                      .apagarTarefaPorDisciplina(disciplina.getDisciplina());
                  await databaseHelper.apagarDisciplina(disciplina.getId());
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                }),
            FlatButton(
              child: new Text(
                "Não",
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void tarefas() {
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<Tarefa>> tarefasListFuture = databaseHelper
          .getTarefasPorDisciplina(widget.disciplina.getDisciplina());
      tarefasListFuture.then((listaTarefa) {
        setState(() {
          this.listaTarefa = listaTarefa;
        });
      });
    });
  }
}
