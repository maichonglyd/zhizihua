import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FriendRewardComponent extends Component<FriendRewardState> {
  static final componentName = "FriendRewardComponent";
  FriendRewardComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<FriendRewardState>(
              adapter: null, slots: <String, Dependent<FriendRewardState>>{}),
        );
}
