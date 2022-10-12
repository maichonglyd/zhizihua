import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/mine/friends_reward/state.dart';
import 'package:flutter_huoshu_app/component/mine/friends_reward/state.dart'
    as friend_reward_fragment;
import 'package:flutter_huoshu_app/component/mine/mine_reward/state.dart';
import 'package:flutter_huoshu_app/component/mine/mine_reward/state.dart'
    as mine_reward_fragment;
import 'package:flutter_huoshu_app/model/user/share_info.dart';

class InviteState implements Cloneable<InviteState> {
  ShareInfo shareInfo;
  MineRewardState mineRewardState = mine_reward_fragment.initState();
  FriendRewardState friendRewardState = friend_reward_fragment.initState();
  String shareType = 'app';
  num lotteryId;

  @override
  InviteState clone() {
    return InviteState()
      ..shareInfo = shareInfo
      ..mineRewardState = mineRewardState
      ..friendRewardState = friendRewardState;
  }
}

InviteState initState(Map<String, dynamic> args) {
  if (null != args) {
    return InviteState()
      ..shareType = null != args['shareType'] ? args['shareType'] : 'app'
      ..lotteryId = null != args['lotteryId'] ? args['lotteryId'] : null;
  }

  return InviteState();
}

class MineRewardConnector
    extends ConnOp<InviteState, mine_reward_fragment.MineRewardState> {
  @override
  void set(InviteState state, mine_reward_fragment.MineRewardState subState) {
//    super.set(state, subState);
    state.mineRewardState = subState;
  }

  @override
  mine_reward_fragment.MineRewardState get(InviteState state) {
    return state.mineRewardState;
  }
}

class FriendRewardConnector
    extends ConnOp<InviteState, friend_reward_fragment.FriendRewardState> {
  @override
  void set(
      InviteState state, friend_reward_fragment.FriendRewardState subState) {
//    super.set(state, subState);
    state.friendRewardState = subState;
  }

  @override
  friend_reward_fragment.FriendRewardState get(InviteState state) {
    return state.friendRewardState;
  }
}
