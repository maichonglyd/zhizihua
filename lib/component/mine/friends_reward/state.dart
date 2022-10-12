import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/coupon_friend_reward_data.dart';

class FriendRewardState implements Cloneable<FriendRewardState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  List<DataInfo> dataList = List();

  @override
  FriendRewardState clone() {
    return FriendRewardState()
      ..refreshHelper = refreshHelper
      ..refreshHelperController = refreshHelperController
      ..dataList = dataList;
  }
}

FriendRewardState initState() {
  return FriendRewardState()
    ..refreshHelper = RefreshHelper()
    ..refreshHelperController = RefreshHelperController()
    ..dataList = List();
}
