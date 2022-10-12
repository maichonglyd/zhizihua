import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ExchangeRecordPage
    extends Page<ExchangeRecordState, Map<String, dynamic>> {
  static final String pageName = "ExchangeRecordPage";
  ExchangeRecordPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ExchangeRecordState>(
              adapter: null, slots: <String, Dependent<ExchangeRecordState>>{}),
          middleware: <Middleware<ExchangeRecordState>>[],
        );
}
