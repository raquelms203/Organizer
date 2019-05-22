import 'package:flutter/material.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/model/database_helper.dart';
import 'package:organizer/view/lista_disciplinas.dart';

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
  String dropdownDefault2 = "Máx. Faltas";
  String dropdownDefault3 = "Status";
  String _disciplina = "";
  String acao = "";
  String _cod = "";
  int _limFaltas = 0;
  String _periodo = "";
  int _status = -1;
  double _meta = 0.0;

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
  
     return Scaffold(
        appBar: AppBar(
          title: Text(appbarTitulo()),
          backgroundColor: Colors.pink[400],
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
                  padding:
                      EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
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
                          hintText: 'Ex. CSI 401',
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
                      Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 35.0)),
                      Container(
                        padding: EdgeInsets.only(right: 20.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(dropdownDefault,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            onChanged: (String novoValor) {
                              setState(() {
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0)),
                            onChanged: (String novoValor) {
                              setState(() {
                                dropdownDefault3 = novoValor;
                                if (novoValor == "Cursando")
                                  _status = 1;
                                else if (novoValor == "Encerrada") _status = 0;
                              });
                            },
                            items: ['Cursando', 'Encerrada']
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
    for (i = 1; i <= 10; i++) periodos.add("$iº P");

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

      dropdownDefault2 =
          (widget.disciplina.getLimFaltas().toString() + " Faltas");
      _limFaltas = widget.disciplina.getLimFaltas();

      if (widget.disciplina.getStatus() == 0) {
        dropdownDefault3 = "Encerrada";
        _status = 0;
      } else if (widget.disciplina.getStatus() == 1) {
        dropdownDefault3 = "Cursando";
        _status = 1;
      }
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

  String valorInicialMeta() {
    if (widget.acao == "a")
      return "";
    else if (widget.acao == "e") return widget.disciplina.getMeta().toString();

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

    for (int i=0; i<tam; i++) 
      if (disciplina == widget.listaDisciplina[i].getDisciplina())
        return true;
    
    return false;
  }

  void salvarDisciplina() async {
    int result;

    if (_periodo == "") {
      errorMsg("Selecione o Período!");
      return;
    }

    if (_limFaltas == 0) {
      errorMsg("Selecione o Máx de Faltas!");
      return;
    }

    if (_status == -1) {
      errorMsg("Selecione o Status!");
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

      result = await databaseHelper.atualizarDisciplina(widget.disciplina);

    } else if (widget.acao == "a") {

      if(disciplinaExiste(_disciplina)){
        errorMsg("Disciplina já cadastrada!");
        return;
      }

      Disciplina disciplina = new Disciplina(
          _disciplina, _cod, 0, _limFaltas, _meta, _periodo, _status);

      result = await databaseHelper.inserirDisciplina(disciplina);
    }
    print(result);

    if (result == 0) errorMsg("Erro ao Salvar!");

    Navigator.pop(context, true);
  }
}
