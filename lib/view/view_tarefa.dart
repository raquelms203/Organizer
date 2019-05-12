import 'package:flutter/material.dart';
import 'package:organizer/view/lista_disciplinas.dart';
import 'package:organizer/model/obj_tarefa.dart';

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
            title: Text("Prioridade:"),
            trailing: textPrioridade()
          )
         ),
        //  Card( 
        //    child: TextField(  
        //      keyboardType: TextInputType.number,
        //      e
        //    ),
        //  )
          
        ],
      )),
    );
  }

  Text textPrioridade(){
    if (tarefa.getPrioridade() == 1)
      return Text("Baixa", style: TextStyle(color: Colors.blue[300], fontWeight: FontWeight.bold));
      else if (tarefa.getPrioridade() == 2)
        return Text("Média", style: TextStyle(color: Colors.yellow[800], fontWeight: FontWeight.bold));
          else if (tarefa.getPrioridade() == 3)
            return Text("Alta", style: TextStyle(color: Colors.red[300], fontWeight: FontWeight.bold));

    
    return Text("");
  }
}
