import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:organizer/model/database_helper.dart';
import 'package:organizer/model/obj_tarefa.dart';

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
  String dropdownDisciplina = "Disciplina";
  String dropdownPrioridade = "Prioridade";
  String txtData;

  int _prioridade = 0;
  int count;
  int _data = 0;

  double _valor = 0.0;

  DateTime dataAtual = new DateTime.now();
  DateTime dataInicial;
  DateTime dataSelecionada;

  List<String> listaPrioridade = ["Baixa", "Média", "Alta"];
  List<String> stringDisciplinas = [];

  DatabaseHelper databaseHelper = DatabaseHelper();

  MediaQueryData mediaQuery;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    disciplinasDropdown();

    valoresIniciais();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitulo()),
        backgroundColor: Color(0xffF5891F),
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
                      Container(
                        padding: EdgeInsets.only(
                            top: 30.0, left: mediaQuery.size.width / 80),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(dropdownDisciplina,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0)),
                            ),
                            onChanged: (String novoValor) {
                              setState(() {
                                dropdownDisciplina = novoValor;
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: mediaQuery.size.width / 2.3,
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
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      Container(
                          width: mediaQuery.size.width / 2.3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: valorInicialValor(),
                            validator: (value) {
                              if (value.isEmpty) return 'Campo vazio!';
                              if (double.parse(value) > 100)
                                return 'Valor maior que 100.0!';
                              _valor = double.parse(value);
                            },
                            decoration: InputDecoration(
                                labelText: 'Valor',
                                hintText: 'Ex. 30 pts',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                  height: 55.0,
                                  width: mediaQuery.size.width / 2.3,
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
                                            txtData,
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 15.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      selecionarData();
                                    },
                                    shape: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ))
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: mediaQuery.size.width / 2.3,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text(dropdownPrioridade,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0)),
                                  onChanged: (String novoValor) {
                                    setState(() {
                                      dropdownPrioridade = novoValor;
                                      _prioridade = valorPrioridade(novoValor);
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
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: mediaQuery.size.width -
                                  (mediaQuery.size.width / 15),
                              child: TextFormField(
                                maxLength: 110,
                                maxLines: 4,
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

  void valoresIniciais() {
    if (widget.acao == 'a') {
      dataInicial = DateTime.now();
      txtData = "Data";
      return;
    } else if (widget.acao == 'e') {
      dropdownDisciplina = widget.tarefa.getDisciplina();
      dropdownPrioridade = nomePrioridade(widget.tarefa.getPrioridade());
      _data = widget.tarefa.getData();
      _tipo = widget.tarefa.getTipo();
      _valor = widget.tarefa.getValor();
      _data = widget.tarefa.getData();
      _disciplina = widget.tarefa.getDisciplina();
      _prioridade = widget.tarefa.getPrioridade();
      dataInicial = DateTime.fromMillisecondsSinceEpoch(_data);
      txtData = ("${dataInicial.day}/${dataInicial.month}/${dataInicial.year}");
    }
  }

  String nomePrioridade(int prioridade) {
    if (prioridade == 1) return "Baixa";

    if (prioridade == 2) return "Média";

    if (prioridade == 3) return "Alta";

    return "";
  }

  int valorPrioridade(String string) {
    if (string == "Baixa") return 1;

    if (string == "Média") return 2;

    if (string == "Alta") return 3;

    return 0;
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
    else if (widget.acao == "e") {
      return _tipo;
    }
    return "";
  }

  String valorInicialValor() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") {
      return _valor.toString();
    }

    return "";
  }

  String valorInicialDescricao() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") {
      return widget.tarefa.getDescricao();
    }
    return "";
  }

  String dataFormatada(int _data) {
    DateTime data = DateTime.fromMillisecondsSinceEpoch(_data);
    String day = data.day.toString();
    String month = data.month.toString();
    if(day.length == 1) day = "0" + day;
    if(month.length == 1) month = "0" + month; 
    String dataFormatada = ("$day/$month/${data.year}");
    return dataFormatada;
  }

  void errorMsg(String msg, int vezesVoltarTela) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            msg,
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (vezesVoltarTela == 2) Navigator.pop(context);
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
              child: new Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
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

    _tipo = (_tipo[0].toUpperCase() + _tipo.substring(1));

    if (_disciplina == "") {
      errorMsg("Campo 'Disciplina' vazio!", 1);
      return;
    }

    if (_data == 0) {
      errorMsg("Campo 'Entrega' vazio!", 1);
      return;
    }

    if (_prioridade == 0) {
      errorMsg("Campo 'Prioridade' vazio!", 1);
      return;
    }

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
    }
    if (result == 0) errorMsgSalvar();
    if (widget.acao == "e") Navigator.pop(context, true);

    Navigator.pop(context, true);
  }

  void disciplinasDropdown() {
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<String>> disciplinasListFuture =
          databaseHelper.getNomesDisciplina();
      disciplinasListFuture.then((listaDisciplinas) {
        setState(() {
          stringDisciplinas = listaDisciplinas;
          if (listaDisciplinas.isEmpty)
            errorMsg("Cadastre disciplinas primeiro!", 2);
        });
      });
    });
  }

  Future<Null> selecionarData() async {
    dataSelecionada = await showDatePicker(
        context: context,
        initialDate: dataInicial,
        firstDate: DateTime(2019),
        lastDate: DateTime(2022),
        builder: (BuildContext context, Widget child) {
          return SingleChildScrollView(
              child: Theme(
                  child: child,
                  data: ThemeData.light().copyWith(
                    primaryColor: Color(0xffF5891F),
                    colorScheme:
                        ColorScheme.light(primary: const Color(0xffF5891F)),
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    accentColor: Color(0xffF5891F),
                  )));
        });
    if (dataSelecionada != null) {
      _data = dataSelecionada.millisecondsSinceEpoch;

      setState(() {
        txtData = dataFormatada(_data);
      });
    }
  }
}
