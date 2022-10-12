import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action,Page;
import 'package:flutter_huoshu_app/component/game/game_new_round_list/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameNewTourListPage
    extends Page<GameNewTourListState, Map<String, dynamic>> {
  static final String pageName = "GameNewTourListPage";

  GameNewTourListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameNewTourListState>(
              adapter: null,
              slots: <String, Dependent<GameNewTourListState>>{
                "first_game_new_round_list":
                    FirstGameNewRoundListFragmentConnector() +
                        GameNewRoundListComponent(),
                "second_game_new_round_list":
                    SecondGameNewRoundListFragmentConnector() +
                        GameNewRoundListComponent(),
                "third_game_new_round_list":
                ThirdGameNewRoundListFragmentConnector() +
                        GameNewRoundListComponent(),
              }),
          middleware: <Middleware<GameNewTourListState>>[],
        );
}
