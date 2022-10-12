import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/activity/activty_home/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ActivityNewsPage extends Page<ActivityNewsState, Map<String, dynamic>> {
  static final String pageName = "ActivityNewsPage";
  ActivityNewsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ActivityNewsState>(
              adapter: null,
              slots: <String, Dependent<ActivityNewsState>>{
                ActivityHomeComponent.componentName:
                    ActivityFragmentConnector() + ActivityHomeComponent(),
              }),
          middleware: <Middleware<ActivityNewsState>>[],
        );
}
