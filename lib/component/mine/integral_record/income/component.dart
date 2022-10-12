import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IntegralIncomeComponent extends Component<IntegralIncomeState> {
  static final String componentName = "IntegralIncomeComponent";
  IntegralIncomeComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IntegralIncomeState>(
              adapter: null, slots: <String, Dependent<IntegralIncomeState>>{}),
        );
}
