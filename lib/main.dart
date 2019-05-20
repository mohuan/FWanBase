import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanbase/page/welcome.dart';

void main() => SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then(  (_) {
  runApp(new WelcomePage());
});




