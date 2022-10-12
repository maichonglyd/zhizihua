import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/component/game_list_fragment/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<KfFragmentState>
    extends ComponentState<KfFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<KfFragmentState> on Component<KfFragmentState> {
  @override
  SingleTickerProviderStfState<KfFragmentState> createState() =>
      SingleTickerProviderStfState<KfFragmentState>();
}

class KfFragment extends Component<KfFragmentState>
    with SingleTickerProviderMixin {
  KfFragment()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<KfFragmentState>(
                adapter: null,
                slots: <String, Dependent<KfFragmentState>>{
                  "today_kf_game_list":
                      ToDayGameListFragmentConnector() + GameListComponent(),
                  "new_kf_game_list":
                      NewGameListFragmentConnector() + GameListComponent(),
                  "old_kf_game_list":
                      OldGameListFragmentConnector() + GameListComponent(),
                }),
            wrapper: keepAliveWrapper);
}
