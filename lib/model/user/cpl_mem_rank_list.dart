import 'package:flutter_huoshu_app/common/util/huo_log.dart';

import '../base_model.dart';

class CplMemRankList extends BaseModel<Data> {
  CplMemRankList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<CplMemRank> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<CplMemRank>();
      json['list'].forEach((v) {
        list.add(CplMemRank.fromJson(v));
      });
    }
  }

}

class CplMemRank {
  num memId;
  String money;
  String nickname;
  String avatar;

  CplMemRank.fromJson(Map<String, dynamic> json) {
    memId = json['mem_id'];
    money = json['money'];
    nickname = json['nickname'];
    avatar = json['avatar'];
  }

}
