import 'package:flutter/material.dart';
import 'package:movieapp/carousel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Carousel(),
    );
  }
}
