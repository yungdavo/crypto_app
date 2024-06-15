import 'package:crypto_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'App_Theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.getThemeValue();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CryptoCurrency App',
      theme: ThemeData(
       primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple
        )
      ),
      home: HomeScreen()
    );
  }
}

