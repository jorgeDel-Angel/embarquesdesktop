import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

class HomeController extends StatefulWidget {
  const HomeController({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Tab 0: Home', style: Styles.optionStyle),
    Text('Tab 1: Business', style: Styles.optionStyle),
    Text('Tab 2: School', style: Styles.optionStyle),
  ];

  static const List<BottomNavigationBarItem> _navigationItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[800],
        onTap: _onItemTapped,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}