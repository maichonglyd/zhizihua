import '../base_model.dart';

class CouponFriendRewardData extends BaseModel<Data> {
  CouponFriendRewardData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<DataInfo> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<DataInfo>();
      json['list'].forEach((v) {
        list.add(new DataInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataInfo {
  int memId;
  String username;
  int gmCnt;
  int createTime;

  DataInfo({this.memId, this.username, this.gmCnt, this.createTime});

  DataInfo.fromJson(Map<String, dynamic> json) {
    memId = json['mem_id'];
    username = json['username'];
    gmCnt = json['gm_cnt'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mem_id'] = this.memId;
    data['username'] = this.username;
    data['gm_cnt'] = this.gmCnt;
    data['create_time'] = this.createTime;
    return data;
  }
}
