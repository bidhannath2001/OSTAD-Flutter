import 'package:converter/presentation/provider/converter_provider.dart';
import 'package:converter/presentation/screen/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ConverterProvider(),
      child: MaterialApp(
        title: 'Unit Converter',
        theme: ThemeData(
            primaryColor: Colors.blue,),
        home: ConverterScreen(),
      ),
    );
  }
}
