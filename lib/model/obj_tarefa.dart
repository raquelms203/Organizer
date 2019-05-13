class Tarefa {

  String _descricao;
  String _disciplina;
  String _tipo;

  double _valor;
  double _nota;

  DateTime _data;

  int _id;
  int _prioridade;

  Tarefa(this._disciplina, this._descricao, this._tipo, this._valor, this._nota, this._data, this._prioridade);
  Tarefa.comId(this._disciplina, this._descricao, this._tipo, this._valor, this._nota, this._data, this._prioridade, _id);

  String getDescricao() => this._descricao;
  String getDisciplina() => this._disciplina;
  String getTipo() => this._tipo;
  double getValor() => this._valor;
  double getNota() => this._nota;
  int getId() => this._id;
  DateTime getData() => this._data;
  int getPrioridade() => this._prioridade;

  void setDescricao(String descricao) => this._descricao = descricao;
  void setDisciplina(String disciplina) => this._disciplina = disciplina;
  void setTipo(String tipo) => this._tipo = tipo;
  void setValor(double valor) => this._valor = valor;
  void setNota(double nota) => this._nota = nota;
  void setId(int id) => this._id = id;
  void setData(DateTime data) => this._data = data;
  void setPrioridade(int prioridade) => this._prioridade = prioridade;

  //converte Tarefa em Map
  Map<String, dynamic> tarefaToMap() {
    var map = Map<String, dynamic>();

    if (getId() != null) map['id'] = _id;

    map['descricao'] = _descricao;
    map['disciplina'] = _disciplina;
    map['tipo'] = _tipo;
    map['valor'] = _valor;
    map['nota'] = _nota;
    map['entrega'] = _data;
    map['prioridade'] = _prioridade;

    return map;
  }

  //converte Map em Tarefa
  Tarefa.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._descricao = map['descricao'];
    this._disciplina = map['disciplina'];
    this._tipo = map['tipo'];
    this._valor = map['valor'];
    this._nota = map['nota'];
    this._data = map['entrega'];
    this._prioridade = map['prioridade'];
  }

}
