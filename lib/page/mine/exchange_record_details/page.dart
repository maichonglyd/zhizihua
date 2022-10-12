import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/exchange_record_list_data.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ExchangeRecordDetailsPage
    extends Page<ExchangeRecordDetailsState, ExchangeBean> {
  static final String pageName = "ExchangeRecordDetailsPage";
  ExchangeRecordDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ExchangeRecordDetailsState>(
              adapter: null,
              slots: <String, Dependent<ExchangeRecordDetailsState>>{}),
          middleware: <Middleware<ExchangeRecordDetailsState>>[],
        );
}
