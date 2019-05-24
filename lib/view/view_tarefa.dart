import 'package:flutter/material.dart';
import 'package:organizer/controller/form_tarefa.dart';
import 'package:organizer/view/lista_disciplinas.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:intl/intl.dart';
import 'package:organizer/model/database_helper.dart';
import 'package:flutter/services.dart';

class ViewTarefa extends StatefulWidget {
  Tarefa tarefa;

  ViewTarefa({this.tarefa});

  @override
  createState() => new _ViewTarefa(this.tarefa);
}

class _ViewTarefa extends State<ViewTarefa> {
  double _nota;
  bool erro = false;
  Tarefa tarefa;
  DatabaseHelper databaseHelper = DatabaseHelper();

  _ViewTarefa(this.tarefa);

  @override
  void initState() {
    _nota = tarefa.getNota();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(tarefa.getTipo()),
        actions: <Widget>[
          SizedBox(
            height: 30.0,
            width: 50.0,
            child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormTarefa.editar(
                        acao: "e", id: tarefa.getId(), tarefa: tarefa);
                  }));
                },
                child: Icon(
                  Icons.edit,
                  color: Colors.blue[300],
                  size: 30.0,
                )),
          ),
          SizedBox(
            height: 30.0,
            width: 50.0,
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    alertApagar(context, tarefa);
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white70,
                  size: 30.0,
                )),
          ),
        ],
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
                  Padding(padding: EdgeInsets.only(left: 175.0)),
                  SizedBox(
                    height: 46.0,
                    width: 48.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 2, top: 12.0),
                          hintText: tarefa.getNota().toString(),
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                          ),
                          errorStyle:
                              (erro ? TextStyle(color: Colors.red) : null)),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(5),
                      ],
                      onSubmitted: (String valor) async {
                        _nota = double.parse(valor);
                        if (_nota > tarefa.getValor()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "Valor maior que ${tarefa.getValor()}!",
                                  style: TextStyle(color: Colors.red),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                          return;
                        }
                        tarefa.setNota(_nota);
                        await databaseHelper.atualizarNota(
                            tarefa, _nota, tarefa.getId());
                        //      await databaseHelper.atualizarNotaDisciplina(_nota, tarefa.getDisciplina());
                      },
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  Text(
                    "/${tarefa.getValor()}",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          cardDescricao(tarefa.getDescricao())
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
    DateTime data = DateTime.fromMillisecondsSinceEpoch(tarefa.getData());
    String dataFormatada = ("${data.day}/${data.month}/${data.year}");
    return dataFormatada;
  }

  void alertApagar(BuildContext context, Tarefa tarefa) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Deseja apagar essa tarefa?",
            style: TextStyle(color: Colors.blue[600]),
          ),
          actions: <Widget>[
            FlatButton(
                child: new Text(
                  "Sim",
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                onPressed: () async {
                  int result =
                      await databaseHelper.apagarTarefa(tarefa.getId());
                  Navigator.pop(context);
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

  Card cardDescricao(String descricao) {
    if (descricao.length > 44) {
      return Card(
        child: SizedBox(
          height: 110,
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Descrição: ",
                  style: TextStyle(fontSize: 16.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                ),
                FittedBox(
                  child: Text("${tarefa.getDescricao()}",
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.blueGrey[600])),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (descricao.length <= 44) {
      return Card(
        child: SizedBox(
          height: 110,
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, left: 15.0),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Descrição: ",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                    ),
                    Text("${tarefa.getDescricao()}",
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.blueGrey[600])),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Card();
  }
}
