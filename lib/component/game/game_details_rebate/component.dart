import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

class GameDetailsRebateComponent extends Component<GameDetailsRebateState> {
  static final String componentName = "GameDetailsRebateComponent";
  GameDetailsRebateComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameDetailsRebateState>(
              adapter: null,
              slots: <String, Dependent<GameDetailsRebateState>>{
                IndexRowGameComponent.componentName:
                    RowGameConnector() + IndexRowGameComponent()
              }),
        );
}
