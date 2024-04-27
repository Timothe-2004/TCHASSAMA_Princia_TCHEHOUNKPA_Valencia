import 'package:flutter/material.dart';
import 'package:controlelection/listecandidats.dart';
import 'package:controlelection/formulaire.dart';
import 'package:controlelection/Candidats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Election',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Candidats(),
    );
  }
}
