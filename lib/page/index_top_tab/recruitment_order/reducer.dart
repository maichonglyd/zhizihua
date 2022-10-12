import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RecruitmentOrderState> buildReducer() {
  return asReducer(
    <Object, Reducer<RecruitmentOrderState>>{
      RecruitmentOrderAction.action: _onAction,
      RecruitmentOrderAction.updateData: _updateData,
    },
  );
}

RecruitmentOrderState _onAction(RecruitmentOrderState state, Action action) {
  final RecruitmentOrderState newState = state.clone();
  return newState;
}

RecruitmentOrderState _updateData(RecruitmentOrderState state, Action action) {
  final RecruitmentOrderState newState = state.clone();
  newState.recruitmentModel = action.payload;
  return newState;
}
