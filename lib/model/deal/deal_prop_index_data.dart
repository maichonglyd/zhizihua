import '../base_model.dart';

class DealPropIndexData extends BaseModel<Data> {
  DealPropIndexData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int sellCnt; //	正在出售
  int boughtCnt; //已买到的数量
  dynamic feeRate; //	Number	交易费率（%）	5
  dynamic minFee; //	Number	最低手续费	5
  dynamic minPrice; //	Number	最低交易金额	6
  Data({this.sellCnt, this.boughtCnt});

  Data.fromJson(Map<String, dynamic> json) {
    sellCnt = json['sell_cnt'];
    boughtCnt = json['bought_cnt'];
    feeRate = json['fee_rate'];
    minFee = json['min_fee'];
    minPrice = json['min_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sell_cnt'] = this.sellCnt;
    data['bought_cnt'] = this.boughtCnt;
    data['fee_rate'] = this.feeRate;
    data['min_fee'] = this.minFee;
    data['min_price'] = this.minPrice;
    return data;
  }
}

class PlayedGame {
  int gameId;
  String gameIcon;
  String gameName;
  int materialCnt;

  PlayedGame({this.gameId, this.gameIcon, this.gameName, this.materialCnt});

  PlayedGame.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    materialCnt = json['material_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameId;
    data['game_icon'] = this.gameIcon;
    data['game_name'] = this.gameName;
    data['material_cnt'] = this.materialCnt;
    return data;
  }
}
