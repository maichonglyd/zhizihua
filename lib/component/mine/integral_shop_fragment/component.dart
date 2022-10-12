import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IntegralShopFragment extends Component<IntegralShopFragmentState> {
  static final String componentName = "IntegralShopFragment";
  IntegralShopFragment()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntegralShopFragmentState>(
              adapter: NoneConn<IntegralShopFragmentState>() +
                  IntegralShopListAdapter(),
              slots: <String, Dependent<IntegralShopFragmentState>>{}),
        );
}
