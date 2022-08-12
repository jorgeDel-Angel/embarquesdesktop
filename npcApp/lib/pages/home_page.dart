// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

import 'entrada_page.dart';
import 'mover_page.dart';
import 'salida_page.dart';
import 'stock_page.dart';

class HomePage extends StatefulWidget {



  const HomePage({Key? key}) : super(key: key);

  static const nombrePagina = "Home page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void Dispose(){
    
  }
  String txt = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: pantalla(),
    );
  }
}

// ignore: camel_case_types
class pantalla extends StatefulWidget {
  const pantalla({Key? key}) : super(key: key);

  @override
  State<pantalla> createState() => _pantallaState();
}

// ignore: camel_case_types
class _pantallaState extends State<pantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(26),
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                alignment: Alignment.center,
                child: Image.asset('assets/npc_embarques.png', width: 200),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: RaisedButton(
                  //padding: const EdgeInsets.all(20),
                  color: Color.fromARGB(255, 31, 52, 240),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return EntradaPage("Entrada de Productos");
                    }));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Text(
                    'Registro Producto',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: FlatButton(
                 // padding: const EdgeInsets.all(20),
                  color: Color.fromARGB(255, 31, 52, 240),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return MoverPage("Mover Productos");
                      },
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Text(
                    'Mover Producto',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: RaisedButton(
               //   padding: const EdgeInsets.all(20),
                  color: Color.fromARGB(255, 31, 52, 240),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return SalidaPage("Embarque de Productos");
                      },
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Text(
                    'Embarque',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: RaisedButton(
                //  padding: const EdgeInsets.all(20),
                  color: Color.fromARGB(255, 31, 52, 240),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return StockPage("Productos en Stock");
                      },
                    ));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Text(
                    'Stock',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
