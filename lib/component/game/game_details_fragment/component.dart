import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

///游戏详情里面的游戏简介
class GameDetailsComponent extends Component<GameDetailsComponentState> {
  static final String componentName = "GameDetailsComponent";
  GameDetailsComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameDetailsComponentState>(
              adapter:
                  NoneConn<GameDetailsComponentState>() + GameDetailsAdapter(),
              slots: <String, Dependent<GameDetailsComponentState>>{}),
        );
}
