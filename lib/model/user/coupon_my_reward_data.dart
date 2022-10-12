import '../base_model.dart';

class CouponMyRewardData extends BaseModel<Data> {
  CouponMyRewardData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<CouponData> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<CouponData>();
      json['list'].forEach((v) {
        list.add(new CouponData.fromJson(v));
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

class CouponData {
  int id;
  int type;
  int memCnt;
  int appId;
  int gmCnt;
  int gmCondition;
  int gmEndDay;
  int createTime;
  int updateTime;
  String ext;
  int isGet;
  int canGet;

  CouponData(
      {this.id,
      this.type,
      this.memCnt,
      this.appId,
      this.gmCnt,
      this.gmCondition,
      this.gmEndDay,
      this.createTime,
      this.updateTime,
      this.ext,
      this.isGet,
      this.canGet});

  CouponData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    memCnt = json['mem_cnt'];
    appId = json['app_id'];
    gmCnt = json['gm_cnt'];
    gmCondition = json['gm_condition'];
    gmEndDay = json['gm_end_day'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    ext = json['ext'];
    isGet = json['is_get'];
    canGet = json['can_get'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['mem_cnt'] = this.memCnt;
    data['app_id'] = this.appId;
    data['gm_cnt'] = this.gmCnt;
    data['gm_condition'] = this.gmCondition;
    data['gm_end_day'] = this.gmEndDay;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['ext'] = this.ext;
    data['is_get'] = this.isGet;
    data['can_get'] = this.canGet;
    return data;
  }
}
