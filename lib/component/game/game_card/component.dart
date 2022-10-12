import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameCardComponent extends Component<GameCardState> {
  static final String componentName = "GameCardComponent";
  GameCardComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameCardState>(
                adapter: null,
                slots: <String, Dependent<GameCardState>>{
                }),);

}
