import '../base_model.dart';

class DealIndexData extends BaseModel<Data> {
  DealIndexData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int sellingCnt; //	正在出售
  int soldCnt; // 已经出售
  int boughtCnt; //已买到的数量
  List<PlayedGame> playedGame;
  dynamic feeRate; //	Number	交易费率（%）	5
  dynamic minFee; //	Number	最低手续费	5
  dynamic minPrice; //	Number	最低交易金额	6
  Data({this.sellingCnt, this.soldCnt, this.boughtCnt, this.playedGame});

  Data.fromJson(Map<String, dynamic> json) {
    sellingCnt = json['selling_cnt'];
    soldCnt = json['sold_cnt'];
    boughtCnt = json['bought_cnt'];
    feeRate = json['fee_rate'];
    minFee = json['min_fee'];
    minPrice = json['min_price'];
    if (json['played_game'] != null) {
      playedGame = new List<PlayedGame>();
      json['played_game'].forEach((v) {
        playedGame.add(new PlayedGame.fromJson(v));
      });
    } else {
      playedGame = List();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selling_cnt'] = this.sellingCnt;
    data['sold_cnt'] = this.soldCnt;
    data['bought_cnt'] = this.boughtCnt;
    data['fee_rate'] = this.feeRate;
    data['min_fee'] = this.minFee;
    data['min_price'] = this.minPrice;
    if (this.playedGame != null) {
      data['played_game'] = this.playedGame.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Data{sellingCnt: $sellingCnt, soldCnt: $soldCnt, boughtCnt: $boughtCnt, playedGame: $playedGame, feeRate: $feeRate, minFee: $minFee, minPrice: $minPrice}';
  }
}

class PlayedGame {
  int gameId;
  String gameIcon;
  String gameName;
  int accountCnt;

  PlayedGame({this.gameId, this.gameIcon, this.gameName, this.accountCnt});

  PlayedGame.fromJson(Map<String, dynamic> json) {
    gameId = json['game_id'];
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    accountCnt = json['account_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameId;
    data['game_icon'] = this.gameIcon;
    data['game_name'] = this.gameName;
    data['account_cnt'] = this.accountCnt;
    return data;
  }

  @override
  String toString() {
    return 'PlayedGame{gameId: $gameId, gameIcon: $gameIcon, gameName: $gameName, accountCnt: $accountCnt}';
  }
}
