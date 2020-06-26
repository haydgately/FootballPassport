import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:footballpassport/blocs/football_passport_delegate.dart';
import 'package:footballpassport/blocs/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballpassport/screens/home_screen.dart';

void main() {
  BlocSupervisor.delegate = FootballPassportDelegate();

  runApp(FootballPassportApp());
}

String query = r'''
 query {
  visits {
    groundName
    homeTeam
  }
}
''';

class FootballPassportApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Passport',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc()..add(FetchHomeData(query)),
        child: HomeScreen(),
      ),
    );
  }
}
