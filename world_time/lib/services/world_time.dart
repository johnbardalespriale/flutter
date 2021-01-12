import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response = await get('http://worldclockapi.com/api/json/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      String currentDateTime = data['currentDateTime'];
      String utcOffset = data['utcOffset'].substring(1, 3);
      //print(timeZoneName);
      //print(utcOffset);

      //create the datetime object
      DateTime now = DateTime.parse(currentDateTime);
      now.add(Duration(hours: int.parse(utcOffset)));

      isDaytime = now.hour > 6 && now.hour < 15 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caugth error: $e');
      time = 'no pudo obtener la data';
    }
  }
}
