import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';

import 'effect.dart';
import 'reducer.dart';

import 'view.dart';

class IndexRecommendUpComponent extends Component<GameSpecialHeadState> {
  static final String componentName = "IndexRecommendUpComponent";
  IndexRecommendUpComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GameSpecialHeadState>(
              adapter: null,
              slots: <String, Dependent<GameSpecialHeadState>>{}),
        );
}
