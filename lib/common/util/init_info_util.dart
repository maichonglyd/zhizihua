import 'dart:convert';

import 'package:fish_redux/src/redux_component/basic.dart';
import 'package:flutter_huoshu_app/app/state.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/action.dart';
import 'package:flutter_huoshu_app/model/init/init_info.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:flutter_huoshu_app/widget/loading_refresh.dart';

class InitInfoUtil {
  static const String SP_KEY_INIT_INFO = "sp_key_init_info";

  static LoadStatus loadStatus = LoadStatus.loading;

  static int retryCount=0;

  static void initOK(Context<AppState> ctx, InitInfo info){
    ctx.broadcast(HomeActionCreator.onInitOK(info));
    ctx.broadcast(IndexBtFragmentActionCreator.upInitInfo(info));
  }

  static void initError(Context<AppState> ctx){
    InitInfoUtil.loadStatus = LoadStatus.error;
    ctx.broadcast(HomeActionCreator.onInitError());
  }

  static saveData(String json) async {
    loadStatus = LoadStatus.success;
    (await SpUtil.getSP()).setString(SP_KEY_INIT_INFO, json);
  }

  static Future<InitInfo> getInitInfo() async {
    String data = (await SpUtil.getSP()).getString(SP_KEY_INIT_INFO);
    if (data != null && data.isNotEmpty) {
      return InitInfo.fromJson(json.decode(data));
    }
    return Future.value(null);
  }
}
