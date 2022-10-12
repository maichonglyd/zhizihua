import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/activity/activity_list/state.dart';
import 'package:flutter_huoshu_app/component/gift/gift_list/state.dart';

class ActivityHomeState implements Cloneable<ActivityHomeState> {
  GiftListFragmentState giftListFragmentState = GiftListFragmentState();
  ActivityListState activityListState = ActivityListState()..type = 2;
  ActivityListState noticeListState = ActivityListState()..type = 4;
  ActivityListState strategyListState = ActivityListState()..type = 3;

  @override
  ActivityHomeState clone() {
    return ActivityHomeState()
      ..activityListState = activityListState
      ..noticeListState = noticeListState
      ..strategyListState = strategyListState
      ..giftListFragmentState = giftListFragmentState;
  }
}

ActivityHomeState initState() {
  return ActivityHomeState();
}

class GiftListFragmentConnector
    extends ConnOp<ActivityHomeState, GiftListFragmentState> {
  @override
  void set(ActivityHomeState state, GiftListFragmentState subState) {
//    super.set(state, subState);
    state.giftListFragmentState = subState;
  }

  @override
  GiftListFragmentState get(ActivityHomeState state) {
    return state.giftListFragmentState;
  }
}

class ActivityFragmentConnector
    extends ConnOp<ActivityHomeState, ActivityListState> {
  @override
  void set(ActivityHomeState state, ActivityListState subState) {
//    super.set(state, subState);
    state.activityListState = subState;
  }

  @override
  ActivityListState get(ActivityHomeState state) {
    return state.activityListState;
  }
}

class NoticeFragmentConnector
    extends ConnOp<ActivityHomeState, ActivityListState> {
  @override
  void set(ActivityHomeState state, ActivityListState subState) {
//    super.set(state, subState);
    state.noticeListState = subState;
  }

  @override
  ActivityListState get(ActivityHomeState state) {
    return state.noticeListState;
  }
}

class StrategyFragmentConnector
    extends ConnOp<ActivityHomeState, ActivityListState> {
  @override
  void set(ActivityHomeState state, ActivityListState subState) {
//    super.set(state, subState);
    state.strategyListState = subState;
  }

  @override
  ActivityListState get(ActivityHomeState state) {
    return state.strategyListState;
  }
}
