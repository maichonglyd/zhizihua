import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class CurrRecordListComponent extends Component<CurrRecordListState>
    with PrivateReducerMixin<CurrRecordListState> {
  static final String componentName = "CurrRecordListComponent";

  CurrRecordListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CurrRecordListState>(
//                adapter: NoneConn<CouponListState>() +
//                    DownloadGameListAdapter(),
                adapter: null,
                slots: <String, Dependent<CurrRecordListState>>{}),
            wrapper: keepAliveWrapper);
}
