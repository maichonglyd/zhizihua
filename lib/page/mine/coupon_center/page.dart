import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CouponCenterPage extends Page<CouponCenterState, Map<String, dynamic>> {
  static final String pageName = "CouponCenterPage";

  CouponCenterPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CouponCenterState>(
                adapter: null,
                slots: <String, Dependent<CouponCenterState>>{
                }),
            middleware: <Middleware<CouponCenterState>>[
            ],);

}
