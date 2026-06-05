import 'package:chatbot/data/service/chat_api_service.dart';
import 'package:chatbot/presentation/provider/chat_provider.dart';
import 'package:chatbot/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ChatApiService apiService = ChatApiService();
    return ChangeNotifierProvider(
      create: (context)=>ChatProvider(apiService: apiService),
      child: MaterialApp(
        title: 'ChatBot',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

