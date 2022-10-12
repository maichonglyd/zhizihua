import 'dart:io';

import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_detail_model.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_gift_model.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_role_model.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_stop_model.dart';

class TurnGameService {
  static Future<TurnGameModel> getTurnGameList(int page,
      {int offset = 20}) async {
    dynamic response = await CommonDio.post("switchgame/activity/list",
        data: {'page': page, 'offset': offset, 'classify': Platform.isIOS ? 4 : 3,});
    return TurnGameModel.fromJson(response);
  }

  static Future<TurnGameDetailModel> getTurnGameDetail(num activityId) async {
    dynamic response = await CommonDio.post("switchgame/activity/detail",
        data: {'activity_id': activityId});
    return TurnGameDetailModel.fromJson(response);
  }

  static Future<TurnGameStopModel> getTurnGameStopList(int page,
      {int offset = 20}) async {
    dynamic response = await CommonDio.post("switchgame/game/stop/list",
        data: {'page': page, 'offset': offset, 'classify': Platform.isIOS ? 4 : 3,});
    return TurnGameStopModel.fromJson(response);
  }

  static Future<TurnGameGiftModel> getTurnGameApplyList(int page,
      {int offset = 20}) async {
    dynamic response = await CommonDio.post("switchgame/activity/apply/list",
        data: {'page': page, 'offset': offset, 'classify': Platform.isIOS ? 4 : 3,});
    return TurnGameGiftModel.fromJson(response);
  }

  static Future<BaseModel> applyTurnGameApply(num activityId, num toGameId, num roleId) async {
    dynamic response = await CommonDio.post("switchgame/activity/apply",
        data: {'activity_id': activityId, 'from_game_id': toGameId, 'to_mg_role_id': roleId});
    return BaseModel.fromJson(response);
  }

  static Future<TurnGameRoleModel> getTurnGameRoleList(int page, num activityId, num gameId,
      {int offset = 20}) async {
    dynamic response = await CommonDio.post("switchgame/game/role/list",
        data: {'page': page, 'activity_id': activityId, 'game_id': gameId, 'offset': offset});
    return TurnGameRoleModel.fromJson(response);
  }
}
