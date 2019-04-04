import 'package:flutter/material.dart';
import './add_disciplina.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Organizer"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FormDisciplina();
            } ));
     
          
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green[400],
          tooltip: "Adicionar Disciplina",
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            bannerDisciplinas("Prog Movel", "CSI 401", 25.0),
            bannerDisciplinas("OAC", "CSI 203", 15.0),
          ],
        )));
  }

  Widget bannerDisciplinas(String disciplina, String cod, double nota) {
    return new Container(
        child: new Card(
      child: ListTile(
        leading: Icon(Icons.assignment, size: 40.0),
        title: Text(disciplina),
        subtitle: Text(cod),
        trailing: Text("$nota/100",
            style: new TextStyle(
                fontWeight: FontWeight.bold, color: Colors.red[400])),
        onTap: () {},
      ),
    ));
  }
}
