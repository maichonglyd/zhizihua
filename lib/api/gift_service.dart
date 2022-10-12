import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/gift/game_gift_details.dart';
import 'package:flutter_huoshu_app/model/gift/game_gifts_bean.dart';

import 'common_dio.dart';

class GiftService {
  //获取游戏下礼包列表
  static Future<GameGiftBean> getGiftsById(
      int gameId, int page, int offset) async {
    dynamic response = await CommonDio.post("app/gift/list",
        data: {"game_id": gameId, "page": page, "offset": offset});
    return GameGiftBean.fromJson(response);
  }

  //领取礼包
  static Future addGift(int giftId,Context ctx) async {
    dynamic response =
        await CommonDio.post("app/user/gift/add", data: {"gift_id": giftId},ctx: ctx,gotoLogin: true);
    return response;
  }

  //我的礼包
  static Future<GameGiftBean> getMyGifts(int page, int offset) async {
    dynamic response = await CommonDio.post("app/user/gift/list",
        data: {"page": page, "offset": offset});
    return GameGiftBean.fromJson(response);
  }

  //礼包详情
  static Future<GameGiftDetails> getGiftDetails(int giftId) async {
    dynamic response =
        await CommonDio.post("app/gift/detail", data: {"gift_id": giftId});
    return GameGiftDetails.fromJson(response);
  }

  //获取游戏下礼包列表
  static Future<GameGiftBean> getGifts(
      int page, int offset) async {
    dynamic response = await CommonDio.post("app/gift/list",
        data: { "page": page, "offset": offset});
    return GameGiftBean.fromJson(response);
  }
}
