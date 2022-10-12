import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyBuyListPage extends Page<MyBuyListState, Map<String, dynamic>> {
  static final String pageName = "MyBuyListPage";
  MyBuyListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MyBuyListState>(
              adapter: null, slots: <String, Dependent<MyBuyListState>>{}),
          middleware: <Middleware<MyBuyListState>>[],
        );
}
