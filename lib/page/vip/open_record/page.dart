import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OpenRecordPage extends Page<OpenRecordState, Map<String, dynamic>> {
  static final String pageName = "OpenRecordPage";
  OpenRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OpenRecordState>(
              adapter: null, slots: <String, Dependent<OpenRecordState>>{}),
          middleware: <Middleware<OpenRecordState>>[],
        );
}
