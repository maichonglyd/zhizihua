import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ActivityDetailsPage
    extends Page<ActivityDetailsState, Map<String, dynamic>> {
  static final String pageName = "ActivityDetailsPage";
  ActivityDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ActivityDetailsState>(
              adapter: null,
              slots: <String, Dependent<ActivityDetailsState>>{}),
          middleware: <Middleware<ActivityDetailsState>>[],
        );
}
