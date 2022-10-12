import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/list_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///游戏币页面
class GameCurrencyListPage
    extends Page<GameCurrencyListState, Map<String, dynamic>> {
  static final String pageName = "GameCurrencyListPage";
  GameCurrencyListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCurrencyListState>(
//                adapter: null,
              adapter:
                  NoneConn<GameCurrencyListState>() + GameCurrencyListAdapter(),
              slots: <String, Dependent<GameCurrencyListState>>{}),
          middleware: <Middleware<GameCurrencyListState>>[],
        );
}
