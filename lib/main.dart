import 'package:eshop/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Color(0xFF4FC9C9),
          focusColor: Colors.black,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black87,
          accentColor: Color(0xFF4FC9C9),
          focusColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
