import 'package:flutter/material.dart';
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
  String _descricao;
  String _disciplina;
  String _tipo;
  String dropdownDefault = "";
  String dropdownDefault2 = "Prioridade";
  String _nota;
  int _entrega;
  int _prioridade;
  double _valor;

  List<String> lista = ["Nome1", "Nome2"];
  List<String> listaPrioridade = ["1", "2", "3"];

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
            child: Text(
              "Salvar",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 18.0),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {}
            },
          )
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //   child: DropdownButtonHideUnderline(
                //     child: DropdownButton<String>(
                //       hint: Text(dropdownDefault,
                //            style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 20.0
                //       )),
                //       onChanged: (String novoValor) {
                //         setState(() {
                //          dropdownDefault = novoValor;
                //          _disciplina = novoValor;
                //         });
                //       },
                //       items: await disciplinas().map<DropdownMenuItem<String>>((String valor) {
                //         return DropdownMenuItem<String>(
                //           value: valor,
                //           child: Text(
                //             valor,
                //             style: TextStyle(fontWeight: FontWeight.bold),

                //           ));
                //       }).toList(),
                //   ),
                // ),

                Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 15.0),
                  child: Row(children: <Widget>[
                    Column(children: <Widget>[
                      SizedBox(
                        height: 60.0,
                        width: 340.0,
                        child: DropDownField(
                            value: dropdownDefault,
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            required: false,
                            labelText: 'Disciplina',
                            items: lista,
                            setter: (dynamic newValue) {
                              dropdownDefault2 = newValue;
                            }),
                      ),
                    ]),
                  ]),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 10.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                              width: 150.0,
                              height: 30.0,
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
                        padding:
                            EdgeInsets.only(left: 25.0, top: 10.0, right: 10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                height: 30.0,
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
                          top: 40.0,
                          left: 15.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                height: 30.0,
                                width: 150.0,
                                child: TextFormField(
                                  initialValue: valorInicialEntrega(),
                                  keyboardType: TextInputType.datetime,
                                  validator: (value) {
                                    if (value.isEmpty) return 'Campo vazio!';
                                    _entrega = int.parse(value);
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Entrega',
                                      hintText: '18/05/2019',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                ))
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 28.0),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 40.0),
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
                      padding: EdgeInsets.only(top: 40.0, left: 15.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 80.0,
                            width: 325.0,
                            child: TextFormField(
                              initialValue: valorInicialDescricao(),
                              validator: (value) {
                                _descricao = value;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Descrição:',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ));
      }),
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
    else if (widget.acao == "e") return widget.tarefa.getEntrega().toString();
    return "";
  }

  String valorInicialDescricao() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.tarefa.getDescricao();
    return "";
  }

  bool errorMsgCampoVazio(String campo) {
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
    return true;
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

    if (_tipo == "") {
      errorMsgCampoVazio("Tipo");
      return;
    }

    if (_valor == "") {
      errorMsgCampoVazio("Valor");
      return;
    }

    if (_prioridade == "") {
      errorMsgCampoVazio("Prioridade");
      return;
    }

    if (_entrega == "") {
      errorMsgCampoVazio("Entrega");
      return;
    }

    _tipo = (_tipo[0].toUpperCase() + _tipo.substring(1));

    if (widget.acao == "e") {
      widget.tarefa.setDisciplina(_disciplina);
      widget.tarefa.setTipo(_tipo);
      widget.tarefa.setValor(_valor);
      widget.tarefa.setPrioridade(_prioridade);
      widget.tarefa.setEntrega(_entrega);

      result = await databaseHelper.atualizarTarefa(widget.tarefa);
    } else if (widget.acao == "a") {
      Tarefa tarefa = new Tarefa(_disciplina, _descricao, _tipo, _valor, 0.0, _entrega, _prioridade);
      result = await databaseHelper.inserirTarefa(tarefa);
    }
    if (result== 0) errorMsgSalvar();

    Navigator.pop(context, true);
  }

  Future<List<String>> disciplinas() async {
    List<String> result = await databaseHelper.getNomesDisciplina();
    return result;
  }
}
