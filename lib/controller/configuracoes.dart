import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organizer/model/database_helper.dart';

class Configuracoes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Configuracoes();
  }
}

class _Configuracoes extends State<Configuracoes> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffF5891F),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    child: Text(
                      "Apagar Todas as Disciplinas e Tarefas",
                      style: TextStyle(color: Colors.red),
                    ),
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      alertApagar(context);
                    }),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(
                  new ClipboardData(text: "raquelmartins203@yahoo.com.br"));
              final snackBar = SnackBar(
                content: Text('Email copiado com sucesso!'),
                backgroundColor: Colors.green,
              );

              _scaffoldKey.currentState.showSnackBar(snackBar);
            },
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "raquelmartins203@yahoo.com.br",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(
                  new ClipboardData(text: "github.com/raquelms203"));
              final snackBar = SnackBar(
                content: Text('GitHub copiado com sucesso!'),
                backgroundColor: Colors.green,
              );

              _scaffoldKey.currentState.showSnackBar(snackBar);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage("assets/git.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "github.com/raquelms203",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
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
                "Não",
                style: TextStyle(color: Colors.black, fontSize: 15.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
                child: new Text(
                  "Sim",
                style: TextStyle(color: Color(0xffF5891F), fontSize: 15.0),
                ),
                onPressed: () {
                  databaseHelper.apagarTudo();
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                }),
          ],
        );
      },
    );
  }
}
