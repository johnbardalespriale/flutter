import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class Iframe extends StatefulWidget {
  @override
  _IframeState createState() => _IframeState();
}

class _IframeState extends State<Iframe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Canales'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ImageButton(
            children: <Widget>[],
            width: 96,
            height: 90,
            paddingTop: 5,
            pressedImage: Image.asset(
              "assets/Univision.png",
            ),
            unpressedImage: Image.asset("assets/Univision.png"),
            onTap: () {
              Navigator.pushNamed(context, '/video', arguments: {});
            },
          ),
        ),
      ),
    );
  }
}
