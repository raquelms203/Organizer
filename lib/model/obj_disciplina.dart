class Disciplina {
  String _disciplina;
  String _cod;
  String _periodo;

  int _id;
  int _faltas;
  double _nota;

  Disciplina(this._disciplina, this._cod, this._faltas,
     this._periodo, this._nota,);

  String getDisciplina() {
    return this._disciplina;
  }

  String getCod() {
    return this._cod;
  }

  int getFaltas() {
    return this._faltas;
  }

  String getPeriodo() {
    return this._periodo;
  }

  double getNota() {
    return this._nota;
  }

  int getId() {
    return this._id;
  }

  void setDisciplina(String disciplina) {
    this._disciplina = disciplina;
  }

  void setCod(String cod) {
    this._cod = cod;
  }

  void setFaltas(int faltas) {
    this._faltas = faltas;
  }

  void setPeriodo(String periodo) {
    this._periodo = periodo;
  }

  void setNota(double nota) {
    this._nota = nota;
  }

  void setId(int id) {
    this._id = id;
  }

  //converte Disciplina em Map
  Map<String, dynamic> disciplinaToMap() {
    var map = Map<String, dynamic>();

    if (getId() != null) map['id'] = _id;

    map['disciplina'] = _disciplina;
    map['cod'] = _cod;
    map['periodo'] = _periodo;
    map['faltas'] = 0;
    map['nota'] = _nota;

    return map;
  }

  //converte Map em Disciplina
  Disciplina.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._disciplina = map['disciplina'];
    this._cod = map['cod'];
    this._periodo = map['periodo'];
    this._faltas = map['faltas'];
    this._nota = map['nota'];
  }
}
