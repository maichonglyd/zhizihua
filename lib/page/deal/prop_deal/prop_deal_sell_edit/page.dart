import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealSellEditPage
    extends Page<PropDealSellEditState, Map<String, dynamic>> {
  static final String pageName = "PropDealSellEditPage";
  PropDealSellEditPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealSellEditState>(
              adapter: null,
              slots: <String, Dependent<PropDealSellEditState>>{}),
          middleware: <Middleware<PropDealSellEditState>>[],
        );
}
