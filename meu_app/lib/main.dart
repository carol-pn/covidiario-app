import 'package:flutter/material.dart';
import 'package:meu_app/telas/home.dart';
import 'package:meu_app/telas/task.dart';
import 'package:meu_app/widgets/datetime_picker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}