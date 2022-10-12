import '../base_model.dart';

class CpsRechargeRecord extends BaseModel<Data> {
  CpsRechargeRecord.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Record> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Record>();
      json['list'].forEach((v) {
        list.add(Record.fromJson(v));
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

class Record {
  int id;
  String orderId;
  int memId;
  int appId;
  double money;
  double realMoney;
  String payway;
  int status;
  String remark;
  int payTime;
  int checkStatus;
  int createTime;
  String username;
  int checkTime;
  int cpsId;
  int gameId;
  String gameIcon;
  String gameName;
  String buyNickname;
  String buyUsername;
  String checkStatusTxt;
  String cps_name;
  num discount;

  Record({
    this.id,
    this.orderId,
    this.memId,
    this.appId,
    this.money,
    this.realMoney,
    this.payway,
    this.status,
    this.remark,
    this.payTime,
    this.checkStatus,
    this.createTime,
    this.username,
    this.checkTime,
    this.cpsId,
    this.gameId,
    this.gameIcon,
    this.gameName,
    this.buyNickname,
    this.buyUsername,
    this.checkStatusTxt,
    this.cps_name,
    this.discount,
  });

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    memId = json['mem_id'];
    appId = json['app_id'];
//    money = double.parse(json['money'].toString());
//    realMoney = double.parse(json['real_money'].toString());
    money = double.parse(json['amount'].toString());
    realMoney = double.parse(json['real_amount'].toString());

    payway = json['payway'];
    status = json['status'];
    remark = json['remark'];
    payTime = json['pay_time'];
    checkStatus = json['check_status'];
    createTime = json['create_time'];
    username = json['username'];
    checkTime = json['check_time'];
    cpsId = json['cps_id'];
    gameId = json['game_id'];
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    buyNickname = json['buy_nickname'];
    buyUsername = json['buy_username'];
    checkStatusTxt = json['check_status_txt'];
    cps_name = json['cps_name'];
    cps_name = json['server_name'];

    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['mem_id'] = this.memId;
    data['app_id'] = this.appId;
    data['money'] = this.money;
    data['real_money'] = this.realMoney;
    data['payway'] = this.payway;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['pay_time'] = this.payTime;
    data['check_status'] = this.checkStatus;
    data['create_time'] = this.createTime;
    data['username'] = this.username;
    data['check_time'] = this.checkTime;
    data['cps_id'] = this.cpsId;
    data['game_id'] = this.gameId;
    data['game_icon'] = this.gameIcon;
    data['game_name'] = this.gameName;
    data['buy_nickname'] = this.buyNickname;
    data['buy_username'] = this.buyUsername;
    data['check_status_txt'] = this.checkStatusTxt;
    data['discount'] = this.discount;
    return data;
  }
}
