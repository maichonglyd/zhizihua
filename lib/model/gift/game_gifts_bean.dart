import '../base_model.dart';

class GameGiftBean extends BaseModel<Data> {
  GameGiftBean.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Gift> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Gift>();
      json['list'].forEach((v) {
        list.add(new Gift.fromJson(v));
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

class Gift {
  int id;
  int giftId;
  int appId;
  int gameId;
  String title;
  int totalCnt;
  int remainCnt;
  String content;
  int startTime;
  int endTime;
  int deadTime;
  String scope;
  String func;
  int giftType;
  num condition;
  int qqId;
  String gameName;
  String gameIcon;
  int classify;
  String giftCode;

  Gift(
      {this.id,
      this.giftId,
      this.appId,
      this.gameId,
      this.title,
      this.totalCnt,
      this.remainCnt,
      this.content,
      this.startTime,
      this.endTime,
      this.deadTime,
      this.scope,
      this.func,
      this.giftType,
      this.condition,
      this.qqId,
      this.gameName,
      this.gameIcon,
      this.classify,
      this.giftCode});

  Gift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    giftId = json['gift_id'];
    appId = json['app_id'];
    gameId = json['game_id'];
    title = json['title'];
    totalCnt = json['total_cnt'];
    remainCnt = json['remain_cnt'];
    content = json['content'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    deadTime = json['dead_time'];
    scope = json['scope'];
    func = json['func'];
    giftType = json['gift_type'];
    condition = json['condition'];
    qqId = json['qq_id'];
    gameName = json['game_name'];
    gameIcon = json['game_icon'];
    classify = json['classify'];
    giftCode = json['gift_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gift_id'] = this.giftId;
    data['app_id'] = this.appId;
    data['game_id'] = this.gameId;
    data['title'] = this.title;
    data['total_cnt'] = this.totalCnt;
    data['remain_cnt'] = this.remainCnt;
    data['content'] = this.content;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['dead_time'] = this.deadTime;
    data['scope'] = this.scope;
    data['func'] = this.func;
    data['gift_type'] = this.giftType;
    data['condition'] = this.condition;
    data['qq_id'] = this.qqId;
    data['game_name'] = this.gameName;
    data['game_icon'] = this.gameIcon;
    data['classify'] = this.classify;
    data['gift_code'] = this.giftCode;
    return data;
  }
}
