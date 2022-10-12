import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/index/jp_game_item/state.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class JPTopItemComponent extends Component<JPGameItemState> {
  static final String componentName = "JPTopItemComponent";
  JPTopItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<JPGameItemState>(
              adapter: null, slots: <String, Dependent<JPGameItemState>>{}),
        );
}
