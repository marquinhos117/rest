import 'package:flutter/material.dart';
import 'package:lista_loja/screens/login_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      title: "Aula Flutter REST",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}
