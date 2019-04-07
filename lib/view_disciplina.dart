import 'package:flutter/material.dart';
import 'add_disciplina.dart';

class ViewDisciplina extends StatefulWidget {
  @override
  State createState() {
    return _ViewDisciplina();
  }
}

class _ViewDisciplina extends State<ViewDisciplina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prog Movel")),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
                child: ListTile(
              title: Text("Status"),
              trailing: Text(
                "Cursando",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            Card(
                child: ListTile(
              title: Text("Meta"),
              trailing: Text(
                "80.0 pts",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            Card(
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 15.0)),
                  Text("Faltas"),
                  Padding(padding: EdgeInsets.only(left: 55.0)),
                  RaisedButton(
                    padding: EdgeInsets.only(left: 5.0, top:5.0),
                    onPressed: () {},
                  ),
                  Text(
                    "10",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
