import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GiftItemComponent extends Component<GiftItemState> {
  static final String componentName = "GiftItemComponent";
  GiftItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GiftItemState>(
              adapter: null, slots: <String, Dependent<GiftItemState>>{}),
        );
}
