import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_activity_info.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_reward_detail_model.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_reward_list.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_start_model.dart';

class LotteryService {
  static Future<LotteryRewardList> getRewardList(int page, num lotteryId,
      {int offset = 9}) async {
    dynamic response = await CommonDio.post("lottery/award/list",
        data: {'page': page,'lottery_id': lotteryId, 'offset': offset});
    return LotteryRewardList.fromJson(response);
  }

  static Future<LotteryActivityInfo> getLotteryInfo() async {
    dynamic response = await CommonDio.post("lottery/my/info");
    return LotteryActivityInfo.fromJson(response);
  }

  static Future<LotteryMyRewardList> getMyRewardList(int page,
      {int offset = 20}) async {
    dynamic response = await CommonDio.post("lottery/mem/award/list",
        data: {'page': page, 'offset': offset});
    return LotteryMyRewardList.fromJson(response);
  }

  static Future<LotteryRewardDetailModel> getRewardDetail(String rewardId) async {
    dynamic response = await CommonDio.post("lottery/mem/award/detail",
        data: {'order_id': rewardId});
    return LotteryRewardDetailModel.fromJson(response);
  }

  static Future<BaseModel> bugRechargeOpportunity(num buyCnt, num lotteryId) async {
    dynamic response = await CommonDio.post("lottery/opportunity/buy",
        data: {'buy_cnt': buyCnt, 'lottery_id': lotteryId});
    return BaseModel.fromJson(response);
  }

  static Future<BaseModel> createAddress(
      String orderId, String consignee, String address, String mobile) async {
    dynamic response = await CommonDio.post("lottery/lottery/saveAddress", data: {
      'order_id': orderId,
      'consignee': consignee,
      'address': address,
      'mobile': mobile
    });
    return BaseModel.fromJson(response);
  }

  static Future<LotteryStartModel> startLottery(num lotteryId) async {
    dynamic response = await CommonDio.post("lottery/lottery/join",
        data: {'lottery_id': lotteryId});
    return LotteryStartModel.fromJson(response);
  }
}
