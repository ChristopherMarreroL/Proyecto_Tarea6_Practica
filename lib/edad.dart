import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Edad extends StatefulWidget {
  @override
  _EdadState createState() => _EdadState();
}

class _EdadState extends State<Edad> {
  String _name = '';
  int _age = 0;
  String _errorMessage = '';

  Future<void> _getAge(String name) async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['age'] == null) {
        setState(() {
          _age = 0;
          _errorMessage = 'Este nombre no lo tengo guardado.';
        });
      } else {
        setState(() {
          _age = data['age'];
          _errorMessage = '';
        });
      }
    } else {
      setState(() {
        _age = 0;
        _errorMessage = 'Failed to load age';
      });
    }
  }

  String _getAgeCategory(int age) {
    if (age < 18) {
      return 'joven';
    } else if (age >= 18 && age < 60) {
      return 'adulto';
    } else {
      return 'anciano';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Determinar la edad mediante tu nombre'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Ingrese un nombre:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getAge(_name);
              },
              child: Text('Determinar Edad'),
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              )
            else if (_age != 0)
              Column(
                children: <Widget>[
                  Text(
                    'Edad: $_age años',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    _getAgeCategory(_age) == 'joven'
                        ? 'assets/multimedia/joven.jpg'
                        : _getAgeCategory(_age) == 'adulto'
                            ? 'assets/multimedia/adulto.jpg'
                            : 'assets/multimedia/anciano.jpeg',
                    height: 150,
                  ),
                  SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}