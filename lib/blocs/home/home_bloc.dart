import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footballpassport/blocs/home/home.dart';
import 'package:footballpassport/services/graphql_service.dart';
import 'package:footballpassport/blocs/provider/repository.dart';
import 'package:footballpassport/blocs/models/ground.dart';

enum CounterEvent { increment, decrement }

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  final GroundRepository groundRepository;

  HomeBloc({this.groundRepository})
      : assert(groundRepository != null),
        super();


  @override
  void onTransition(Transition<HomeEvents, HomeStates> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  HomeStates get initialState => HomeUninitializedState();

  Stream<HomeStates> mapEventToState(HomeEvents event) async* {
    yield HomeFetchingState();
    List<Ground> grounds;

    switch (event) {
      case HomeEvents.RefreshGrounds:
        grounds = await groundRepository.getGrounds();
        break;
      case HomeEvents.AddGround:
        await groundRepository.insertGround();
        grounds = await groundRepository.getGrounds();
        break;
    }

    try {
      if (grounds.length == 0) {
        yield HomeEmptyState();
      } else {
        yield HomeFetchedState(grounds: grounds);
      }
    } catch (e) {
      print(e);
      yield HomeErrorState();
    }
  }
}