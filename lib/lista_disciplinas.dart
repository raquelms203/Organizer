import 'package:flutter/material.dart';
import './form_disciplina.dart';
import './view_disciplina.dart';
import './obj_disciplina.dart';

class ListaDisciplinas extends StatefulWidget {
//   final Container container;
  List<Container> lista;
  List<Disciplina> listaDisciplina;
  ListaDisciplinas({this.lista});
  ListaDisciplinas.vazia();

  @override
  State createState() => new _ListaDisciplinas();
  
  
  Container cardDisciplina(Disciplina disciplina) {
    
    Container cont = new Container( 
   
      child: new Card(
        child: ListTile(
          leading: Icon(Icons.assignment, size: 40.0),
          title: Text(disciplina.getDisciplina()),
          subtitle: Text(disciplina.getCod()),
          trailing: Text("0.0/100",
              style: new TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red[400])),
          onTap: () {
            runApp(MaterialApp(home: ViewDisciplina(lista: lista, disciplina: disciplina))); 
       
           },
        ),
      ),
    );
    ViewDisciplina.vazia().setCont(cont);
    return cont;
  }

 
  void apagaDisciplina(Disciplina disciplina) {
    this.lista.remove(disciplina);
    print(    this.lista.remove(disciplina));

  }

  
}

class _ListaDisciplinas extends State<ListaDisciplinas> {
  final String _disciplina = "", _cod = "";
  final double _meta = 0.0;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Organizer"),
                backgroundColor: Colors.purple[300],),


          // actions: <Widget>[
          //   FlatButton(
          //     onPressed: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return ViewDisciplina();
          //       }));
          //     },
          //     child: Icon(Icons.remove_red_eye),
          //   )
          // ],
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            disableTxtVazia(
              txtListaVazia(widget.lista.length),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormDisciplina.add(widget.lista, "a");
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green[400],
          tooltip: "Adicionar Disciplina",
        ),
        body: Container (
            child: Column(
          children: <Widget>[
            txtListaVazia(widget.lista.length),
            carregarLista()
            // new Expanded(
            //   child: ListView.builder(
            //     itemCount: widget.lista.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return widget.lista[index];
            //     },
            //   ),
            // ),
            // 
          ],
          )),
        );
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

Expanded carregarLista() {
  Expanded ex;
  setState(() {
     ex =  Expanded(
              child: ListView.builder(
                itemCount: widget.lista.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.lista[index];
                },
              ),
            );
  });
  return ex;
}

Visibility disableTxtVazia(Container cont) {
  return Visibility(child: cont, visible: false);
}

}