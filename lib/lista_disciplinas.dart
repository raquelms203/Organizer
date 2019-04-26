import 'package:flutter/material.dart';
import './form_disciplina.dart';
import './view_disciplina.dart';
import './obj_disciplina.dart';

class ListaDisciplinas extends StatefulWidget {
  List<Container> lista;
  List<Disciplina> listaDisciplina = [new Disciplina()];
  ListaDisciplinas({this.lista});
  ListaDisciplinas.vazia();

  List<Disciplina> getListaD() {
    return this.listaDisciplina;
  }

  void addLista (Disciplina disciplina) {
    listaDisciplina.add(disciplina);
  }

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
            runApp(MaterialApp(home: ViewDisciplina(lista: lista, disciplina: disciplina, listaDisciplina: listaDisciplina,)));
           },
        ),
      ),
    );
    ViewDisciplina.vazia().setCont(cont);
    return cont;
  }
  
  
  // Container cardDisciplina(Disciplina disciplina) {
    
  //   Container cont = new Container( 
   
  //     child: new Card(
  //       child: ListTile(
  //         leading: Icon(Icons.assignment, size: 40.0),
  //         title: Text(disciplina.getDisciplina()),
  //         subtitle: Text(disciplina.getCod()),
  //         trailing: Text("0.0/100",
  //             style: new TextStyle(
  //                 fontWeight: FontWeight.bold, color: Colors.red[400])),
  //         onTap: () {
  //           runApp(MaterialApp(home: ViewDisciplina(lista: lista, disciplina: disciplina, listaDisciplina: listaDisciplina,)));
  //          },
  //       ),
  //     ),
  //   );
  //   ViewDisciplina.vazia().setCont(cont);
  //   return cont;
  // }
}
class _ListaDisciplinas extends State<ListaDisciplinas> {

  @override
  Widget build(BuildContext context) {
    print (" [ ( ");
    return Scaffold(
        appBar: AppBar(
          title: Text("Organizer"),
                backgroundColor: Colors.purple[300],),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            disableTxtVazia(
              txtListaVazia(widget.lista.length),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormDisciplina.add(widget.lista, "a", widget.listaDisciplina);
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