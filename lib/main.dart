import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/blocObserver.dart';
import 'package:todo/layout/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();

    return MaterialApp(
      home: Home(),
    );
  }
}
