import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteConnection {

  Database connec() {
     Database database;
    //path
     executar() async {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = documentsDirectory.path + '/database.db';

    // abrir conexão
        database = await openDatabase(path, version: 1,
        onUpgrade: (Database db, int version, int info) async {

        },
        onCreate: (Database db, int version) async {
          String createTableDisciplinas = "CREATE TABLE [disciplinas ] (" + 
				"    id         INTEGER PRIMARY KEY AUTOINCREMENT" + 
				"                       UNIQUE" + 
				"                       NOT NULL" + 
				"                       DEFAULT \"\"," + 
				"    disciplina TEXT    UNIQUE" + 
				"                       NOT NULL" + 
				"                       DEFAULT \"\"," + 
				"    cod        TEXT    UNIQUE" + 
				"                       NOT NULL" + 
				"                       DEFAULT \"\"," + 
				"    faltas     INTEGER (2) NOT NULL" + 
				"                       DEFAULT \"\"," + 
				"    lim_faltas INTEGER (2) NOT NULL" + 
				"                       DEFAULT \"\"," + 
				"    meta       DOUBLE  NOT NULL" + 
				"                       DEFAULT \"\"," + 
				"    status     BOOLEAN NOT NULL" + 
				"                       DEFAULT \"\"" + 
				");";

        String createTableTarefas = "CREATE TABLE teste2 (\n" + 
					"    id         INTEGER PRIMARY KEY AUTOINCREMENT\n" + 
					"                       UNIQUE\n" + 
					"                       NOT NULL\n" + 
					"                       DEFAULT \"\",\n" + 
					"    tarefa     TEXT    NOT NULL\n" + 
					"                       DEFAULT \"\",\n" + 
					"    valor      DOUBLE  NOT NULL\n" + 
					"                       DEFAULT \"\",\n" + 
					"    disciplina TEXT    REFERENCES disciplinas (disciplina) \n" + 
					"                       NOT NULL\n" + 
					"                       DEFAULT \"\"\n" + 
					"                       UNIQUE,\n" + 
					"    nota       DOUBLE  NOT NULL\n" + 
					"                       DEFAULT \"\",\n" + 
					"    entrega    INTEGER NOT NULL\n" + 
					"                       DEFAULT \"\"\n" + 
					"); ";

          await db.execute(createTableDisciplinas);
          await db.execute(createTableTarefas);
        } 
    );
     }
   return database;
  }
  
}