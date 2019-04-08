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
            Container(
              height: 80.0,
              width: 360.0,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Text(
                      "Faltas",
                      style: TextStyle(fontSize: 16.0, 
                      fontFamily: 'Trojan'
                   ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 35.0)),
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
                        onPressed: () {},
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Text(
                      "10",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    // FlatButton(
                    //   child: Icon(Icons.minimize, color: Colors.red),
                    //   shape: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.red)),
                    //   onPressed: () {},
                    // ),

                    SizedBox(
                      width: 65.0,
                      height: 35.0,
                      child: FlatButton(
                        // padding: EdgeInsets.only( bottom: 55.0, top:0.5),
                        child: Text(
                          "-",
                          style: TextStyle(fontSize: 30.0, color: Colors.red),
                        ),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        onPressed: () {},
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
}
