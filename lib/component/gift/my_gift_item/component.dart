import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
export 'state.dart';

class MyGiftItemComponent extends Component<MyGiftItemState> {
  static final String componentName = "MyGiftItemComponent";
  MyGiftItemComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MyGiftItemState>(
              adapter: null, slots: <String, Dependent<MyGiftItemState>>{}),
        );
}
