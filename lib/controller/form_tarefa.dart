import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organizer/view/lista_tarefas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:organizer/model/database_helper.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:dropdownfield/dropdownfield.dart';


class FormTarefa extends StatefulWidget {
  String acao;
  List<Tarefa> listaTarefa;
  Tarefa tarefa;
  int id;

  FormTarefa.add({this.listaTarefa, this.acao});
  FormTarefa.editar({this.tarefa, this.id, this.acao});

  @override
  createState() => _FormTarefa();
}

class _FormTarefa extends State<FormTarefa> {
  String _descricao = "";
  String _disciplina = "";
  String _tipo = "";
  String dropdownDefault = "Disciplina";
  String dropdownDefault2 = "Prioridade";

  int _prioridade=0;
  int count;
  int _data;

  double _valor = 0.0;

  DateTime dataAtual = new DateTime.now();
  DateTime dataSelecionada;

  List<String> listaPrioridade = ["1", "2", "3"];
  List<String> stringDisciplinas = [];

  DatabaseHelper databaseHelper = DatabaseHelper();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitulo()),
        backgroundColor: Colors.purple[300],
        actions: <Widget>[
          MaterialButton(  
            child: Icon(Icons.remove_red_eye),
            height: 20.0,
            onPressed: () => disciplinasDropdown(),
          ),
          MaterialButton(
            child: Text(
              "Salvar",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 18.0),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                salvarTarefa();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Builder(builder: (BuildContext context) {
          return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 18.0),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(dropdownDefault,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            onChanged: (String novoValor) {
                              setState(() {
                                dropdownDefault = novoValor;
                                _disciplina = novoValor;
                                
                              });
                            },
                            items: stringDisciplinas
                                .map<DropdownMenuItem<String>>((String valor) {
                              return DropdownMenuItem<String>(
                                  value: valor,
                                  child: Text(
                                    valor,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                width: 150.0,
                                height: 55.0,
                                child: TextFormField(
                                  initialValue: valorInicialTipo(),
                                  validator: (value) {
                                    if (value.isEmpty) return "Campo vazio!";
                                    _tipo = value;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Tipo',
                                      hintText: 'Ex. Prova',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, top: 10.0, right: 10.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: 55.0,
                                  width: 150.0,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: valorInicialValor(),
                                    validator: (value) {
                                      if (value.isEmpty) return 'Campo vazio!';
                                      _valor = double.parse(value);
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Valor',
                                        hintText: 'Ex. 30 pts',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                  )),
                            ],
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                            left: 15.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: 55.0,
                                  width: 150.0,
                                  child: FlatButton(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.calendar_today,
                                          size: 23.0,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 3.0),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Entrega",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () => selecionarData(),
                                    shape: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ))
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 28.0),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: 120.0,
                              height: 30.0,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text(dropdownDefault2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0)),
                                  onChanged: (String novoValor) {
                                    setState(() {
                                      dropdownDefault2 = novoValor;
                                      _prioridade = int.parse(novoValor);
                                    });
                                  },
                                  items: listaPrioridade
                                      .map<DropdownMenuItem<String>>(
                                          (String valor) {
                                    return DropdownMenuItem<String>(
                                        value: valor,
                                        child: Text(
                                          valor,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ));
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 15.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 120.0,
                              width: 325.0,
                              child: TextFormField(
                                maxLength: 110,
                                maxLines: 5,
                                initialValue: valorInicialDescricao(),
                                validator: (value) {
                                  _descricao = value;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Descrição (Opcional)',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid))),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ));
        }),
      ),
    );
  }

  String appbarTitulo() {
    if (widget.acao == "a")
      return "Adicionar Tarefa";
    else if (widget.acao == "e") return "Editar Tarefa";

    return "";
  }

  String valorInicialTipo() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.tarefa.getTipo();
    return "";
  }

  String valorInicialValor() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.tarefa.getValor().toString();
    return "";
  }

  String valorInicialEntrega() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.tarefa.getData().toString();
    return "";
  }

  String valorInicialDescricao() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.tarefa.getDescricao();
    return "";
  }

  void errorMsgCampoVazio(String campo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Selecione o $campo!",
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
  }

  void errorMsgSalvar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Erro ao salvar Tarefa!",
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void salvarTarefa() async {
    int result;

    if (_disciplina == "") {
      errorMsgCampoVazio("Disciplina");
      return;
    }

    if (dataSelecionada.millisecondsSinceEpoch == null) {
      errorMsgCampoVazio("Data");
    }

    if (_prioridade == 0) {
      errorMsgCampoVazio("Prioridade");
      return;
    }

    _tipo = (_tipo[0].toUpperCase() + _tipo.substring(1));
    _data = dataSelecionada.millisecondsSinceEpoch;

    if (widget.acao == "e") {
      widget.tarefa.setDisciplina(_disciplina);
      widget.tarefa.setTipo(_tipo);
      widget.tarefa.setValor(_valor);
      widget.tarefa.setPrioridade(_prioridade);
      widget.tarefa.setData(_data);
      widget.tarefa.setDescricao(_descricao);

      result = await databaseHelper.atualizarTarefa(widget.tarefa);
      

    } else if (widget.acao == "a") {
      Tarefa tarefa = new Tarefa(
          _disciplina, _descricao, _tipo, _valor, 0.0, _data, _prioridade);
      result = await databaseHelper.inserirTarefa(tarefa);
      print(tarefa.getData());
    }
    if (result == 0) errorMsgSalvar();

    Navigator.pop(context, true);
  }

  Future<List<String>> disciplinas() async {
    List<String> result = await databaseHelper.getNomesDisciplina();
    return result;
  }

  void disciplinasDropdown() {
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<String>> disciplinasListFuture =
          databaseHelper.getNomesDisciplina();
      disciplinasListFuture.then((listaTarefa) {
        setState(() {
          stringDisciplinas = listaTarefa;
          this.count = listaTarefa.length;
        });
      });
    });
  }

  Future<Null> selecionarData() async {
    //dataSelecionada is a final DateTime
    dataSelecionada = await showDatePicker(
        context: context,
        initialDate: dataAtual,
        firstDate: DateTime(2019),
        lastDate: DateTime(2022),
        builder: (BuildContext context, Widget child) {
          return ListView(
            children: <Widget>[
              Theme(
                child: child,
                data: ThemeData(primaryColor: Colors.purple[300]),
              ),
            ],
          );
        });
  }
}
