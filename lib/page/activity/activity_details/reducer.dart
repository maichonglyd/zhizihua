import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ActivityDetailsState> buildReducer() {
  return asReducer(
    <Object, Reducer<ActivityDetailsState>>{
      ActivityDetailsAction.action: _onAction,
      ActivityDetailsAction.updateData: _updateData,
      ActivityDetailsAction.updateGames: _updateGames,
    },
  );
}

ActivityDetailsState _onAction(ActivityDetailsState state, Action action) {
  final ActivityDetailsState newState = state.clone();
  return newState;
}

ActivityDetailsState _updateData(ActivityDetailsState state, Action action) {
  final ActivityDetailsState newState = state.clone();
  newState.newsDetailsData = action.payload;
  return newState;
}

ActivityDetailsState _updateGames(ActivityDetailsState state, Action action) {
  final ActivityDetailsState newState = state.clone();
  newState.channelGames = action.payload;
  return newState;
}
