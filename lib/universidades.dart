import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Universidades extends StatefulWidget {
  @override
  _UniversidadesState createState() => _UniversidadesState();
}

class _UniversidadesState extends State<Universidades> {
  String _country = '';
  List _universities = [];
  String _errorMessage = '';

  Future<void> _getUniversities(String country) async {
    final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$country'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isEmpty) {
        setState(() {
          _universities = [];
          _errorMessage = 'No se encontraron universidades para este país';
        });
      } else {
        setState(() {
          _universities = data;
          _errorMessage = '';
        });
      }
    } else {
      setState(() {
        _universities = [];
        _errorMessage = 'Failed to load universities';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda de Universidades mediante el país'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _country = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Ingrese el nombre del país en inglés:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getUniversities(_country);
              },
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            if (_universities.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _universities.length,
                  itemBuilder: (context, index) {
                    final university = _universities[index];
                    return ListTile(
                      title: Text(university['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dominio: ${university['domains'].join(', ')}'),
                          InkWell(
                            onTap: () {
                              final url = university['web_pages'].first;
                              if (url != null) {
                                launchURL(url);
                              }
                            },
                            child: Text(
                              university['web_pages'].first,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
