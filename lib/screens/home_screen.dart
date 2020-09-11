import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballpassport/blocs/home/home.dart';
import 'package:footballpassport/blocs/provider/repository.dart';
import 'package:footballpassport/main.dart';
import 'package:footballpassport/blocs/models/ground.dart';
import 'package:footballpassport/blocs/provider/repository.dart';
import 'package:footballpassport/screens/grounds_widget.dart';

class HomeScreen extends StatefulWidget {
  final GroundRepository groundRepository;
  HomeScreen({this.groundRepository});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc(groundRepository: widget.groundRepository);
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Football Passport'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => homeBloc,
      child: Scaffold(
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Grounds',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: GroundsWidget(),
      ),
    );
  }
}
