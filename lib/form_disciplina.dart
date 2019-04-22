import 'package:flutter/material.dart';
import './lista_disciplinas.dart';
import 'obj_disciplina.dart';

class FormDisciplina extends StatefulWidget {
  List<Container> lista;
  List<Disciplina> listaDisciplina;
  Disciplina disciplina;
  String acao;

  FormDisciplina.add(
      List<Container> lista, String acao, List<Disciplina> listaDisciplina) {
    this.lista = lista;
    this.acao = acao;
    this.listaDisciplina = listaDisciplina;
  }

  FormDisciplina.editar(
      Disciplina disciplina, String acao, List<Container> lista) {
    this.lista = lista;
    this.disciplina = disciplina;
    this.acao = acao;
  }

  @override
  State createState() => new _FormDisciplina();
}

class _FormDisciplina extends State<FormDisciplina> {
  String dropdownDefault = "Período";
  String dropdownDefault2 = "Máx. Faltas";
  String dropdownDefault3 = "Status";
  String _disciplina = "";
  String acao = "";
  String _cod = "";
  int _limFaltas = 0;
  String _periodo = "";
  bool _status;
  double _meta = 0.0;

  List<Container> lista = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appbarTitulo()),
        backgroundColor: Colors.purple[300],
      ),
      body: Builder(builder: (BuildContext context) {
        return Form(
          onChanged: () {
            valorInicialDropdown();
          },
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: 300.0,
                  child: TextFormField(
                    initialValue: valorInicialDisciplina(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo vazio!';
                      }
                    
                      _disciplina = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Ex. Prog Móvel',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
                child: Container(
                  width: 300.0,
                  child: TextFormField(
                    initialValue: valorInicialCod(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo vazio!';
                      }
                      _cod = value;
                    },
                    decoration: InputDecoration(
                        labelText: 'Código',
                        hintText: 'Ex. CSI 451',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 15.0)),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 2.0),
                        child: TextFormField(
                          initialValue: valorInicialMeta(),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) return 'Campo vazio!';

                            if (double.parse("$value") < 60.0)
                              return 'Meta menor que 60.0!';

                            if (double.parse("$value") > 100.0)
                              return 'Meta maior que 100.0!';

                            _meta = double.parse(value);
                          },
                          decoration: InputDecoration(
                              labelText: 'Meta',
                              hintText: 'Ex. 60 pts',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30.0, right: 35.0)),
                    Container(
                      padding: EdgeInsets.only(right: 20.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text(dropdownDefault,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                          onChanged: (String novoValor) {
                            setState(() {
                                    valorInicialDropdown();
                              dropdownDefault = novoValor;
                              _periodo = novoValor;
                            });
                          },
                          items: periodos()
                              .map<DropdownMenuItem<String>>((String valor) {
                            return DropdownMenuItem<String>(
                                value: valor,
                                child: Text(
                                  valor,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 17.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 1.0)),
                    Container(
                      width: 128.0,
                      height: 50.0,
                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text(dropdownDefault2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                          onChanged: (String novoValor) {
                            setState(() {
                                     valorInicialDropdown();
                              dropdownDefault2 = novoValor;
                              _limFaltas = int.parse(
                                  dropdownDefault2[0] + dropdownDefault2[1]);
                            });
                          },
                          items: ['9 Faltas', '18 Faltas']
                              .map<DropdownMenuItem<String>>((String valor) {
                            return DropdownMenuItem<String>(
                                value: valor,
                                child: Text(
                                  valor,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 73.0)),
                    Container(
                      width: 125.0,
                      height: 50.0,
                      padding: EdgeInsets.only(
                          top: 5.0, bottom: 5.0, right: 5.0, left: 5.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text(dropdownDefault3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                          onChanged: (String novoValor) {
                            setState(() {
                                  valorInicialDropdown();
                              dropdownDefault3 = novoValor;
                              if (novoValor == "Cursando")
                                _status = true;
                              else if (novoValor == "Encerrada")
                                _status = false;
                            });
                          },
                          items: ['Cursando', 'Encerrada']
                              .map<DropdownMenuItem<String>>((String valor) {
                            return DropdownMenuItem<String>(
                                value: valor,
                                child: Text(
                                  valor,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ));
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
                    color: Colors.green[500],
                    child: Text("Salvar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        salvarDisciplina();
                      }
                    }),
              )
            ],
          ),
        );
      }),
    );
  }

  List<String> periodos() {
    List<String> periodos = [""];
    int i;
    for (i = 1; i <= 10; i++) periodos.add("$iº P");

    periodos.add("Eletiva");
    return periodos;
  }

  String appbarTitulo() {
    if (widget.acao == "e") return "Editar Disciplina";

    return "Adicionar Disciplina";
  }

  String valorInicialDisciplina() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.disciplina.getDisciplina();

    return "";
  }

  String valorInicialCod() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.disciplina.getCod();

    return "";
  }

  String valorInicialMeta() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.disciplina.getMeta().toString();

    return "";
  }

  void valorInicialDropdown() {
    if (widget.acao == "a")
      return;
    else if (widget.acao == "e") {
      setState(() {
        dropdownDefault = widget.disciplina.getPeriodo();
        _periodo = widget.disciplina.getPeriodo();
        dropdownDefault2 =
            (widget.disciplina.getLimFaltas().toString() + " Faltas");
        _limFaltas = widget.disciplina.getLimFaltas();

        if (widget.disciplina.getStatus() == false) {
          dropdownDefault3 = "Encerrada";
          _status = false;
        } else if (widget.disciplina.getStatus() == true) {
          dropdownDefault3 = "Cursando";
          _status = true;
        }
      });
    }
  }

  bool errorMsg(String campo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Selecione o " + campo + "!",
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
    return true;
  }

  void salvarDisciplina() {
    if (_periodo == "") {
      errorMsg("Período");
      return;
    }

    if (_limFaltas == 0) {
      errorMsg("Máx de Faltas");
      return;
    }

    if (_status.toString() != "true" && _status.toString() != "false") {
      errorMsg("Status");
      return;
    }    
    _disciplina = (_disciplina[0].toUpperCase() + _disciplina.substring(1));
    _cod = _cod.toUpperCase();

    if (widget.acao == "e") {
      widget.disciplina.setDisciplina(_disciplina);
      widget.disciplina.setCod(_cod);
      widget.disciplina.setLimFaltas(_limFaltas);
      widget.disciplina.setMeta(_meta);
      widget.disciplina.setPeriodo(_periodo);
      widget.disciplina.setStatus(_status);

      
    } else if (widget.acao == "a") {
      Disciplina disciplina = new Disciplina();
      disciplina.setDisciplina(_disciplina);
      disciplina.setCod(_cod);
      disciplina.setFaltas(0);
      disciplina.setLimFaltas(_limFaltas);
      disciplina.setMeta(_meta);
      disciplina.setPeriodo(_periodo);
      disciplina.setStatus(_status);

      Container cont =
          ListaDisciplinas(lista: widget.lista).cardDisciplina(disciplina);
      widget.lista.add(cont);

      widget.listaDisciplina.add(disciplina);
    }
    Navigator.pop(context);
  }
}
