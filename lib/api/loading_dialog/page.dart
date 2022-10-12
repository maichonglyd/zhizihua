import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LoadingDialogPage extends Page<LoadingDialogState, Map<String, dynamic>> {
  static final String pageName = "LoadingDialogPage";

  LoadingDialogPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
        );
}
