import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PropDealBuyRecordPage
    extends Page<PropDealBuyRecordState, Map<String, dynamic>> {
  static final String pageName = "PropDealBuyRecordPage";
  PropDealBuyRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PropDealBuyRecordState>(
              adapter: null,
              slots: <String, Dependent<PropDealBuyRecordState>>{}),
          middleware: <Middleware<PropDealBuyRecordState>>[],
        );
}
