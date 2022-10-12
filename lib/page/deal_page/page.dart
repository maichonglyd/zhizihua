import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/deal/deal_fragment/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///账号交易和小号交易page
class DealPage extends Page<DealState, Map<String, dynamic>> {
  static final String pageName = "DealPage";

  DealPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealState>(
              adapter: null,
              slots: <String, Dependent<DealState>>{
                DealFragment.componentName:
                    DealFragmentConnector() + DealFragment(),
              }),
          middleware: <Middleware<DealState>>[],
        );
}
