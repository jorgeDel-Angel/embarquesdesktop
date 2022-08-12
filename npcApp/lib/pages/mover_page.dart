import 'package:crudfirebase/modelos/producto.model.dart';
import 'package:crudfirebase/pages/search_product.dart';

import 'package:crudfirebase/peticiones/producto.peticion.dart';
import 'package:flutter/material.dart';

class MoverPage extends StatefulWidget {
  final String _title;
  MoverPage(this._title);
  @override
  State<StatefulWidget> createState() => _MoverPage();
}

class _MoverPage extends State<MoverPage> {
//

//

  var code;
  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        //scanBarcodeNormal(index);
      }
      if (index == 1) {
        // scanBarcodeNormal(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 31, 52, 240),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              List<Productos> _h = <Productos>[];
              List<Productos> h = <Productos>[];
              listProduct().then((value) {
                _h.addAll(value);
              });
              // _h.removeWhere((element) => element.state != 'entrada');
              showSearch(context: context, delegate: SearchProduct(_h));
            },
          )
        ],
        title: Text(
          widget._title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: getProducts(context, listProduct()),
      /*        bottomNavigationBar: BottomNavigationBar(
            //  unselectedItemColor: Colors.red,
            // selectedIconTheme: const IconThemeData(color: Colors.red),
            // selectedItemColor: Colors.red,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner_sharp),
                label: 'Agregar prodcuto',
              ),
              BottomNavigationBarItem(
                //nselectedItemColor: Colors.deepOrangeAccent,
                icon: Icon(
                  Icons.edit_note,
                ),

                label: 'Editar Producto',
              ),
            ], onTap: _onItemTapped) */
    );
  }

  Widget getProducts(
      BuildContext context, Future<List<Productos>> futureProducts) {
    return FutureBuilder(
      future: futureProducts,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el cargando...
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            if (snapshot.hasError) {
              return Container(
                alignment: Alignment.center,
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }
            // print(snapshot.data);
            return snapshot.data != null
                ? productsList(snapshot.data)
                : Container(
                    alignment: Alignment.center,
                    child: const Center(
                      child: Text('Sin Datos'),
                    ),
                  );
          default:
            return const Text('Recarga la pantalla....!');
        }
      },
    );
  }

  Widget productsList(List<Productos> Products) {
    return ListView.builder(
      itemCount: Products.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/box.png')),
            onLongPress: () {
              // removeClient(context, pHistorials[index]);
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      Products[index].code,
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                const Text('Estado'),
              ],
            ),

            // title: Text(Products[index].nombre+ " " + Products[index].code),
            // subtitle: Text(Products[index].total),

//
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      Products[index].name,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      Products[index].amount,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Text(
                  Products[index].position,
                ),
              ],
            ));
//
      },
    );
  }
}
