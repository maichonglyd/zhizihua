import 'package:fish_redux/fish_redux.dart';

import 'state.dart';

Effect<SearchBarState> buildEffect() {
  return combineEffects(<Object, Effect<SearchBarState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<SearchBarState> ctx) {}
