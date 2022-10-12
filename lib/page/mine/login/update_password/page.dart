import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UpdatePasswordPage
    extends Page<UpdatePasswordState, Map<String, dynamic>> {
  static final String pageName = "UpdatePasswordPage";
  UpdatePasswordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<UpdatePasswordState>(
              adapter: null, slots: <String, Dependent<UpdatePasswordState>>{}),
          middleware: <Middleware<UpdatePasswordState>>[],
        );
}
