import 'package:flutter/material.dart';
import 'package:organizer/view/lista_disciplinas.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:intl/intl.dart';

class ViewTarefa extends StatefulWidget {
  Tarefa tarefa;

  ViewTarefa({this.tarefa});

  @override
  createState() => new _ViewTarefa(this.tarefa);
}

class _ViewTarefa extends State<ViewTarefa> {
  Tarefa tarefa;

  _ViewTarefa(this.tarefa);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text(tarefa.getTipo()),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Card(
              child: ListTile(
            title: Text("Disciplina:"),
            trailing: Text(
              tarefa.getDisciplina(),
              style: TextStyle(
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Card(
              child: ListTile(
            title: Text("Entrega:"),
            trailing: Text(
              dataFormatada(),
              style: TextStyle(
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Card(
              child: ListTile(
                  title: Text("Prioridade:"), trailing: textPrioridade())),
          Card(
            child: SizedBox(
              height: 54.0,
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 15.0)),
                  Text(
                    "Nota:",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Padding(padding: EdgeInsets.only(left: 170.0
                  )),
                  
                  SizedBox(
                    height: 50.0,
                    width: 55.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left:10.0),),
                  Text("/${tarefa.getValor()}", 
                  style: TextStyle(fontSize: 20.0, 
                  color: Colors.blueGrey[600],
                   fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Text textPrioridade() {
    if (tarefa.getPrioridade() == 1)
      return Text("Baixa",
          style:
              TextStyle(color: Colors.blue[300], fontWeight: FontWeight.bold));
    else if (tarefa.getPrioridade() == 2)
      return Text("Média",
          style:
              TextStyle(color: Colors.amber[600], fontWeight: FontWeight.bold));
    else if (tarefa.getPrioridade() == 3)
      return Text("Alta",
          style:
              TextStyle(color: Colors.red[300], fontWeight: FontWeight.bold));

    return Text("");
  }

  String dataFormatada() {
    DateTime entrega = DateTime.fromMillisecondsSinceEpoch(tarefa.getData());
    String dataFormatada = ("${entrega.day}/${entrega.month}/${entrega.year}");
    return dataFormatada;
  }
}
