import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyGiftPage extends Page<MyGiftState, Map<String, dynamic>> {
  static final String pageName = "MyGiftPage";
  MyGiftPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MyGiftState>(
              adapter: NoneConn<MyGiftState>() + MyGiftListAdapter(),
              slots: <String, Dependent<MyGiftState>>{}),
          middleware: <Middleware<MyGiftState>>[],
        );
}
