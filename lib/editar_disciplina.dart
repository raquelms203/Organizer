// import 'package:flutter/material.dart';
// import './obj_disciplina.dart';

// class EditarDisciplina extends StatefulWidget  {

//   @override
//   State<StatefulWidget> createState() {
//     return new _EditarDisciplina();
//   }
// }

// class _EditarDisciplina extends State<EditarDisciplina> {
//   Widget build(BuildContext context) {

//     return new Scaffold( 
//       appBar: AppBar(
//         title: Text("Adicionar Disciplina"),
//         backgroundColor: Colors.purple[300],
//       ),
//       body: Builder(builder: (BuildContext context) {
//         return Form(
//           child: ListView(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Container(
//                   margin: EdgeInsets.only(top: 30.0),
//                   width: 300.0,
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Campo vazio!';
//                       }
//                       _disciplina = value;
//                     },
//                     decoration: InputDecoration(
//                         labelText: 'Nome',
//                         hintText: 'Ex. Cálculo III',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0))),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
//                 child: Container(
//                   width: 300.0,
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Campo vazio!';
//                       }
//                       _cod = value;
//                     },
//                     decoration: InputDecoration(
//                         labelText: 'Código',
//                         hintText: 'Ex. CEA 006',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5.0))),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(
//                     top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Padding(
//                         padding:
//                             EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0),
//                         child: Container(
//                           width: 75.0,
//                           child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             validator: (value) {
//                               if (value.isEmpty) return 'Campo vazio!';

//                               if (double.parse("$value") < 60.0)
//                                 return 'Meta menor que 60.0!';

//                               if (double.parse("$value") > 100.0)
//                                 return 'Meta maior que 100.0!';

//                               _meta = double.parse(value);
//                             },
//                             decoration: InputDecoration(
//                                 labelText: 'Meta',
//                                 hintText: 'Ex. 60 pts',
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(5.0))),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           top: 5.0, bottom: 5.0, left: 15.0, right: 15.0),
//                       child: DropdownButton<String>(
//                         hint: Text(dropdownDefault,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20.0)),
//                         onChanged: (String novoValor) {
//                           setState(() {
//                             dropdownDefault = novoValor;  
//                             _periodo = novoValor;                                        
//                           });
//                         },
//                         items: periodos()
//                             .map<DropdownMenuItem<String>>((String valor) {
//                           return DropdownMenuItem<String>(
//                               value: valor,
//                               child: Text(
//                                 valor,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ));
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 15.0, right: 15.0),
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       width: 150.0,
//                       height: 50.0,
//                       padding:
//                           EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0),
//                       child: DropdownButton<String>(
//                         hint: Text(dropdownDefault2,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20.0)),
//                         onChanged: (String novoValor) {
//                           setState(() {
//                             dropdownDefault2 = novoValor;
//                             _limFaltas = int.parse(dropdownDefault2[0]+dropdownDefault2[1]);
//                             print(_limFaltas);
//                           });
//                         },
//                         items: ['9 Faltas', '18 Faltas']
//                             .map<DropdownMenuItem<String>>((String valor) {
//                           return DropdownMenuItem<String>(
//                               value: valor,
//                               child: Text(
//                                 valor,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ));
//                         }).toList(),
//                       ),
//                     ),
//                     Container(
//                       width: 120.0,
//                       height: 50.0,
//                       padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
//                       margin: EdgeInsets.only(right: 10.0, left: 45.0),
//                       child: DropdownButton<String>(
//                         hint: Text(dropdownDefault3,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20.0)),
//                         onChanged: (String novoValor) {
//                           setState(() {
//                             dropdownDefault3 = novoValor;
//                             if (novoValor == "Cursando")
//                               _status = true;
//                             else if (novoValor == "Encerrada")
//                               _status = false;
//                           });
//                         },
//                         items: ['Cursando', 'Encerrada']
//                             .map<DropdownMenuItem<String>>((String valor) {
//                           return DropdownMenuItem<String>(
//                               value: valor,
//                               child: Text(
//                                 valor,
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ));
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.only(top: 20.0),
//                 child: RaisedButton(
//                     padding: EdgeInsets.only(
//                         top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
//                     color: Colors.green[500],
//                     child: Text("Salvar",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         )),
//                     onPressed: () {
//                       if (_formKey.currentState.validate()) {
//                         String discp = _disciplina;

//                         print("Disciplina adicionada!");
//                         print("$discp ");

//                         Disciplina disciplina = new Disciplina();

//                         disciplina.setDisciplina(_disciplina);
//                         disciplina.setCod(_cod);
//                         disciplina.setFaltas(0);
//                         disciplina.setLimFaltas(_limFaltas);
//                         disciplina.setMeta(_meta);
//                         disciplina.setPeriodo(_periodo);
//                         disciplina.setStatus(_status);

//                         Container cont = ListaDisciplinas(lista: widget.lista)
//                             .cardDisciplina(disciplina);
//                         widget.lista.add(cont);

//                         Navigator.pop(context);
//                       }
//                     }),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }