import 'package:flutter/material.dart';
import './add_disciplina.dart';
import './disciplina.dart';

class ListaDisciplinas extends StatefulWidget {
  Container container;
  ListaDisciplinas({
    this.container
  });
  @override
  State createState() => new _ListaDisciplinas();
}

class _ListaDisciplinas extends State<ListaDisciplinas> {
  String _disciplina = "", _cod = "";
  double _meta = 0.0;
  List<Container> lista = []; 

  @override
  Widget build(BuildContext context) {
     lista.add(widget.container);
    return Scaffold(
        appBar: AppBar(
          title: Text("Organizer"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormDisciplina();
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green[400],
          tooltip: "Adicionar Disciplina",
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Expanded(
              child: ListView.builder(
                itemCount: lista.length,
                itemBuilder: (BuildContext context, int index) {
                  
                  return lista[index] ;
                },
              ),
            )
          ],
        )));
  }
}

 
