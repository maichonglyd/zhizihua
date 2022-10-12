import 'package:fish_redux/fish_redux.dart';
import '../state.dart';
import 'action.dart';

Effect<MyGiftState> buildEffect() {
  return combineEffects(<Object, Effect<MyGiftState>>{
    MyGiftLiatAdapterAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MyGiftState> ctx) {}
