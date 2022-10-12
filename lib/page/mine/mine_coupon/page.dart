import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/component.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/coupon_list/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///我的优惠券
class MineCouponPage extends Page<MineCouponState, Map<String, dynamic>> {
  static final String pageName = "MineCouponPage";

  MineCouponPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MineCouponState>(
              adapter: null,
              slots: <String, Dependent<MineCouponState>>{
                "unUsedCoupon": CouponUnUsedConnector() + CouponListComponent(),
                "usedCoupon": CouponUsedConnector() + CouponListComponent(),
                "couponExpired":
                    CouponExpiredConnector() + CouponListComponent(),
              }),
          middleware: <Middleware<MineCouponState>>[],
        );
}
