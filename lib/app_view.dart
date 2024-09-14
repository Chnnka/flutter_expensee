import 'package:flutter/material.dart';
import 'package:flutter_expensee/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExpenSee',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: const Color.fromARGB(255, 4, 143, 62),
          secondary: const Color.fromARGB(255, 24, 169, 169),
          tertiary: const Color.fromARGB(255, 68, 201, 157),
          outline: Colors.grey.shade400,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
