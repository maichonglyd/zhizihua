import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';

class LotteryRewardList extends BaseModel<Data> {
  LotteryRewardList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num count;
  List<LotteryRewardBean> list;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<LotteryRewardBean>();
      json['list'].forEach((v) {
        list.add(LotteryRewardBean.fromJson(v));
      });
    }
  }
}

class LotteryRewardBean {
  num id;
  String name;
  String icon;

  LotteryRewardBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }
}
