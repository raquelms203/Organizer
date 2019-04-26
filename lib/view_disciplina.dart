import 'package:flutter/material.dart';
import 'form_disciplina.dart';
import './obj_disciplina.dart';
import './lista_disciplinas.dart';

class ViewDisciplina extends StatefulWidget {
  Disciplina disciplina;
  List<Container> lista;
  List<Disciplina> listaDisciplina;

  Container cont;
  ViewDisciplina(
      {this.lista, this.disciplina, this.listaDisciplina });
  ViewDisciplina.vazia();

  void setCont(Container cont) {
    this.cont = cont;
  }

  Container getCont() {
    return cont;
  }

  @override
  State createState() {
    return _ViewDisciplina();
  }
}

class _ViewDisciplina extends State<ViewDisciplina> {
  @override
  int faltas = 0;

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        runApp(MaterialApp(home: ListaDisciplinas(lista: widget.lista)));
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
                  runApp(
                      MaterialApp(home: ListaDisciplinas(lista: widget.lista)));
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FormDisciplina.editar(
                          widget.disciplina, "e", widget.lista);
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
                      alertApagar();
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

  String stringStatus(bool status) {
    if (status == true) return "Cursando";

    return "Encerrada";
  }

  void alertApagar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Deseja apagar a última disciplina cadastrada?",
            style: TextStyle(color: Colors.blue[600]),
          ),
          actions: <Widget>[
            FlatButton(
                child: new Text(
                  "Sim",
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                onPressed: () {
                  widget.lista.removeLast();
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
}
