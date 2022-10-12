import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealBuyAgreePage
    extends Page<PropDealBuyAgreeState, Map<String, dynamic>> {
  PropDealBuyAgreePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealBuyAgreeState>(
              adapter: null,
              slots: <String, Dependent<PropDealBuyAgreeState>>{}),
          middleware: <Middleware<PropDealBuyAgreeState>>[],
        );
}
