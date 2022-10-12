import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PaySuccessPage extends Page<PaySuccessState, Map<String, dynamic>> {
  static final String pageName = "PaySuccessPage";
  PaySuccessPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PaySuccessState>(
              adapter: null, slots: <String, Dependent<PaySuccessState>>{}),
          middleware: <Middleware<PaySuccessState>>[],
        );
}
