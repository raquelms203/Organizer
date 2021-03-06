import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:organizer/controller/form_disciplina.dart';
import './view_disciplina.dart';
import 'package:organizer/model/obj_disciplina.dart';
import 'package:organizer/model/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ListaDisciplinas extends StatefulWidget {
  List<Disciplina> listaDisciplina;

  ListaDisciplinas({this.listaDisciplina});

  @override
  State createState() => new _ListaDisciplinas(this.listaDisciplina);
}

class _ListaDisciplinas extends State<ListaDisciplinas>
    with AutomaticKeepAliveClientMixin {
  List<Disciplina> listaDisciplina;
  DatabaseHelper databaseHelper = DatabaseHelper();
  MediaQueryData mediaQuery;

  _ListaDisciplinas(this.listaDisciplina);

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
    atualizarListView();

    // if (listaDisciplina == null) {
    //   return Container(
    //     height: 10,
    //     width: 10,
    //     padding: const EdgeInsets.only(top: 40),
    //     child: CircularProgressIndicator());
    // }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () async {
          bool result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return FormDisciplina.add(
              acao: "a",
              listaDisciplina: listaDisciplina,
            );
          }));

          if (result == true) atualizarListView();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[400],
        tooltip: "Adicionar Disciplina",
      ),
      body: listaDisciplina == null
          ? Container(
            height: 80,
            alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 40),
          child: CircularProgressIndicator())
          : Container(
              child: Column(
              children: <Widget>[
                txtListaVazia(listaDisciplina.length),
                carregarLista()
              ],
            )),
    );
  }

  Container txtListaVazia(int tam) {
    if (tam == 0) {
      return Container(
        padding: EdgeInsets.only(top: mediaQuery.size.height / 3),
        alignment: Alignment.center,
        child: Text(
          "Não há disciplinas cadastradas!",
          style: TextStyle(color: Colors.grey[600], fontSize: 18.0),
        ),
      );
    } else if (tam > 0) {
      return Container();
    }
    return Container();
  }

//getDisciplinaListView
  Expanded carregarLista() {
    return Expanded(
      child: ListView.builder(
          itemCount: listaDisciplina.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.assignment, size: 40.0),
                  title: Text(
                    listaDisciplina[index].getDisciplina(),
                    maxLines: 3,
                  ),
                  subtitle: Text(listaDisciplina[index].getCod()),
                  trailing: Text("${listaDisciplina[index].getNota()}/100",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[600],
                          fontSize: 18.0)),
                  onTap: () async {
                    bool result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewDisciplina(disciplina: listaDisciplina[index]);
                    }));
                    if (result == true) atualizarListView();
                  },
                ),
              ),
            );
          }),
    );
  }

  void atualizarListView() {
    final Future<Database> dbFuture = databaseHelper.iniciarDb();
    dbFuture.then((database) {
      Future<List<Disciplina>> disciplinaListFuture =
          databaseHelper.getDisciplinaLista();
      disciplinaListFuture.then((listaDisciplina) {
        setState(() {
          this.listaDisciplina = listaDisciplina;
        });
      });
    });
  }
}
