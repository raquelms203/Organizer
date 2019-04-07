
class Disciplina {
  String _nome = "";
  String _cod = "";
  double _meta = 0.0;
  // int _id;
  // int _limFaltas = 0;
  // int _faltas = 0;
  // int  _periodo = 0;
  // bool _status = false;  


// Disciplina (this._nome, this._cod, this._meta, this._id, this._limFaltas, this._faltas,
// this._periodo, this._status);

Disciplina (this._nome, this._cod, this._meta);

String get nome => _nome;
String get cod => _cod;
double get meta => _meta;
// int get id => _id;
// int get limFaltas => _limFaltas;
// int get faltas => _faltas;
// int get periodo => _periodo;
// bool get status => _status;

set nome (String texto) {
  this._nome = texto;
}

set cod (String texto) {
  this._cod = texto;
}
set meta (double nr) {
  if (nr >= 60.0)
    this._meta = nr;    
}

// set limFaltas (int nr) {
//   this._limFaltas = nr;
// }

// set faltas (int nr) {
//   this._faltas = nr;
// }

// set periodo (int nr) {
//   this._periodo = nr;
// }

// set status (bool valor) {
//   this.status = valor;
// }



}