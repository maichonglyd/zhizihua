import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/component.dart'
    as game_list;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameRankPage extends Page<GameRankState, Map<String, dynamic>> {
  static final String pageName = "GameRankPage";
  GameRankPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameRankState>(
              adapter: null,
              slots: <String, Dependent<GameRankState>>{
                "game_list_bt": BtGameListFragmentConnector() +
                    game_list.GameListComponent(),
                "game_list_zk": ZkGameListFragmentConnector() +
                    game_list.GameListComponent(),
                "game_list_h5": H5GameListFragmentConnector() +
                    game_list.GameListComponent(),
              }),
          middleware: <Middleware<GameRankState>>[],
        );
}
