import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealSellRecordPage
    extends Page<PropDealSellRecordState, Map<String, dynamic>> {
  static final String pageName = "PropDealSellRecordPage";
  PropDealSellRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealSellRecordState>(
              adapter: null,
              slots: <String, Dependent<PropDealSellRecordState>>{}),
          middleware: <Middleware<PropDealSellRecordState>>[],
        );
}
