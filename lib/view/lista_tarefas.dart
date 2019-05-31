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
  MediaQueryData mediaQuery;

  DatabaseHelper databaseHelper = DatabaseHelper();

  _ListaTarefas(this.listaTarefa);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    atualizarListView();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    mediaQuery = MediaQuery.of(context);

    if (listaTarefa != null && widget.apenasVisualizar == false) {
      atualizarListView();
    }

    iniciarListaDiasPositivo();

    if (listaTarefa == null) {
      listaTarefa = List<Tarefa>();
      listaDiasPositivo = listaTarefa;
    }

    return Scaffold(
      appBar: appBar(),
      floatingActionButton: floatingBtn(),
      body: Container(
        child: Column(
          children: <Widget>[
            txtListaVazia(listaExibir.length),
            btnTarefasAntiga(),
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
        backgroundColor: Colors.pink[400],
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back,
            size: 30,
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

  Container txtListaVazia(int tam) {
    if (tam > 0)
      return Container();
    else {
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
    if (listaExibir.length > 0) {
      mostrarBtn = true;
    }

    if (mostrarAntigas) {
      txtBtn = "Ocultar Tarefas Antigas";
    } else if (!mostrarAntigas) txtBtn = "Mostrar Tarefas Antigas";

    if (mostrarBtn) {
      return Container(
        color: Colors.blueGrey[200],
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: mediaQuery.size.height / 8),
              child: Container(
                child: FlatButton(
                  color: Colors.blueGrey[400],
                  child: Text(
                    txtBtn,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      if (mostrarAntigas) {
                        mostrarAntigas = false;
                        listaExibir = listaDiasPositivo;
                      } else if (!mostrarAntigas) {
                        mostrarAntigas = true;
                        listaExibir = listaTarefa;
                      }
                      //       print("Exibir: $listaExibir");
                      //       print("Positivo: $listaDiasPositivo");
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  void iniciarListaDiasPositivo() {
    int i = 0;
    Tarefa tarefa;
    if (listaDiasPositivo.isNotEmpty) return;

    if (listaTarefa.isEmpty) {
      listaDiasPositivo = List<Tarefa>();
      return;
    }
    //   print("ListaTarefas: $listaTarefa");

    while (i != listaTarefa.length) {
      if (diasRestantes(listaTarefa[i].getData()) >= 0) {
        tarefa = listaTarefa[i];
        print(tarefa.getDisciplina());
        listaDiasPositivo.add(tarefa);
      }
      i++;
    }

    setState(() {
      //   print("set state lista positivo: $listaDiasPositivo");
      listaExibir = listaDiasPositivo;
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
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<Tarefa>> tarefaListFuture = databaseHelper.getTarefaLista();
      tarefaListFuture.then((listaTarefa) {
        setState(() {
          this.listaTarefa = listaTarefa;
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
