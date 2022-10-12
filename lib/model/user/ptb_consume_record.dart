import '../base_model.dart';

class PtbConsumeRecord extends BaseModel<Data> {
  PtbConsumeRecord.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Consume> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Consume>();
      json['list'].forEach((v) {
        list.add(new Consume.fromJson(v));
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

class Consume {
  int id;
  String orderId;
  int type;
  int appId;
  int memId;
  dynamic amount;
  int realAmount;
  int rebateCnt;
  int discount;
  dynamic ptbCnt;
  String payway;
  String ip;
  int status;
  int createTime;
  int updateTime;
  String remark;
  String username;
  String nickname;
  int agentId;
  String gamename;

  Consume(
      {this.id,
      this.orderId,
      this.type,
      this.appId,
      this.memId,
      this.amount,
      this.realAmount,
      this.rebateCnt,
      this.discount,
      this.ptbCnt,
      this.payway,
      this.ip,
      this.status,
      this.createTime,
      this.updateTime,
      this.remark,
      this.username,
      this.nickname,
      this.agentId,
      this.gamename});

  Consume.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    type = json['type'];
    appId = json['app_id'];
    memId = json['mem_id'];
    amount = json['amount'];
    realAmount = json['real_amount'];
    rebateCnt = json['rebate_cnt'];
    discount = json['discount'];
    ptbCnt = json['ptb_cnt'];
    payway = json['payway'];
    ip = json['ip'];
    status = json['status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    remark = json['remark'];
    username = json['username'];
    nickname = json['nickname'];
    agentId = json['agent_id'];
    gamename = json['gamename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['type'] = this.type;
    data['app_id'] = this.appId;
    data['mem_id'] = this.memId;
    data['amount'] = this.amount;
    data['real_amount'] = this.realAmount;
    data['rebate_cnt'] = this.rebateCnt;
    data['discount'] = this.discount;
    data['ptb_cnt'] = this.ptbCnt;
    data['payway'] = this.payway;
    data['ip'] = this.ip;
    data['status'] = this.status;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['remark'] = this.remark;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['agent_id'] = this.agentId;
    data['gamename'] = this.gamename;
    return data;
  }
}
