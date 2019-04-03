import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Adicionar Disciplina",
    home: FormDisciplina(),
  ));
}

class FormDisciplina extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FormDisciplina();
  }
}

class _FormDisciplina extends State<FormDisciplina> {
  String dropdownDefault = "Período";
  String dropdownDefault2 = "Máx. Faltas";
  String dropdownDefault3 = "Status";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Disciplina"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Ex. Cálculo III',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                width: 300.0,
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Código',
                      hintText: 'Ex. CEA 006',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                        width: 80.0,
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Meta',
                              hintText: 'Ex. 60 pts',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: DropdownButton<String>(
                      hint: Text(dropdownDefault,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      onChanged: (String novoValor) {
                        setState(() {
                          dropdownDefault = novoValor;
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: DropdownButton<String>(
                      hint: Text(dropdownDefault2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      onChanged: (String novoValor) {
                        setState(() {
                          dropdownDefault2 = novoValor;
                        });
                      },
                      items: ['9 Faltas', '18 Faltas']
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
                  Padding(
                    padding: EdgeInsets.only(right: 15.0, left: 42.0),
                    child: DropdownButton<String>(
                      hint: Text(dropdownDefault3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      onChanged: (String novoValor) {
                        setState(() {
                          dropdownDefault3 = novoValor;
                        });
                      },
                      items: ['Cursando', 'Encerrada']
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> periodos() {
    List<String> periodos = [""];
    int i;
    for (i = 1; i <= 10; i++) periodos.add("$iº P");

    periodos.add("Eletiva");
    return periodos;
  }
}
