import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCoinSelectChannelPage extends Page<GameCoinSelectChannelState, Game> {
  static final String pageName = "GameCoinSelectChannelPage";

  GameCoinSelectChannelPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCoinSelectChannelState>(
              adapter: null,
              slots: <String, Dependent<GameCoinSelectChannelState>>{}),
          middleware: <Middleware<GameCoinSelectChannelState>>[],
        );
}
