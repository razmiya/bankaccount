import 'package:flutter/material.dart';

import 'bankinghomepage.dart';

void main() {
  runApp(BankingApp());
}

class BankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankingHomePage(),
    );
  }
}
