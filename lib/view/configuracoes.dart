import 'package:flutter/material.dart';
import 'package:organizer/model/database_helper.dart';

class Configuracoes extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Configuracoes();
  }


}

class _Configuracoes extends State<Configuracoes> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  void initState() {
    
    super.initState();
  }

  @override  
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        backgroundColor: Colors.pink[400],
      ),
      body: Column(  
        children: <Widget>[  
          Card(  
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(  
                  child: Text("Apagar Todas as Disciplinas e Tarefas",   
                  style: TextStyle(color: Colors.red),),
                  shape: OutlineInputBorder(  
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  onPressed: () {
                    alertApagar(context);
                  }

                ),
              ],
            ),
          )
        ],
      ),
    );
  
  }
  void alertApagar(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Deseja apagar todas as disciplinas e tarefas?",
            style: TextStyle(color: Colors.blue[600]),
          ),
          actions: <Widget>[
            FlatButton(
                child: new Text(
                  "Sim",
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                onPressed: ()  {
                 databaseHelper.apagarTudo();
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                }),
            FlatButton(
              child: new Text(
                "Não",
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  }
