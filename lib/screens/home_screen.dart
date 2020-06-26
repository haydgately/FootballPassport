import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballpassport/blocs/home/home.dart';
import 'package:footballpassport/main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];

  int _counter = 0;

  void _incrementCounter() {
    String query = r'''
 query {
  visits {
    groundName
    homeTeam
  }
}
''';
//    data = (state as LoadDataSuccess).data['visits'];
//    HomeBloc()..add(FetchHomeData(query));

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
//      FetchHomeData(query);
      print('FAB pressed');
    });
  }

  @override
  void initState() {
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Football Passport'),
    );
  }

  @override
  Widget build(BuildContext context) {

    String query = r'''
 query {
  visits {
    groundName
    homeTeam
  }
}
''';

    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: LinearProgressIndicator(),
          );
        } else if (state is LoadDataFail) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(child: Text(state.error)),
          );
        } else {
          data = (state as LoadDataSuccess).data['visits'];
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                setState(() {
                  HomeBloc()..add(FetchHomeData(query));
                  data = (state as LoadDataSuccess).data['visits'];
                });
              },
              tooltip: 'Refresh Grounds',
              child: Icon(Icons.refresh),
            ),
          );
        }
      },
    );
  }

  Widget _buildBody() {
    return Container(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          var item = data[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              //leading: Text(item['id']),
              title: Text(
                  item['groundName'],
                   style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item['homeTeam'],
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
