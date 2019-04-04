import 'package:flutter/material.dart';
import './disciplina.dart';

void main() {
  runApp(MaterialApp(
    title: "Organizer",
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
  String dropdownDefault3 = "  Status  ";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Disciplina"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                margin: EdgeInsets.only(top: 30.0),
                width: 300.0,
                child: TextFormField(
                  
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo vazio!';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Ex. Cálculo III',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
              child: Container(
                width: 300.0,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Campo vazio!';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Código',
                      hintText: 'Ex. CEA 006',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0),
                      child: Container(
                        width: 75.0,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Campo vazio!';
                            }
                          },
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
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 150.0,
                    height: 50.0,
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
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
                  Container(
                    width: 120.0,
                    height: 50.0,
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    margin: EdgeInsets.only(right: 10.0, left: 45.0),
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
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                padding: EdgeInsets.only(top: 15.0, bottom:15.0, left: 10.0, right:10.0),
                
                color: Colors.green[500],
                child: Text("Salvar",
                    style: TextStyle(
                        color: Colors.white,
                      
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Disciplina disc = new Disciplina();
                //    disc.
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Disciplina adicionada com sucesso!")));
                  }
                },
              ),
            )
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
