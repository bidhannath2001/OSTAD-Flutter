import 'package:counter/app.dart';
import 'package:counter/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CounterProvider(), child: MyApp()),
  );
}
