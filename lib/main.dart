import 'package:flutter/material.dart';
import 'package:footballpassport/screens/home_screen.dart';
import 'services/graphql_service.dart';
import 'package:footballpassport/blocs/provider/repository.dart';

GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

void main() {
  GroundRepository groundRepository = GroundRepository();
  runApp(FootballPassportApp(groundRepository: groundRepository));
}

class FootballPassportApp extends StatelessWidget {
  // This widget is the root of your application.
  final GroundRepository groundRepository;
  FootballPassportApp({this.groundRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Passport',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(groundRepository: groundRepository),
    );
  }
}
