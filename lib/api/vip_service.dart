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
import 'package:flutter_huoshu_app/model/game_dto.dart';
import 'package:flutter_huoshu_app/model/vip/vip_mem_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_pay_info_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';
import 'package:flutter_huoshu_app/model/vip/vip_reward_data.dart';
import 'package:flutter_huoshu_app/model/vip/vip_type_list.dart';

import 'common_dio.dart';

class VIPService {

//  //预约游戏
//  static Future<BaseModel> subscribe(int gameId) async {
//    dynamic response =
//    await CommonDio.post("app/game/subscribe", data: {"game_id": gameId});
//    return BaseModel.fromJson(response);
//  }

  //获取vip列表
  static Future<VipList> getVipList(int page, {int offset = 10}) async {
    dynamic response = await CommonDio.post("app/vip/list",
        data: {"page": page, "offset": offset});
    return VipList.fromJson(response);
  }

  //开通
  static Future<VIPPayInfoData> openVip(int id, String payWay) async {
    dynamic response = await CommonDio.post("app/vip/pay",
        data: {"vip_id": id, "payway": payWay});
    return VIPPayInfoData.fromJson(response);
  }

  //查询支付结果
  static Future queryOrder(String orderId) async {
    dynamic response = await CommonDio.post("app/vip/order/query",
        data: {"order-order_id": orderId});
    return response;
  }

  //开通记录列表
  static Future<VipRecordList> getRecordList(int page, int offset ) async {
    dynamic response = await CommonDio.post("app/vip/mem/log/list",
        data: {"page": page, "offset": offset});
    return VipRecordList.fromJson(response);
  }

  //开通记录列表
  static Future<VIPMemInfoData> getMemInfo( ) async {
    dynamic response = await CommonDio.post("app/vip/mem/info");
    return VIPMemInfoData.fromJson(response);
  }

  //获取奖励
  static Future<RewardInfoData> reward( ) async {
    dynamic response = await CommonDio.post("app/vip/reword");
    return RewardInfoData.fromJson(response);
  }


}
