class Productos {
  var id;
  var name;
  var code;
  var amount;
  var position;
  var date;
  var client;

  Productos({
    this.id,
    this.name,
    this.code,
    this.amount,
    this.position,
    this.date,
    this.client,
  });

  factory Productos.fromJson(Map<String, dynamic> json) {
    return Productos(
        id: json['_id'],
        name: json['nombre'],
        code: json['code'],
        amount: json['cantidad'],
        position: json['posicion'],
        date: json['fecha'],
        client: json['cliente']);
  }
}
