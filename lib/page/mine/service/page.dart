import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ServicePage extends Page<ServiceState, Map<String, dynamic>> {
  static final String pageName = "ServicePage";
  ServicePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ServiceState>(
              adapter: null, slots: <String, Dependent<ServiceState>>{}),
          middleware: <Middleware<ServiceState>>[],
        );
}
