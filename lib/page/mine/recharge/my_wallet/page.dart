import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyWalletPage extends Page<MyWalletState, Map<String, dynamic>> {
  static final String pageName = "MyWalletPage";
  MyWalletPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MyWalletState>(
              adapter: null, slots: <String, Dependent<MyWalletState>>{}),
          middleware: <Middleware<MyWalletState>>[],
        );
}
