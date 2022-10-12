import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';

class RecruitmentModel extends BaseModel<Data> {
  RecruitmentModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  String bgImage;
  List<String> rule;
  List<RecruitmentRankBean> rankList;
  String gsPhone;
  String gsQq;
  String gsWeChat;

  Data.fromJson(Map<String, dynamic> json) {
    bgImage = json['bg_image'];
    rule = json['rule'].cast<String>();
    if (json['rank_list'] != null) {
      rankList = List<RecruitmentRankBean>();
      json['rank_list'].forEach((v) {
        rankList.add(RecruitmentRankBean.fromJson(v));
      });
    }
    gsPhone = json['gs_phone'];
    gsQq = json['gs_qq'];
    gsWeChat = json['gs_weixin'];
  }
}

class RecruitmentRankBean {
  String name;
  String icon;
  num money;

  RecruitmentRankBean.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    money = json['amount'];
  }
}
