import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GameComingSoonComponent extends Component<GameComingSoonState> {
  static final String componentName = "GameComingSoonComponent";
  GameComingSoonComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GameComingSoonState>(
                adapter: null,
                slots: <String, Dependent<GameComingSoonState>>{
                }),);

}
