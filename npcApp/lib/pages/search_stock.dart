import 'package:crudfirebase/modelos/existente.model.dart';
import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/peticiones/existente.peticion.dart';
import 'package:flutter/material.dart';

import '../modelos/historial.model.dart';
import '../peticiones/historial.peticion.dart';

class SearchExistentes extends SearchDelegate {
  final List<Existentes> productos;
  List<Existentes> _filter = [];

  SearchExistentes(this.productos);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, listExist());
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _filter = productos.where((element) {
      return element.nombre.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/box.png')),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        _filter[index].code,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Text('Cliente'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        _filter[index].nombre,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        _filter[index].total,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text(
                    _filter[index].grupo,
                  ),
                ],
              ));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = productos.where((element) {
      
      return element.nombre.toLowerCase().contains(query.trim().toLowerCase());
    }).toList();
    
    return ListView.builder(
        itemCount: _filter.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/box.png')),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        _filter[index].code,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  const Text('Cliente'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        _filter[index].nombre,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        _filter[index].total,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text(
                    _filter[index].grupo
                  ),
                ],
              ));
        });
  }
}
