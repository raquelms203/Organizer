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
  bool mostrarBtn = true;
  bool mostrarAntigas = false;
  List<Tarefa> listaTarefa;
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

    mediaQuery = MediaQuery.of(context);

    if (listaTarefa != null && widget.apenasVisualizar == false)
      atualizarListView();

    if (listaTarefa == null) listaTarefa = List<Tarefa>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
      ),
      body: 
      
              Container(
          child: Column(
            children: <Widget>[
              btnTarefasAntiga(),
              txtListaVazia(listaTarefa.length),
              carregarLista()
            ],
          ),
        ),
      
    );
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
                  "Mostrar Tarefas Antigas",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {  
                  setState(() {
                    mostrarBtn = false;
                    mostrarAntigas = true;
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

  //getTarefaListView
  Expanded carregarLista() {
    return Expanded(
      child: ListView.builder(
        itemCount: listaTarefa.length,
        itemBuilder: (BuildContext context, int index) {
         
          if (diasRestantes(listaTarefa[index].getData()) > 0) {
          return Container(
            child: Card(
              child: ListTile(
                leading: iconePrioridade(listaTarefa[index].getPrioridade()),
                title: Text(listaTarefa[index].getTipo()),
                subtitle: Text(listaTarefa[index].getDisciplina()),
                trailing: Column(
                  children: <Widget>[
                    Text(
                      diasRestantes(listaTarefa[index].getData()).toString(),
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
                    return ViewTarefa(tarefa: listaTarefa[index]);
                  }));
                  if (result == true) atualizarListView();
                },
          
              ),
            ),
          );
          
        // } else if (mostrarAntigas && diasRestantes(listaTarefa[index].getData()) < 0){
        //   return Container(
        //     child: Card(
        //       child: ListTile(
        //         leading: iconePrioridade(listaTarefa[index].getPrioridade()),
        //         title: Text(listaTarefa[index].getTipo()),
        //         subtitle: Text(listaTarefa[index].getDisciplina()),
        //         trailing: Column(
        //           children: <Widget>[
        //             Text(
        //               diasRestantes(listaTarefa[index].getData()).toString(),
        //               style: TextStyle(
        //                   fontSize: 30.0,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.blueGrey[600]),
        //             ),
        //             Text(
        //               "DIAS",
        //               style: TextStyle(
        //                   fontSize: 12.0,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.blueGrey[600]),
        //             ),
        //           ],
        //         ),
        //         onTap: () async {
        //           bool result = await Navigator.push(context,
        //               MaterialPageRoute(builder: (context) {
        //             return ViewTarefa(tarefa: listaTarefa[index]);
        //           }));
        //           if (result == true) atualizarListView();
        //         },
          
          }}));
            
          
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
