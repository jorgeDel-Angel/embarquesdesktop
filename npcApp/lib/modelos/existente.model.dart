class Existentes {
  var id;
  var code;
  var grupo;
  var nombre;
  var total;

  Existentes({
    this.id,
    this.code,
    this.grupo,
    this.nombre,
    this.total,
  });

  factory Existentes.fromJson(Map<String, dynamic> json) {
    return Existentes(
      id: json['_id'],
      code: json['code'],
      grupo: json['grupo'],
      nombre: json['nombre'],
      total: json['total'],
    );
  }
}
