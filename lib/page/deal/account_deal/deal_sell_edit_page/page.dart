import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DealSellEditPage extends Page<DealSellEditState, Map<String, dynamic>> {
  static final String pageName = "DealSellEditPage";
  DealSellEditPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealSellEditState>(
              adapter: null, slots: <String, Dependent<DealSellEditState>>{}),
          middleware: <Middleware<DealSellEditState>>[],
        );
}
