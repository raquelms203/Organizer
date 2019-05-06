import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './obj_disciplina.dart';
import 'package:organizer/model/obj_tarefa.dart';

class DatabaseHelper {
  //singleton databasehelper
  static DatabaseHelper _databaseHelper;

  //singleton database
  static Database _database;

  //tabela disciplinas
  String tableDisciplinas = 'disciplinas';
  String colIdDisciplina = 'id';
  String colDisciplina = 'disciplina';
  String colCod = 'cod';
  String colLimFaltas = 'lim_faltas';
  String colPeriodo = 'periodo';
  String colFaltas = 'faltas';
  String colMeta = 'meta';
  String colStatus = 'status';

  //tabela tarefas
  String tableTarefas = 'tarefas';
  String colIdTarefa = 'id';
  String colDescricao = 'descricao';
  String colDisciplinas = 'disciplinas';
  String colValor = 'valor';
  String colNota = 'nota';
  String colEntrega = 'entrega';
  String colTipo = 'tipo';
  String colPrioridade = 'prioridade';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await iniciarDb();
    }
    return _database;
  }

  Future<Database> iniciarDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'database.db';

    var disciplinaDatabase =
        await openDatabase(path, version: 1, onCreate: _criarDb);
    return disciplinaDatabase;
  }

  void _criarDb(Database db, int newVersion) async {
    await db.execute('''
          CREATE TABLE $tableDisciplinas (
            $colIdDisciplina INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,
            $colDisciplina TEXT NOT NULL,
            $colCod TEXT NOT NULL,
            $colFaltas INTEGER (2) NOT NULL,
            $colLimFaltas INTEGER (2) NOT NULL,
            $colMeta DOUBLE NOT NULL,
            $colStatus INTEGER (1) NOT NULL,
            $colPeriodo TEXT NOT NULL);

            CREATE TABLE tarefas (
            $colIdTarefa INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,
            $colDescricao TEXT NOT NULL,
            $colValor DOUBLE NOT NULL,
            $colDisciplina TEXT REFERENCES disciplinas (disciplina) NOT NULL,
            $colNota DOUBLE NOT NULL,
            $colEntrega INTEGER NOT NULL,
            $colTipo TEXT NOT NULL,
            $colPrioridade INTEGER (1) NOT NULL
            )''');
  }

  // funções disciplinas

  // fecth -> SELECT todas as disciplinas do db [objeto Map]
  Future<List<Map<String, dynamic>>> getDisciplinaMapList() async {
    Database db = await this.getDatabase();
    var result = await db.rawQuery('SELECT * FROM $tableDisciplinas');
    return result;
  }

  Future<int> inserirDisciplina(Disciplina disciplina) async {
    Database db = await this.getDatabase();
    var result = await db.insert(tableDisciplinas, disciplina.disciplinaToMap());
    return result;
  }

  Future<int> atualizarDisciplina(Disciplina disciplina) async {
    var db = await this.getDatabase();
    var result = await db.update(tableDisciplinas, disciplina.disciplinaToMap(),
        where: '$colIdDisciplina = ?', whereArgs: [disciplina.getId()]);
    return result;
  }

  Future<int> apagarDisciplina(int id) async {
    var db = await this.getDatabase();
    int result = await db.rawDelete(
        'DELETE FROM $tableDisciplinas WHERE $colIdDisciplina = $id');
    return result;
  }

  Future<int> atualizarFaltas(int faltas, int id) async {
    var db = await this.getDatabase();
    int result = await db.rawUpdate(
        'UPDATE $tableDisciplinas SET faltas = $faltas WHERE id = $id');
    return result;
  }

  Future<int> getCountDisciplina() async {
    Database db = await this.getDatabase();
    List<Map<String, dynamic>> lista =
        await db.rawQuery('SELECT COUNT (*) from $tableDisciplinas');
    int result = Sqflite.firstIntValue(lista);
    return result;
  }

  Future <List<String>> getNomesDisciplina() async {
    Database db = await this.getDatabase();
    List<String> listaNomeDisciplinas;

    var result = await db.rawQuery('SELECT disciplina FROM $tableDisciplinas');
    var stringMapList = result.toList();

    int tam = stringMapList.length;

    //for para cada List<Map> ser List<String>
    for (int i=0; i<tam; i++) {
      listaNomeDisciplinas.add(Disciplina.fromMapObject(stringMapList[i]).toString());
    }

    return listaNomeDisciplinas;
    
  }

  //converter List<Map> para List<Disciplina>
  Future<List<Disciplina>> getDisciplinaLista() async {
    var disciplinaMapList = await getDisciplinaMapList();
    int tam = disciplinaMapList.length;

    List<Disciplina> disciplinaLista = List<Disciplina>();

    // for para cada List<Map> ser List<Disciplina>
    for (int i = 0; i < tam; i++) {
      disciplinaLista.add(Disciplina.fromMapObject(disciplinaMapList[i]));
    }

    return disciplinaLista;
  }

  
  //converter List<Map> em List<String>. Função para retornar uma lista de disciplinas
  //  Future<List<Disciplina>> getNomeDisciplinas() async {
  //   var disciplinaMapList = await getDisciplinaMapList();
  //   int tam = disciplinaMapList.length;
  //    List<String> disciplinaNomes = List<String>();
    
     
  //   return result;
  // }

  //funções tarefas

  // fecth -> SELECT todas as disciplinas do db [objeto Map]
  Future<List<Map<String, dynamic>>> getTarefaMapList() async {
    Database db = await this.getDatabase();
    var result = await db.rawQuery('SELECT * FROM $tableTarefas');
    return result;
  }

   Future<int> inserirTarefa(Tarefa tarefa) async {
    Database db = await this.getDatabase();
    var result = await db.insert(tableTarefas, tarefa.tarefaToMap());
    return result;
  }

  Future<int> atualizarTarefa(Tarefa tarefa) async {
    var db = await this.getDatabase();
    var result = await db.update(tableTarefas, tarefa.tarefaToMap(),
        where: '$colIdTarefa = ?', whereArgs: [tarefa.getId()]);
    return result;
  }

  Future<int> apagarTarefa(int id) async {
    var db = await this.getDatabase();
    int result = await db
        .rawDelete('DELETE FROM $tableTarefas WHERE $colIdTarefa = $id');
    return result;
  }

  Future<int> getCountTarefa() async {
    Database db = await this.getDatabase();
    List<Map<String, dynamic>> lista =
        await db.rawQuery('SELECT COUNT (*) from $tableTarefas');
    int result = Sqflite.firstIntValue(lista);
    return result;
  }

  //converter List<Map> para List<Tarefa>
  Future<List<Tarefa>> getTarefaLista() async {
    var tarefaMapList = await getTarefaMapList();
    int count = tarefaMapList.length;

    List<Tarefa> tarefaLista = List<Tarefa>();

    // for para cada List<Map> ser List<Disciplina>
    for (int i = 0; i < count; i++) {
      tarefaLista.add(Tarefa.fromMapObject(tarefaMapList[i]));
    }

    return tarefaLista;
  }


}