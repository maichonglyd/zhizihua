import 'package:flutter_huoshu_app/component/classify/model/classify_mod.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter_huoshu_app/model/game/game_jp.dart';
import 'package:flutter_huoshu_app/model/game/game_list.dart';
import 'package:flutter_huoshu_app/model/game/game_type.dart';
import 'package:flutter_huoshu_app/model/game/home_bean.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/model/game/newsdetails_bean.dart';
import 'package:flutter_huoshu_app/model/game/search_hot_list.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_list.dart';
import 'package:flutter_huoshu_app/model/game_dto.dart';
import 'package:flutter_huoshu_app/model/game_curr/game_recharge_list.dart';


import 'common_dio.dart';

class GameCurrService {

  //获取游戏币游戏列表
  static Future<GameCurrList> getCurrGameList(
    int page,
  ) async {
    dynamic response = await CommonDio.post("app/gm/game/list", data: {
      "page": page,
      "offset": 10,
    });
    return GameCurrList.fromJson(response);
  }

  //获取游戏充值列表
  static Future<GameRechargeList> getRechargeList(
      int page,int gameId
      ) async {
    dynamic response = await CommonDio.post("app/gm/recharge/record", data: {
      "page": page,
      "offset": 10,
      "game_id":gameId
    });
    return GameRechargeList.fromJson(response);
  }

  //获取游戏消费列表
  static Future<GameRechargeList> getConsumeList(
      int page,int gameId
      ) async {
    dynamic response = await CommonDio.post("app/gm/consume/record", data: {
      "page": page,
      "offset": 10,
      "game_id":gameId
    });
    return GameRechargeList.fromJson(response);
  }

}
