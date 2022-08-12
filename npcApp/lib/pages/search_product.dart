import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/peticiones/producto.peticion.dart';
import 'package:flutter/material.dart';

import '../modelos/historial.model.dart';
import '../peticiones/historial.peticion.dart';

class SearchProduct extends SearchDelegate {
  final List<Productos> productos;
  List<Productos> _filter = [];

  SearchProduct(this.productos);

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
        close(context, listProduct());
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _filter = productos.where((element) {
      return element.name.toLowerCase().contains(query.trim().toLowerCase());
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
                  const Text('Estado'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        _filter[index].name,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        _filter[index].amount,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text(
                    _filter[index].position,
                  ),
                ],
              ));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filter = productos.where((element) {
      
      return element.name.toLowerCase().contains(query.trim().toLowerCase());
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
                  const Text('Estado'),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        _filter[index].name,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        _filter[index].amount,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Text(
                    _filter[index].position,
                  ),
                ],
              ));
        });
  }
}
