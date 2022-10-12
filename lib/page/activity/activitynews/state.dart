import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/activity/activty_home/state.dart'
    as activity_fragment;
import 'package:flutter_huoshu_app/component/activity/activty_home/state.dart';

class ActivityNewsState implements Cloneable<ActivityNewsState> {
  ActivityHomeState activityFragmentState = activity_fragment.initState();

  @override
  ActivityNewsState clone() {
    return ActivityNewsState()..activityFragmentState = activityFragmentState;
  }
}

ActivityNewsState initState(Map<String, dynamic> args) {
  return ActivityNewsState();
}

class ActivityFragmentConnector
    extends ConnOp<ActivityNewsState, activity_fragment.ActivityHomeState> {
  @override
  void set(
      ActivityNewsState state, activity_fragment.ActivityHomeState subState) {
//    super.set(state, subState);
    state.activityFragmentState = subState;
  }

  @override
  activity_fragment.ActivityHomeState get(ActivityNewsState state) {
    return state.activityFragmentState;
  }
}
