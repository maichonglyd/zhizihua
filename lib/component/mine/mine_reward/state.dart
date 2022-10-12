import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/coupon_my_reward_data.dart';

class MineRewardState implements Cloneable<MineRewardState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  List<CouponData> dataList = List();

  @override
  MineRewardState clone() {
    return MineRewardState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..dataList = dataList;
  }
}

MineRewardState initState() {
  return MineRewardState()
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController()
    ..dataList = List();
}
