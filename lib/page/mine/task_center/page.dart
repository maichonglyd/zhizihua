import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TaskCenterPage extends Page<TaskCenterState, Map<String, dynamic>> {
  static final String pageName = "TaskCenterPage";
  TaskCenterPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TaskCenterState>(
              adapter: null, slots: <String, Dependent<TaskCenterState>>{}),
          middleware: <Middleware<TaskCenterState>>[],
        );
}
