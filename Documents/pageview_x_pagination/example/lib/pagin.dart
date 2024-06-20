import 'package:flutter/material.dart';
import 'package:pageview_x_pagination/pagin.dart';
// import '';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Pagin(),
      ),
    );
  }
}
