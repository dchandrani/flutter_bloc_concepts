import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_concepts/presentation/screens/third_screen.dart';

import 'logic/cubit/counter_cubit.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CounterCubit _counterCubit;

  @override
  void initState() {
    _counterCubit = CounterCubit();
    super.initState();
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => BlocProvider<CounterCubit>.value(
              value: _counterCubit,
              child: HomeScreen(
                title: 'Home Screen',
                color: Colors.blueAccent,
              ),
            ),
        '/second': (context) => BlocProvider<CounterCubit>.value(
          value: _counterCubit,
              child: SecondScreen(
                color: Colors.redAccent,
                title: 'Second Screen',
              ),
            ),
        '/third': (context) => BlocProvider<CounterCubit>.value(
          value: _counterCubit,
              child: ThirdScreen(
                title: 'Third Screen',
                color: Colors.orangeAccent,
              ),
            ),
      },
    );
  }
}
