import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/index/lottery/lottery_my_reward_list.dart';

class LotteryRewardDetailModel extends BaseModel<LotteryMyRewardBean> {
  LotteryRewardDetailModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = LotteryMyRewardBean.fromJson(jsonRes);
  }
}