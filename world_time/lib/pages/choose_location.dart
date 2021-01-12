import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  void getData() async {
    String username = await Future.delayed(Duration(seconds: 3), () {
      return 'yoshi';
    });

    //simulación de petición para obtener el nombre del usuario
    String bio = await Future.delayed(Duration(seconds: 2), () {
      return 'vega, musician & egg collector';
    });

    print('$username - $bio');
  }

  @override
  void initState() {
    super.initState();
    getData();

    print('hey there!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Escoger una Locación'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
