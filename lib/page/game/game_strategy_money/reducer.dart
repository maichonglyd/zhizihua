import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GameStrategyMoneyState> buildReducer() {
  return asReducer(
    <Object, Reducer<GameStrategyMoneyState>>{
      GameStrategyMoneyAction.action: _onAction,
      GameStrategyMoneyAction.clickButton: _clickButton,
    },
  );
}

GameStrategyMoneyState _onAction(GameStrategyMoneyState state, Action action) {
  final GameStrategyMoneyState newState = state.clone();
  return newState;
}

GameStrategyMoneyState _clickButton(GameStrategyMoneyState state, Action action) {
  final GameStrategyMoneyState newState = state.clone();
  newState.selectIndex = action.payload;
  newState.swiperController.move(newState.selectIndex, animation: true);
  return newState;
}
