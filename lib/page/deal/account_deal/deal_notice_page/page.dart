import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DealNoticePage extends Page<DealNoticeState, Map<String, dynamic>> {
  static final String pageName = "DealNoticePage";
  DealNoticePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DealNoticeState>(
              adapter: null, slots: <String, Dependent<DealNoticeState>>{}),
          middleware: <Middleware<DealNoticeState>>[],
        );
}
