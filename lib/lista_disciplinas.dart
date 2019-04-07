import 'package:flutter/material.dart';
import './add_disciplina.dart';

class ListaDisciplinas extends StatefulWidget {
//   final Container container;
  final List<Container> lista;
  ListaDisciplinas({
//     this.container,
   this.lista
   }); 
  
    @override
    State createState() => new _ListaDisciplinas();
}

class _ListaDisciplinas extends State<ListaDisciplinas> {
 
  final String _disciplina = "", _cod = "";
  final double _meta = 0.0;

  @override
  Widget build(BuildContext context) { 
        if (widget.lista.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Organizer"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormDisciplina(lista: widget.lista);
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green[400],
          tooltip: "Adicionar Disciplina",
        ),
        body: new Container()
      );
    } else  {
    return Scaffold(
        
        appBar: AppBar(
          title: Text("Organizer"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          
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
            
            new Expanded(
              child: ListView.builder(
                itemCount: widget.lista.length,
                itemBuilder: (BuildContext context, int index) {
     
                  return widget.lista[index];
                },
              ),
            )
          ],
        )));
  }
  }
}

 
