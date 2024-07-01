import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Genero extends StatefulWidget {
  @override
  _GeneroState createState() => _GeneroState();
}

class _GeneroState extends State<Genero> {
  final TextEditingController _controller = TextEditingController();
  String _gender = '';

  Future<void> _predictGender(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _gender = data['gender'];
      });
    } else {
      setState(() {
        _gender = 'error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predecir el género mediante tu nombre'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Ingrese el nombre:',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _predictGender(_controller.text);
              },
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 20),
            if (_gender == 'male')
              Image.asset('assets/multimedia/globoazul.jpg', height: 300)
            else if (_gender == 'female')
              Image.asset('assets/multimedia/globorosa.jpg', height: 350)
            else if (_gender == 'error')
              Text('Error al predecir género'),
          ],
        ),
      ),
    );
  }
}
