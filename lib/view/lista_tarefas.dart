import 'package:flutter/material.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/model/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:organizer/controller/form_tarefa.dart';
import 'package:organizer/model/obj_tarefa.dart';
import 'package:organizer/view/view_tarefa.dart';

class ListaTarefas extends StatefulWidget {
  List<Tarefa> listaTarefa;
  List<Disciplina> listaDisciplina;
  bool apenasVisualizar = false;

  ListaTarefas({this.listaTarefa});
  ListaTarefas.visualizar({this.listaTarefa, this.apenasVisualizar});

  @override
  State createState() => new _ListaTarefas(this.listaTarefa);
}

class _ListaTarefas extends State<ListaTarefas>
    with AutomaticKeepAliveClientMixin {
  DateTime dataAtual = new DateTime.now();
  bool apenasVisualizar;
  bool mostrarBtn = false;
  bool mostrarAntigas = false;
  List<Tarefa> listaTarefa;
  List<Tarefa> listaDiasPositivo = List<Tarefa>();
  List<Tarefa> listaExibir = List<Tarefa>();
  List<Tarefa> listaCompleta = List<Tarefa>();
  MediaQueryData mediaQuery;

  DatabaseHelper databaseHelper = DatabaseHelper();

  _ListaTarefas(this.listaTarefa);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.apenasVisualizar) {
      if (mostrarAntigas)
        listaExibir = listaCompleta;
      else if (!mostrarAntigas) listaExibir = listaDiasPositivo;
    }

    if ((widget.apenasVisualizar == false && listaTarefa != null))
      atualizarListView();

    if (listaTarefa == null) {
      listaTarefa = List<Tarefa>();
      listaDiasPositivo = listaTarefa;
    }

    listaCompleta = listaTarefa;
    iniciarListaDiasPositivo(false);

    mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar(),
      floatingActionButton: floatingBtn(),
      body: Container(
        child: Column(
          children: <Widget>[
            btnTarefasAntiga(),
            txtListaVazia(),
            carregarLista(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    if (!widget.apenasVisualizar)
      return null;
    else {
      return AppBar(
        backgroundColor:  Color(0xffF5891F),
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      );
    }
  }

  FloatingActionButton floatingBtn() {
    if (widget.apenasVisualizar)
      return null;
    else {
      return FloatingActionButton(
        heroTag: "btn2",
        onPressed: () async {
          bool result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return FormTarefa.add(listaTarefa: listaTarefa, acao: "a");
          }));
          if (result == true) atualizarListView();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        tooltip: "Adicionar Tarefa",
      );
    }
  }

  Container txtListaVazia() {
    if (listaExibir.isNotEmpty)
      return Container();
    else {
      setState(() {
        mostrarBtn = false;
      });
      return Container(
        padding: EdgeInsets.only(top: mediaQuery.size.height / 3),
        alignment: Alignment.center,
        child: Text(
          "Não há tarefas cadastradas!",
          style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
        ),
      );
    }
  }

  Container btnTarefasAntiga() {
    String txtBtn = "";

    if (listaDiasPositivo.length == listaCompleta.length)
      mostrarBtn = false;
    else
      mostrarBtn = true;

    if (mostrarAntigas) {
      txtBtn = "Ocultar Tarefas Antigas";
    } else if (!mostrarAntigas) txtBtn = "Mostrar Tarefas Antigas";

    if (mostrarBtn) {
      return Container(
        color: Colors.white30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FlatButton(
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal[300])),
                color: Colors.white,
                child: Text(
                  txtBtn,
                  style: TextStyle(
                      color: Colors.teal[300], fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    if (mostrarAntigas) {
                      mostrarAntigas = false;
                      listaExibir = listaDiasPositivo;
                    } else if (!mostrarAntigas) {
                      mostrarAntigas = true;
                      listaExibir = listaCompleta;
                    }
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  void iniciarListaDiasPositivo(bool atualizar) {
    int i = 0;
    Tarefa tarefa;
    if (listaDiasPositivo.isNotEmpty && !atualizar) return;

    if (listaTarefa.isEmpty) {
      listaDiasPositivo = List<Tarefa>();
      return;
    }

    if (atualizar) {
      listaDiasPositivo.removeRange(0, listaDiasPositivo.length);
    }

    setState(() {
      while (i != listaTarefa.length) {
        if (diasRestantes(listaTarefa[i].getData()) >= 0) {
          tarefa = listaTarefa[i];
          listaDiasPositivo.add(tarefa);
        }
        i++;
      }
    });
  }

  //getTarefaListView
  Expanded carregarLista() {
    if (listaTarefa.length == 0) {
      return Expanded(child: Container());
    }
    return Expanded(
        child: ListView.builder(
            itemCount: listaExibir.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  child: ListTile(
                    leading:
                        iconePrioridade(listaExibir[index].getPrioridade()),
                    title: Text(listaExibir[index].getTipo()),
                    subtitle: Text(listaExibir[index].getDisciplina()),
                    trailing: Column(
                      children: <Widget>[
                        Text(
                          diasRestantes(listaExibir[index].getData())
                              .toString(),
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[600]),
                        ),
                        Text(
                          "DIAS",
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[600]),
                        ),
                      ],
                    ),
                    onTap: () async {
                      bool result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ViewTarefa(tarefa: listaExibir[index]);
                      }));
                      if (result == true) atualizarListView();
                    },
                  ),
                ),
              );
            }));
  }

  void atualizarListView() {
    if (widget.apenasVisualizar) return;
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<Tarefa>> tarefaListFuture = databaseHelper.getTarefaLista();
      tarefaListFuture.then((listaTarefa) {
        setState(() {
          this.listaTarefa = listaTarefa;
          listaCompleta = listaTarefa;
          iniciarListaDiasPositivo(true);
          if (mostrarAntigas)
            listaExibir = listaCompleta;
          else if (!mostrarAntigas) listaExibir = listaDiasPositivo;
        });
      });
    });
  }

  Icon iconePrioridade(int prioridade) {
    if (prioridade == 1)
      return Icon(Icons.error, color: Colors.blue[400], size: 45.0);
    else if (prioridade == 2)
      return Icon(Icons.error, color: Colors.amberAccent, size: 45.0);
    else if (prioridade == 3)
      return Icon(Icons.error, color: Colors.red[400], size: 45.0);

    return Icon(Icons.warning, size: 40.0);
  }

  String dataFormatada(Tarefa tarefa) {
    DateTime data = DateTime.fromMillisecondsSinceEpoch(tarefa.getData());
    String dataFormatada = ("${data.day}/${data.month}/${data.year}");
    return dataFormatada;
  }

  int diasRestantes(int data) {
    DateTime dataTarefa = DateTime.fromMillisecondsSinceEpoch(data);
    return dataTarefa.difference(dataAtual).inDays;
  }
}
