import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class CouponListComponent extends Component<CouponListState>
    with PrivateReducerMixin<CouponListState> {
  static final String componentName = "CouponListComponent";

  CouponListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CouponListState>(
//                adapter: NoneConn<CouponListState>() +
//                    DownloadGameListAdapter(),
                adapter: null,
                slots: <String, Dependent<CouponListState>>{}),
            wrapper: keepAliveWrapper);
}
