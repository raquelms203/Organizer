class Disciplina {
  String _disciplina;
  String _cod;
  String _periodo;

  int _status;
  int _id;
  int _limFaltas;
  int _faltas;
  double _meta;
  double _nota;

  Disciplina(this._disciplina, this._cod, this._faltas, this._limFaltas,
      this._meta, this._periodo,this._nota, this._status);


  String getDisciplina() {
    return this._disciplina;
  }

  String getCod() {
    return this._cod;
  }

  int getLimFaltas() {
    return this._limFaltas;
  }

  int getStatus() {
    return this._status;
  }

  int getFaltas() {
    return this._faltas;
  }

  String getPeriodo() {
    return this._periodo;
  }

  double getMeta() {
    return this._meta;
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

  void setLimFaltas(int limFaltas) {
    this._limFaltas = limFaltas;
  }

  void setStatus(int status) {
    this._status = status;
  }

  void setFaltas(int faltas) {
    this._faltas = faltas;
  }

  void setPeriodo(String periodo) {
    this._periodo = periodo;
  }

  void setMeta(double meta) {
    this._meta = meta;
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
    map['meta'] = _meta;
    map['periodo'] = _periodo;
    map['lim_faltas'] = _limFaltas;
    map['status'] = _status;
    map['faltas'] = 0;
    map['nota'] = _nota;

    return map;
  }

  //converte Map em Disciplina
  Disciplina.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._disciplina = map['disciplina'];
    this._cod = map['cod'];
    this._meta = map['meta'];
    this._periodo = map['periodo'];
    this._limFaltas = map['lim_faltas'];
    this._status = map['status'];
    this._faltas = map['faltas'];
    this._nota = map['nota'];
  }
}
