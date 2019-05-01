import 'package:flutter/material.dart';
import 'form_disciplina.dart';
import './obj_disciplina.dart';
import './lista_disciplinas.dart';
import './database_helper.dart';
import 'dart:async';

class ViewDisciplina extends StatefulWidget {
  Disciplina disciplina;
  List<Container> lista;
  List<Disciplina> listaDisciplina;
  int id;

  Container cont;
  ViewDisciplina(
      {this.disciplina});
  ViewDisciplina.vazia();

  @override
  State createState() {
    return _ViewDisciplina(this.disciplina);
  }
}

class _ViewDisciplina extends State<ViewDisciplina> {
  int faltas = 0;
  Disciplina disciplina;
  DatabaseHelper databaseHelper = DatabaseHelper();

  _ViewDisciplina(this.disciplina);

  @override
  Widget build(BuildContext context) {

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
            height: 50.0,
            padding: EdgeInsets.only(top: 5.0),
              child: Text(
                  widget.disciplina.getDisciplina()+
                      "\n(" +
                      widget.disciplina.getCod() +
                      ")",
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
          actions: <Widget>[
            
            SizedBox(
              height: 30.0,
              width: 50.0,
              child: FlatButton(
                  onPressed: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FormDisciplina.editar(disciplina: disciplina, id: disciplina.getId(), acao: "e");
                    }));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue[300],
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
                    color: Colors.white70,
                    size: 30.0,
                  )),
            ),
          ],
          backgroundColor: Colors.purple[300],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
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
                trailing: Text(
                  stringStatus(widget.disciplina.getStatus()),
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
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
                width: 360.0,
                child: Card(
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 15.0)),
                      Text(
                        "Faltas",
                        style: TextStyle(fontSize: 16.0, fontFamily: 'Trojan'),
                      ),
                      Padding(padding: EdgeInsets.only(right: 30.0)),
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
                          onPressed: () {
                            setState(() {
                              faltas = widget.disciplina.getFaltas();

                              if (faltas - 1 >= 0) {
                                faltas = faltas - 1;
                                widget.disciplina.setFaltas(faltas);
                              }
                            });
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15.0)),
                      Text(
                        widget.disciplina.getFaltas().toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15.0)),
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
                          onPressed: () {
                            setState(() {
                              faltas = widget.disciplina.getFaltas();

                              if (faltas + 2 <=
                                  widget.disciplina.getLimFaltas()) {
                                faltas = faltas + 2;
                                widget.disciplina.setFaltas(faltas);
                              }
                            });
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 25.0)),
                      Text(
                        "Máx: " + widget.disciplina.getLimFaltas().toString(),
                        style: TextStyle(
                          color: Colors.blueGrey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BuildContext getContext () {
    return this.context;
  }

  

  String stringStatus(int status) {
    if (status == 1) return "Cursando";

    return "Encerrada";
  }

  void alertApagar(BuildContext context, Disciplina disciplina) async {
   

    showDialog  (
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
                  int result = await databaseHelper.apagar(disciplina.getId());
                if (result != 0) {
               //   _showSnackBar(getContext(), 'Disciplina apagada com sucesso!');
                }
                //  widget.lista.removeLast();
                  Navigator.pop(context);
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

  // void _showSnackBar(BuildContext context, String msg) {
  //   final snackBar = SnackBar (content: Text(msg),);
  //   Scaffold.of(context).showSnackBar(snackBar);
  //}

  void apagar() async {
     await databaseHelper.apagar(widget.id);
     Navigator.pop(context, true);
  }
}
