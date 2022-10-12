import '../base_model.dart';

class GoodsListData extends BaseModel<Data> {
  GoodsListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Goods> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Goods>();
      json['list'].forEach((v) {
        list.add(new Goods.fromJson(v));
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

class Goods {
  int goodsId;
  int gameId;
  String goodsName;
  int isReal;
  int storeCnt;
  int remainCnt;
  String marketPrice;
  String goodsIntro;
  String initial;
  String originalImg;
  String integral;
  int mobilePrefix;
  String gameName;
  String gameTag;

  Goods(
      {this.goodsId,
      this.gameId,
      this.goodsName,
      this.isReal,
      this.storeCnt,
      this.remainCnt,
      this.marketPrice,
      this.goodsIntro,
      this.initial,
      this.originalImg,
      this.integral,
      this.mobilePrefix,
      this.gameName,
      this.gameTag});

  Goods.fromJson(Map<String, dynamic> json) {
    goodsId = json['goods_id'];
    gameId = json['game_id'];
    goodsName = json['goods_name'];
    isReal = json['is_real'];
    storeCnt = json['store_cnt'];
    remainCnt = json['remain_cnt'];
    marketPrice = json['market_price'];
    goodsIntro = json['goods_intro'];
    initial = json['initial'];
    originalImg = json['original_img'];
    integral = json['integral'];
    mobilePrefix = json['mobile_prefix'];
    gameName = json['game_name'];
    gameTag = json['game_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_id'] = this.goodsId;
    data['game_id'] = this.gameId;
    data['goods_name'] = this.goodsName;
    data['is_real'] = this.isReal;
    data['store_cnt'] = this.storeCnt;
    data['remain_cnt'] = this.remainCnt;
    data['market_price'] = this.marketPrice;
    data['goods_intro'] = this.goodsIntro;
    data['initial'] = this.initial;
    data['original_img'] = this.originalImg;
    data['integral'] = this.integral;
    data['mobile_prefix'] = this.mobilePrefix;
    data['game_name'] = this.gameName;
    data['game_tag'] = this.gameTag;
    return data;
  }
}
