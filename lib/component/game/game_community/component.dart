import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_community/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCommunityComponent extends Component<GameCommunityState> {
  static final String componentName = "GameCommunityComponent";

  GameCommunityComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameCommunityState>(
              adapter: NoneConn<GameCommunityState>() + GameCommunityAdapter(),
              slots: <String, Dependent<GameCommunityState>>{}),
        );
}
