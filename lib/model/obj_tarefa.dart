class Tarefa {

  String _descricao;
  String _disciplina;
  String _tipo;

  double _valor;
  double _nota;

  int _id;
  int _entrega;
  int _prioridade;
  int _status;

  Tarefa(this._disciplina, this._descricao, this._tipo, this._valor, this._nota, this._entrega, this._prioridade);
  Tarefa.comId(this._disciplina, this._descricao, this._tipo, this._valor, this._nota, this._entrega, this._prioridade, this._id);

  String getDescricao() => this._descricao;
  String getDisciplina() => this._disciplina;
  String getTipo() => this._tipo;
  double getValor() => this._valor;
  double getNota() => this._nota;
  int getId() => this._id;
  int getEntrega() => this._entrega;
  int getPrioridade() => this._prioridade;
  int getStatus() => this._status;

  void setDescricao(String descricao) => this._descricao = descricao;
  void setDisciplina(String disciplina) => this._disciplina = disciplina;
  void setTipo(String tipo) => this._tipo = tipo;
  void setValor(double valor) => this._valor = valor;
  void setNota(double nota) => this._nota = nota;
  void setId(int id) => this._id = id;
  void setEntrega(int entrega) => this._entrega = entrega;
  void setPrioridade(int prioridade) => this._prioridade = prioridade;
  void setStatus(int status) => this._status;

  //converte Tarefa em Map
  Map<String, dynamic> tarefaToMap() {
    var map = Map<String, dynamic>();

    if (getId() != null) map['id'] = _id;

    map['descricao'] = _descricao;
    map['disciplina'] = _disciplina;
    map['tipo'] = _tipo;
    map['valor'] = _valor;
    map['nota'] = _nota;
    map['entrega'] = _entrega;
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
    this._entrega = map['entrega'];
    this._prioridade = map['prioridade'];
  }

}
