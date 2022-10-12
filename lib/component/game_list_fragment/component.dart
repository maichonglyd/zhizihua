import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/list_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

import 'package:flutter_huoshu_app/widget/keep_alive.dart';
export 'state.dart';

class GameListComponent extends Component<GameListState>
    with PrivateReducerMixin<GameListState> {
  GameListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameListState>(
                adapter: NoneConn<GameListState>() + GameListAdapter(),
                slots: <String, Dependent<GameListState>>{}),
            wrapper: keepAliveWrapper);
}
