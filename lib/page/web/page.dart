import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WebPage extends Page<WebPageState, Map<String, dynamic>> {
  static final String pageName = "WebPage";
  WebPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<WebPageState>(
              adapter: null, slots: <String, Dependent<WebPageState>>{}),
          middleware: <Middleware<WebPageState>>[],
        );
}
