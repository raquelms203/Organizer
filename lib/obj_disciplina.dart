class Disciplina {
  String _disciplina = "";
  String _cod = "";
  int _limFaltas = 0;
  String _periodo = "";
  double _meta = 0.0;
  int _id;
  int _faltas = 0;

  bool _status = false;

  String getDisciplina() {
    return this._disciplina;
  }

  String getCod() {
    return this._cod;
  }

  int getLimFaltas() {
    return this._limFaltas;
  }

  bool getStatus() {
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

  void setDisciplina(String disciplina) {
    this._disciplina = disciplina;
  }

  void setCod(String cod) {
    this._cod = cod;
  }

  void setLimFaltas(int limFaltas) {
    this._limFaltas = limFaltas;
  }

  void setStatus(bool status) {
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
}
