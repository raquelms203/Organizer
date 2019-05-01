
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './obj_disciplina.dart';

class DatabaseHelper {
  //singleton databasehelper
  static DatabaseHelper _databaseHelper;

  //singleton database
  static Database _database;

  String tableDisciplinas = 'disciplinas';
  String colId = 'id';
  String colDisciplina = 'disciplina';
  String colCod = 'cod';
  String colLimFaltas = 'lim_faltas';
  String colPeriodo = 'periodo';
  String colFaltas = 'faltas';
  String colMeta = 'meta';
  String colStatus = 'status';

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

    var disciplinaDatabase = await openDatabase(path, version: 1, onCreate: _criarDb);
    return disciplinaDatabase;
  }

  void _criarDb(Database db, int newVersion) async {
    await db.execute('''
          CREATE TABLE $tableDisciplinas (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,
            $colDisciplina TEXT NOT NULL,
            $colCod TEXT NOT NULL,
            $colFaltas INTEGER (2) NOT NULL,
            $colLimFaltas INTEGER (2) NOT NULL,
            $colMeta DOUBLE NOT NULL,
            $colStatus INTEGER (1) NOT NULL,
            $colPeriodo TEXT NOT NULL

          )''');
  }

  // fecth -> SELECT todas as disciplinas do db [objeto Map]
  Future<List<Map<String, dynamic>>> getDisciplinaMapList() async {
    Database db = await this.getDatabase();
    var result = await db.rawQuery('SELECT * FROM $tableDisciplinas');
    return result;
  }

  Future<int> inserir(Disciplina disciplina) async {
    Database db = await this.getDatabase();
    var result = await db.insert(tableDisciplinas, disciplina.toMap());
    return result;
  }

  Future<int> atualizar(Disciplina disciplina) async {
    var db = await this.getDatabase();
    var result = await db.update(tableDisciplinas, disciplina.toMap(), where: '$colId = ?', whereArgs: [disciplina.getId()]);
    return result;
  }

  Future<int> apagar(int id) async {
    var db = await this.getDatabase();
    int result = await db.rawDelete('DELETE FROM $tableDisciplinas WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.getDatabase();
    List<Map<String, dynamic>> lista = await db.rawQuery('SELECT COUNT (*) from $tableDisciplinas');
    int result = Sqflite.firstIntValue(lista);
    return result;
  }

  //Converter List<Map> para List<Disciplina>
  Future<List<Disciplina>> getDisciplinaLista() async {
    
    var disciplinaMapList = await getDisciplinaMapList();
    int count = disciplinaMapList.length;

    List<Disciplina> disciplinaLista = List<Disciplina>();
    
    // for para cada List<Map> ser List<Disciplina>
    for (int i=0; i<count; i++) {
      disciplinaLista.add(Disciplina.fromMapObject(disciplinaMapList[i]));
    }

    return disciplinaLista;
  }

}
