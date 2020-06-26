import 'package:bloc/bloc.dart';

class FootballPassportDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('bloc: $bloc, transition: $transition');
  }
}