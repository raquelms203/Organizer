import 'package:flutter/material.dart';
import './add_disciplina.dart';
import './view_disciplina.dart';

class ListaDisciplinas extends StatefulWidget {
//   final Container container;
  final List<Container> lista;
  ListaDisciplinas(
      {
//     this.container,
      this.lista});

  @override
  State createState() => new _ListaDisciplinas();
}

class _ListaDisciplinas extends State<ListaDisciplinas> {
  final String _disciplina = "", _cod = "";
  final double _meta = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Organizer"),
          
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewDisciplina();
                }));
              },
              child: Icon(Icons.remove_red_eye),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            disableTxtVazia(
              txtListaVazia(widget.lista.length),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormDisciplina(lista: widget.lista);
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green[400],
          tooltip: "Adicionar Disciplina",
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            txtListaVazia(widget.lista.length),
            new Expanded(
              child: ListView.builder(
                itemCount: widget.lista.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.lista[index];
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150.0),
            ),
           
          ],
        )));
  }
}

Container txtListaVazia(int tam) {
  if (tam == 1) {
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

Visibility disableTxtVazia(Container cont) {
  return Visibility(child: cont, visible: false);
}
