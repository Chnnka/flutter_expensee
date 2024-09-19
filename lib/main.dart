import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expensee/simple_bloc_observer.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "AIzaSyBzdXVQk6YjTNtG8GSnxrSwmsh8C0wmsXE",
      //   appId: '1:367802688422:android:65f8beb1bca9dbe8c2e567',
      //   messagingSenderId: 'sendid',
      //   projectId: 'flutter-expensee',
      //   storageBucket: "flutter-expensee.appspot.com",
      // ),
      );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
