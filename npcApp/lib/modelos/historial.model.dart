class pHistorial {
  var id;
  var amount;
  var client;
  var code;
  var state;
  var date;
  var name;
  var position;

  pHistorial({
      this.id,
      this.amount,
      this.client,
      this.code,
      this.state,
      this.date,
      this.name,
      this.position});

  factory pHistorial.fromJson(Map<String, dynamic> json) {
    return pHistorial(
        id: json['_id'],
        amount: json['cantidad'],
        client: json['cliente'],
        code: json['code'],
        state: json['estado'],
        date: json['fecha'],
        name: json['nombre'],
        position: json['posicion']);
  }
}
