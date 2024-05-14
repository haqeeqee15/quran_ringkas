import 'package:flutter/material.dart';

class TnC extends StatelessWidget {
  const TnC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Our Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla posuere efficitur ex a ornare. Integer scelerisque, risus id condimentum tempus, nibh ipsum suscipit urna, vel vulputate ligula lacus vel ipsum. Sed eget leo nunc. ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.0),
            Text(
              'Information Collection and Use',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla posuere efficitur ex a ornare. Integer scelerisque, risus id condimentum tempus, nibh ipsum suscipit urna, vel vulputate ligula lacus vel ipsum. Sed eget leo nunc. ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.0),
            // Add more sections as needed...
          ],
        ),
      ),
    );
  }
}
