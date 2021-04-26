import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Launch extends StatefulWidget {
  @override
  _LaunchState createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _verifyToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  void _verifyToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = prefs.getString('deviceId');
    if (uuid == null) {
      uuid = Uuid().v1();
      prefs.setString('deviceId', uuid);
    }
    if (prefs.getString('token') == null) {}
  }
}
