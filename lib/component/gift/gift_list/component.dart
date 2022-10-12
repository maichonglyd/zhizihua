import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class GiftListFragment extends Component<GiftListFragmentState> {
  static final String componentName = "GiftListFragment";
  GiftListFragment()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<GiftListFragmentState>(
              slots: <String, Dependent<GiftListFragmentState>>{}),
        );
}
