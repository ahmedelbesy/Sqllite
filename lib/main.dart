import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hamada/layout/home_layout.dart';
import 'package:hamada/shared/bloc_observer.dart';

import 'modules/counter/counter.dart';
import 'modules/home/home_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:HomeLayout(),
    );
  }
}

