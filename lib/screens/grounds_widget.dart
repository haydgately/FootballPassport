import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballpassport/blocs/models/ground.dart';
import 'package:footballpassport/blocs/provider/groundDataProvider.dart';
import 'package:footballpassport/blocs/provider/repository.dart';
import 'package:footballpassport/blocs/home/home.dart';
import 'package:footballpassport/blocs/home/home_bloc.dart';
import 'package:footballpassport/blocs/home/home_events.dart';
import 'package:footballpassport/blocs/home/home_states.dart';


class GroundsWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeEvents.RefreshGrounds);

    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        if (state is HomeUninitializedState) {
          return Text("Unintialized");
        } else if (state is HomeEmptyState) {
          return Text('Empty List');
        } else if (state is HomeErrorState) {
          return Text(' Something went wrong');
        } else if (state is HomeFetchingState) {
          return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
              ));
        } else {
          final stateAsHomeFetchedState = state as HomeFetchedState;
          final grounds = stateAsHomeFetchedState.grounds;
          return buildGroundList(grounds, homeBloc);
        }
      },
    );
  }
  Widget buildGroundList(List<Ground> grounds, HomeBloc homeBloc) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: ListView.builder(
                itemCount: grounds.length,
                itemBuilder: (context, index) {
                  var item = grounds[index];

                  return Card(
                      elevation: 2.0,
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(item.groundName),
                        subtitle: Text(item.homeTeam),
                      )
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            homeBloc.add(HomeEvents.AddGround);
          },
          child: Icon(Icons.refresh),
        ));
  }
}
