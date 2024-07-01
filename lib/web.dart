import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class WEB extends StatefulWidget {
  @override
  _WEBState createState() => _WEBState();
}

class _WEBState extends State<WEB> {
  late List<dynamic> _newsList;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://www.ejercito.mil.do/wp-json/wp/v2/posts?per_page=3&_embed'));

    if (response.statusCode == 200) {
      setState(() {
        _newsList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias del Ejercito Nacional de Republica Dominicana'),
      ),
      body: Center(
        child: _newsList != null
            ? ListView.builder(
                itemCount: _newsList.length,
                itemBuilder: (context, index) {
                  var news = _newsList[index];
                  var featuredMedia = news['_embedded']['wp:featuredmedia'][0];
                  var imageUrl = featuredMedia['source_url'];
                  var title = news['title']['rendered'];
                  var summary = news['excerpt']['rendered'];
                  var originalLink = news['link'];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                          imageUrl,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          _stripHtmlTags(summary),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _launchURL(originalLink);
                          },
                          child: Text('Visitar'),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  String _stripHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
