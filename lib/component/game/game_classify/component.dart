import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/component.dart'
    as game_list;
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameClassifyComponent extends Component<GameClassifyState> {
  static final String componentName = "GameClassifyComponent";
  GameClassifyComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameClassifyState>(
              adapter: null,
              slots: <String, Dependent<GameClassifyState>>{
                "game_list":
                    GameListFragmentConnector() + game_list.GameListComponent()
              }),
        );
}
