import '../base_model.dart';

class RebateRecordList extends BaseModel<Data> {
  RebateRecordList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<RebateRecord> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<RebateRecord>();
      json['list'].forEach((v) {
        list.add(new RebateRecord.fromJson(v));
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

class RebateRecord {
  int id;
  int appId;
  String orderId;
  num amount;
  int status;
  String statusTxt;
  int applyTime;
  int gameId;
  String gameName;
  String icon;
  int cpId;

  RebateRecord(
      {this.id,
      this.appId,
      this.orderId,
      this.amount,
      this.status,
      this.statusTxt,
      this.applyTime,
      this.gameId,
      this.gameName,
      this.icon,
      this.cpId});

  RebateRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appId = json['app_id'];
    orderId = json['order_id'];
    amount = json['amount'];
    status = json['status'];
    statusTxt = json['status_txt'];
    applyTime = json['apply_time'];
    gameId = json['game_id'];
    gameName = json['game_name'];
    icon = json['icon'];
    cpId = json['cp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_id'] = this.appId;
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['status_txt'] = this.statusTxt;
    data['apply_time'] = this.applyTime;
    data['game_id'] = this.gameId;
    data['game_name'] = this.gameName;
    data['icon'] = this.icon;
    data['cp_id'] = this.cpId;
    return data;
  }
}
