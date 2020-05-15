import 'package:flutter/material.dart';
import 'package:organizer/controller/form_tarefa.dart';
import 'package:organizer/model/obj_tarefa.dart';
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
  double saldoNotaDisciplina;
  double notaDisciplina;
  bool erro = false;
  bool editarNota = false;
  final notaController = TextEditingController();
  final FocusNode txtFocus = FocusNode();
  Tarefa tarefa;
  DatabaseHelper databaseHelper = DatabaseHelper();
  MediaQueryData mediaQuery;
  _ViewTarefa(this.tarefa);

  @override
  void initState() {
    _nota = tarefa.getNota();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (txtFocus.hasFocus) {
      setState(() {
        editarNota = true;
      });
    }

    mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar(),
      body: Container(
          child: Column(
        children: <Widget>[
          Card(
              child: Container(
            child: ListTile(
              title: Text("Disciplina:"),
              trailing: Container(
                width: MediaQuery.of(context).size.width - 130,
                child: Text(
                  tarefa.getDisciplina(),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //      Padding(
                  //      padding: EdgeInsets.only(left: mediaQuery.size.width / 60),
                  Text(
                    "    Nota:",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  //      ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 46.0,
                        width: 48.0,
                        child: TextField(
                          focusNode: txtFocus,
                          controller: notaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: tarefa.getNota().toString(),
                              hintStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              errorStyle:
                                  (erro ? TextStyle(color: Colors.red) : null)),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                          ],
                          onSubmitted: (String valor) {
                            _nota = double.parse(valor);
                            validarNota(_nota);
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(
                          "/${tarefa.getValor()}",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blueGrey[600],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width - 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  Text(
                    "  Descrição: ",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child: Text("${tarefa.getDescricao()}",
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.blueGrey[600])),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  AppBar appBar() {
    if (!editarNota) {
      return AppBar(
        backgroundColor: Color(0xffF5891F),
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
                  color: Colors.white,
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
                  color: Colors.white,
                  size: 30.0,
                )),
          ),
        ],
      );
    } else if (editarNota) {
      return AppBar(
        backgroundColor: Color(0xffF5891F),
        title: Text(tarefa.getTipo()),
        actions: <Widget>[
          SizedBox(
            height: 30.0,
            width: 50.0,
            child: FlatButton(
                onPressed: () {
                  _nota = double.parse(notaController.text);
                  validarNota(_nota);
                },
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 30.0,
                )),
          ),
        ],
      );
    }
    return AppBar();
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

  void validarNota(double nota) async {
    if (_nota > tarefa.getValor()) {
      alertError(context, "Nota maior que ${tarefa.getValor()}");
      notaController.text = "";
      editarNota = false;
      txtFocus.unfocus();
      return;
    }
    if (_nota < 0) {
      alertError(context, "Nota menor que 0.0!");
      notaController.text = "";
      editarNota = false;
      txtFocus.unfocus();
      return;
    }

    if (tarefa.getNota() != 0)
      saldoNotaDisciplina = _nota - tarefa.getNota();
    else
      saldoNotaDisciplina = _nota;

    notaDisciplina =
        await databaseHelper.getNotaDisciplina(tarefa.getDisciplina());

    if (notaDisciplina + saldoNotaDisciplina > 100) {
      alertError(context, "Nota total da Disciplina passou de 100.0!");
      notaController.text = "";
      editarNota = false;
      txtFocus.unfocus();
      return;
    }

    tarefa.setNota(_nota);
    await databaseHelper.atualizarNota(tarefa, _nota, tarefa.getId());
    await databaseHelper.atualizarNotaDisciplina(
        saldoNotaDisciplina, tarefa.getDisciplina());
    txtFocus.unfocus();
    editarNota = false;
  }

  void alertApagar(BuildContext context, Tarefa tarefa) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Deseja apagar essa tarefa?",
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text(
                "Não",
                style: TextStyle(fontSize: 15.0, color: Colors.black),
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
                onPressed: () async {
                  await databaseHelper.atualizarNotaDisciplina(
                      -tarefa.getNota(), tarefa.getDisciplina());
                  await databaseHelper.apagarTarefa(tarefa.getId());
                  Navigator.pop(context, true);
                  Navigator.pop(context, true);
                }),
          ],
        );
      },
    );
  }

  void alertError(BuildContext context, String erro) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            erro,
            style: TextStyle(color: Colors.red[600]),
          ),
          actions: <Widget>[
            FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }
}
