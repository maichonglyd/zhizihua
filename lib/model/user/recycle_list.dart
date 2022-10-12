import '../base_model.dart';

class RecycleList extends BaseModel<Data> {
  RecycleList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  double sumMoney;
  List<RecycleMg> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['sum_money'] != null)
      sumMoney = double.parse(json['sum_money'].toString());
    if (json['list'] != null) {
      list = new List<RecycleMg>();
      json['list'].forEach((v) {
        list.add(new RecycleMg.fromJson(v));
      });
    } else {
      list = List();
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

class RecycleMg {
  int adminMemId;
  String adminmen;
  String adminpwd;
  double amount;
  int appId;
  int backExpireTime;
  int backStatus;
  int backTime;
  int createTime;
  int deleteTime;
  String gameName;
  int gameid;
  String icon;
  int id;
  int isDelete;
  int memId;
  int mgMemId;
  String nickname;
  double rate;
  int status;
  String sumMoney;
  int updateTime;

  RecycleMg(
      {this.adminMemId,
      this.adminmen,
      this.adminpwd,
      this.amount,
      this.appId,
      this.backExpireTime,
      this.backStatus,
      this.backTime,
      this.createTime,
      this.deleteTime,
      this.gameName,
      this.gameid,
      this.icon,
      this.id,
      this.isDelete,
      this.memId,
      this.mgMemId,
      this.nickname,
      this.rate,
      this.status,
      this.sumMoney,
      this.updateTime});

  RecycleMg.fromJson(Map<String, dynamic> json) {
    adminMemId = json['admin_mem_id'];
    adminmen = json['adminmen'];
    adminpwd = json['adminpwd'];
    if (json['amount'] != null) {
      amount = double.parse(json['amount'].toString());
    } else {
      amount = 0;
    }
    appId = json['app_id'];
    backExpireTime = json['back_expire_time'];
    backStatus = json['back_status'];
    backTime = json['back_time'];
    createTime = json['create_time'];
    deleteTime = json['delete_time'];
    gameName = json['game_name'];
    gameid = json['game_id'];
    icon = json['game_icon'];
    id = json['id'];
    isDelete = json['is_delete'];
    memId = json['mem_id'];
    mgMemId = json['mg_mem_id'];
    nickname = json['nickname'];
    rate = double.parse(json['rate'].toString());
    status = json['status'];
    sumMoney = json['sum_money'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_mem_id'] = this.adminMemId;
    data['adminmen'] = this.adminmen;
    data['adminpwd'] = this.adminpwd;
    data['amount'] = this.amount;
    data['app_id'] = this.appId;
    data['back_expire_time'] = this.backExpireTime;
    data['back_status'] = this.backStatus;
    data['back_time'] = this.backTime;
    data['create_time'] = this.createTime;
    data['delete_time'] = this.deleteTime;
    data['game_name'] = this.gameName;
    data['gameid'] = this.gameid;
    data['game_icon'] = this.icon;
    data['id'] = this.id;
    data['is_delete'] = this.isDelete;
    data['mem_id'] = this.memId;
    data['mg_mem_id'] = this.mgMemId;
    data['nickname'] = this.nickname;
    data['rate'] = this.rate;
    data['status'] = this.status;
    data['sum_money'] = this.sumMoney;
    data['update_time'] = this.updateTime;
    return data;
  }
}

class RecycleGame {
  int gameId;
  String icon;
  String gameName;
  String rate;
  List<RecycleMg> recycleMgs;

  RecycleGame(
      this.gameId, this.icon, this.gameName, this.rate, this.recycleMgs);
}
