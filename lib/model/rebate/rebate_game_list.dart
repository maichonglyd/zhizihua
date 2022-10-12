import '../base_model.dart';

class RebateGameList extends BaseModel<Data> {
  RebateGameList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<RebateGame> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<RebateGame>();
      json['list'].forEach((v) {
        list.add(new RebateGame.fromJson(v));
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

class RebateGame {
  int gameId;
  String gameName;
  String gameIcon;
  String amount;
  num minAmount;
  String gameSize;
  List<String> types;

  RebateGame(
      {this.gameId, this.gameName, this.gameIcon, this.amount, this.minAmount});

  RebateGame.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    gameName = json['game_name'];
    gameIcon = json['game_icon'];
    amount = json['amount'];
    minAmount = json['min_amount'];
    gameSize = json['game_size'];
    types = json['game_type'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameId;
    data['game_name'] = this.gameName;
    data['game_icon'] = this.gameIcon;
    data['amount'] = this.amount;
    data['min_amount'] = this.minAmount;
    return data;
  }
}
