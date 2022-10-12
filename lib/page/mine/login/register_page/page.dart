import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class RegisterPage extends Page<RegisterPageState, Map<String, dynamic>> {
  static final String pageName = "RegisterPage";
  RegisterPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<RegisterPageState>(
              adapter: null, slots: <String, Dependent<RegisterPageState>>{}),
          middleware: <Middleware<RegisterPageState>>[],
        );
}
