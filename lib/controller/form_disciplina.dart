import 'package:flutter/material.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/model/database_helper.dart';

class FormDisciplina extends StatefulWidget {
  List<Disciplina> listaDisciplina;
  Disciplina disciplina;
  String acao;
  int id;

  FormDisciplina.add({
    this.listaDisciplina,
    this.acao,
  });

  FormDisciplina.editar({this.disciplina, this.id, this.acao});

  @override
  State createState() => new _FormDisciplina();
}

class _FormDisciplina extends State<FormDisciplina> {
  String dropdownDefault = "Período";
  String dropdownDefault3 = "Status";
  String _disciplina = "";
  String acao = "";
  String _cod = "";
  String _periodo = "";
  int _limFaltas = 0;
  int _status = -1;
  double _meta = 0.0;
  double _nota = 0.0;
  MediaQueryData mediaQuery;

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    valorInicialDropdown();
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
                  salvarDisciplina();
                }
              })
        ],
      ),
      body: Builder(builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: mediaQuery.size.width - (mediaQuery.size.width / 21),
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
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
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
                            hintText: 'Ex. CSI 401',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, right: 8),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(dropdownDefault,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22.0)),
                        onChanged: (String novoValor) {
                          setState(() {
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
                  )
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.only(right: mediaQuery.size.width / 14)),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  List<String> periodos() {
    List<String> periodos = [""];
    int i;

    for (i = 1; i <= 12; i++) periodos.add("$iº P");

    periodos.add("Eletiva");
    return periodos;
  }

  String appbarTitulo() {
    if (widget.acao == "e") return "Editar Disciplina";

    return "Adicionar Disciplina";
  }

  String valorInicialPeriodo() {
    if (widget.acao == "e")
      return widget.disciplina.getPeriodo();
    else
      return "Período";
  }

  void valorInicialDropdown() {
    if (widget.acao == "a")
      return;
    else if (widget.acao == "e") {
      dropdownDefault = widget.disciplina.getPeriodo();
      _periodo = widget.disciplina.getPeriodo();
    }
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

  void errorMsg(String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "$mensagem",
            style: TextStyle(color: Colors.red),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  bool disciplinaExiste(String disciplina) {
    int tam = widget.listaDisciplina.length;

    for (int i = 0; i < tam; i++)
      if (disciplina == widget.listaDisciplina[i].getDisciplina()) return true;

    return false;
  }

  void salvarDisciplina() async {
    int result;

    if (_periodo == "") {
      errorMsg("Selecione o Período!");
      return;
    }

    _disciplina = (_disciplina[0].toUpperCase() + _disciplina.substring(1));
    _cod = _cod.toUpperCase();

    if (widget.acao == "e") {
      widget.disciplina.setDisciplina(_disciplina);
      widget.disciplina.setCod(_cod);
      widget.disciplina.setPeriodo(_periodo);

      result = await databaseHelper.atualizarDisciplina(widget.disciplina);
    } else if (widget.acao == "a") {
      if (disciplinaExiste(_disciplina)) {
        errorMsg("Disciplina já cadastrada!");
        return;
      }

      Disciplina disciplina =
          new Disciplina(_disciplina, _cod, 0, _periodo, _nota);

      result = await databaseHelper.inserirDisciplina(disciplina);
    }

    if (result == 0) errorMsg("Erro ao Salvar!");

    if (widget.acao == "e") Navigator.pop(context, true);
    Navigator.pop(context, true);
  }
}
