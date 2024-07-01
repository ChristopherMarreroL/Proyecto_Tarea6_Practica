import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AcercaDe extends StatelessWidget {
  final String linkedinUrl = 'https://www.linkedin.com/in/christopher-marrero-liriano-9168a326b';
  final String email = 'christophermarrero35@gmail.com';

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/multimedia/fotomiacopia.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Christopher E. Marrero L.',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Enlace de LinkedIn clickeable
            GestureDetector(
              onTap: () {
                _launchURL(linkedinUrl);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.link),
                  SizedBox(width: 5),
                  Text(
                    'LinkedIn',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Enlace de correo electrónico clickeable
            GestureDetector(
              onTap: () {
                _launchURL('mailto:$email');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.email),
                  SizedBox(width: 5),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}