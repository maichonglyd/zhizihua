import '../base_model.dart';

class PtbRechargeRecord extends BaseModel<Data> {
  PtbRechargeRecord.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Recharge> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Recharge>();
      json['list'].forEach((v) {
        list.add(new Recharge.fromJson(v));
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

class Recharge {
  int id;
  String orderId;
  int memId;
  int fromId;
  int type;
  num amount;
  num realAmount;
  num ptbCnt;
  num rebateCnt;
  num discount;
  String payway;
  String ip;
  int status;
  int backStatus;
  int createTime;
  int updateTime;
  String remark;
  String username;
  String nickname;
  int agentId;
  String agentName;
  String paywayName;

  Recharge(
      {this.id,
      this.orderId,
      this.memId,
      this.fromId,
      this.type,
      this.amount,
      this.realAmount,
      this.ptbCnt,
      this.rebateCnt,
      this.discount,
      this.payway,
      this.ip,
      this.status,
      this.backStatus,
      this.createTime,
      this.updateTime,
      this.remark,
      this.username,
      this.nickname,
      this.agentId,
      this.agentName,
      this.paywayName});

  Recharge.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    memId = json['mem_id'];
    fromId = json['from_id'];
    type = json['type'];
    amount = json['amount'];
    realAmount = json['real_amount'];
    ptbCnt = json['ptb_cnt'];
    rebateCnt = json['rebate_cnt'];
    discount = json['discount'];
    payway = json['payway'];
    ip = json['ip'];
    status = json['status'];
    backStatus = json['back_status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    remark = json['remark'];
    username = json['username'];
    nickname = json['nickname'];
    agentId = json['agent_id'];
    agentName = json['agent_name'];
    paywayName = json['payway_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['mem_id'] = this.memId;
    data['from_id'] = this.fromId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['real_amount'] = this.realAmount;
    data['ptb_cnt'] = this.ptbCnt;
    data['rebate_cnt'] = this.rebateCnt;
    data['discount'] = this.discount;
    data['payway'] = this.payway;
    data['ip'] = this.ip;
    data['status'] = this.status;
    data['back_status'] = this.backStatus;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['remark'] = this.remark;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['agent_id'] = this.agentId;
    data['agent_name'] = this.agentName;
    data['payway_name'] = this.paywayName;
    return data;
  }
}
