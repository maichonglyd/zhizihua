import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IntegralExpendComponent extends Component<IntegralExpendState> {
  static final String componentName = "IntegralExpendComponent";
  IntegralExpendComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntegralExpendState>(
              adapter: null, slots: <String, Dependent<IntegralExpendState>>{}),
        );
}
