import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'herramientas.dart';
import 'genero.dart';
import 'edad.dart';
import 'universidades.dart';
import 'clima.dart';
import 'web.dart';
import 'acercade.dart';

void main() {
  runApp(Tarea6());
}

class Tarea6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Herramientas(),
    Genero(),
    Edad(),
    Universidades(),
    Clima(),
    WEB(),
    AcercaDe(),
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
        title: Center(child: Text('Tarea 6', style: TextStyle(color: Colors.white))),
        backgroundColor: Color.fromARGB(255, 123, 3, 132),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.toolbox),
            label: 'Herramientas',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userFriends),
            label: 'Genero',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Edad',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.university),
            label: 'Universidades',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cloud),
            label: 'Clima',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.laptop),
            label: 'WEB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Acerca de',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 123, 3, 132),
        unselectedItemColor: Color.fromARGB(255, 123, 3, 132),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
