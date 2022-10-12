import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/component/mine/mine_top_tab/component.dart'
    as mine_top_tab;
import 'package:flutter_huoshu_app/component/mine/mine_fun_list/component.dart'
    as mine_fun_list;
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/model/user/user_info.dart' as user_info;
import 'package:flutter_huoshu_app/component/mine/mine_common_func/state.dart'
    as mine_common_func;
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';

class MineFragmentState with GlobalBaseState<MineFragmentState> {
  user_info.Data userInfo;
  int msgCount = 0;
  MemInfoData memInfoData;
  String videoType;

  @override
  MineFragmentState clone() {
    return MineFragmentState()
      ..copyGlobalFrom(this)
      ..userInfo = userInfo
      ..memInfoData = memInfoData
      ..videoType = videoType
      ..msgCount = msgCount;
  }
}

// MineFragmentState initState() {
//   return MineFragmentState();
// }

MineFragmentState initState(String videoType) {
  HuoVideoManager.add(HuoVideoViewExt(videoType));
  return MineFragmentState()..videoType = videoType;
}

class MineCommonFuncConnector
    extends ConnOp<MineFragmentState, mine_common_func.MineCommonFuncState> {
  @override
  void set(
      MineFragmentState state, mine_common_func.MineCommonFuncState subState) {
    super.set(state, subState);
  }

  @override
  mine_common_func.MineCommonFuncState get(MineFragmentState state) {
    return mine_common_func.initState();
  }
}

class MineTopTabConnector
    extends ConnOp<MineFragmentState, mine_top_tab.MineTopTabState> {
  @override
  void set(MineFragmentState state, mine_top_tab.MineTopTabState subState) {
    super.set(state, subState);
  }

  @override
  mine_top_tab.MineTopTabState get(MineFragmentState state) {
    return mine_top_tab.initState();
  }
}

class MineFunListConnector
    extends ConnOp<MineFragmentState, mine_fun_list.MineFunListState> {
  @override
  void set(MineFragmentState state, mine_fun_list.MineFunListState subState) {
    super.set(state, subState);
  }

  @override
  mine_fun_list.MineFunListState get(MineFragmentState state) {
    return mine_fun_list.initState();
  }
}
