import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/state.dart';
import 'package:flutter_huoshu_app/component/download/download_game_list/state.dart'
    as download_state;

class DownLoadManageState implements Cloneable<DownLoadManageState> {
  DownLoadGameListState downloadingState;
  DownLoadGameListState downloadCompleteState;
  DownLoadGameListState reservedState;

  @override
  DownLoadManageState clone() {
    return DownLoadManageState()
      ..downloadingState = downloadingState
      ..reservedState = reservedState
      ..downloadCompleteState = downloadCompleteState;
  }
}

DownLoadManageState initState(Map<String, dynamic> args) {
  return DownLoadManageState()
    ..reservedState = download_state.initState(2)
    ..downloadCompleteState = download_state.initState(1)
    ..downloadingState = download_state.initState(0);
}

class DownLoadCompleteConnector
    extends ConnOp<DownLoadManageState, DownLoadGameListState> {
  @override
  void set(DownLoadManageState state, DownLoadGameListState subState) {
//    super.set(state, subState);
    state.downloadCompleteState = subState;
  }

  @override
  DownLoadGameListState get(DownLoadManageState state) {
    return state.downloadCompleteState;
  }
}

class DownLoadingConnector
    extends ConnOp<DownLoadManageState, DownLoadGameListState> {
  @override
  void set(DownLoadManageState state, DownLoadGameListState subState) {
//    super.set(state, subState);
    state.downloadingState = subState;
  }

  @override
  DownLoadGameListState get(DownLoadManageState state) {
    return state.downloadingState;
  }
}

//已预约页面
class ReservedConnector
    extends ConnOp<DownLoadManageState, DownLoadGameListState> {
  @override
  void set(DownLoadManageState state, DownLoadGameListState subState) {
//    super.set(state, subState);
    state.reservedState = subState;
  }

  @override
  DownLoadGameListState get(DownLoadManageState state) {
    return state.reservedState;
  }
}
