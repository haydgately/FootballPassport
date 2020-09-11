import 'package:equatable/equatable.dart';
import 'package:footballpassport/blocs/models/ground.dart';

abstract class HomeStates {}

class HomeUninitializedState extends HomeStates {}

class HomeFetchingState extends HomeStates {}

class HomeFetchedState extends HomeStates {
  final List<Ground> grounds;
  HomeFetchedState({this.grounds});
}

class HomeErrorState extends HomeStates {}

class HomeEmptyState extends HomeStates {}
