import 'package:flutter/material.dart';
import 'add_disciplina.dart';
import './obj_disciplina.dart';
import './lista_disciplinas.dart';

class ViewDisciplina extends StatefulWidget {
  Disciplina disciplina;
  ViewDisciplina({this.disciplina});

  @override
  State createState() {
    return _ViewDisciplina();
  }
}

class _ViewDisciplina extends State<ViewDisciplina> {
  @override
  int faltas = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.disciplina.getDisciplina() +
                "  (" +
                widget.disciplina.getCod() +
                ")",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0)),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25.0, right: 20.0),
            child:  Text(widget.disciplina.getPeriodo(), 
            style: TextStyle( 
              fontSize: 22.0
            ),)

          )
        ],
        backgroundColor: Colors.purple[300],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
                child: ListTile(
              title: Text("Status"),
              trailing: Text(
                stringStatus(widget.disciplina.getStatus()),
                style: TextStyle(
                  color: Colors.orange,
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
                  color: Colors.orange,
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
                            faltas = faltas - 1;
                            widget.disciplina.setFaltas(faltas);
                          });
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Text(
                      "$faltas",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    SizedBox(
                      width: 65.0,
                      height: 35.0,
                      child: FlatButton(
                        // padding: EdgeInsets.only( bottom: 55.0, top:0.5),
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 30.0, color: Colors.green),
                        ),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        onPressed: () {
                          setState(() {
                            faltas = faltas = faltas + 2;
                            widget.disciplina.setFaltas(faltas);
                          });
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 25.0)),
                    Text(
                      "Máx: "+ widget.disciplina.getLimFaltas().toString(),
                      style: TextStyle(
                        color: Colors.orange,
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
    );
  }

  String stringStatus(bool status) {
    if (status == true)
      return "Cursando";
   
      return "Encerrada";
  }
}
