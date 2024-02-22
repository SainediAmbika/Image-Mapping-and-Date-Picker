import 'package:flutter/material.dart';
import 'package:imagemapping/datepicker.dart';
import 'package:imagemapping/imageMapping.dart';
import 'package:imagemapping/practice1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Mapping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: imageMapping(),
    );
  }
}
