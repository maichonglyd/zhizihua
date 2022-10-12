import '../base_model.dart';

class DealPropOrderDetailsData extends BaseModel<OrderDetails> {
  DealPropOrderDetailsData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    data = OrderDetails.fromJson(jsonRes);
  }
}

class OrderDetails {
  String orderId;
  int goodsId;
  String title;
  int gameId;
  String serverId;
  String serverName;
  String description;
  List<String> image;
  String gameIcon;
  String gameName;
  String price;
  String realPrice;
  String buyServerName;
  String buyRoleName;
  String payway;
  int status;
  int payTime;
  int expiredTime;
  int finishTime;

  OrderDetails(
      {this.orderId,
      this.goodsId,
      this.title,
      this.gameId,
      this.serverId,
      this.serverName,
      this.description,
      this.image,
      this.gameIcon,
      this.gameName,
      this.price,
      this.realPrice,
      this.buyServerName,
      this.buyRoleName,
      this.payway,
      this.status,
      this.payTime,
      this.expiredTime,
      this.finishTime});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    goodsId = json['goods_id'];
    title = json['title'];
    gameId = json['game_id'];
    serverId = json['server_id'];
    serverName = json['server_name'];
    description = json['description'];
    image = json['image'].cast<String>();
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    price = json['price'];
    realPrice = json['real_price'];
    buyServerName = json['buy_server_name'];
    buyRoleName = json['buy_role_name'];
    payway = json['payway'];
    status = json['status'];
    payTime = json['pay_time'];
    expiredTime = json['expired_time'];
    finishTime = json['finish_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['goods_id'] = this.goodsId;
    data['title'] = this.title;
    data['game_id'] = this.gameId;
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['game_icon'] = this.gameIcon;
    data['game_name'] = this.gameName;
    data['price'] = this.price;
    data['real_price'] = this.realPrice;
    data['buy_server_name'] = this.buyServerName;
    data['buy_role_name'] = this.buyRoleName;
    data['payway'] = this.payway;
    data['status'] = this.status;
    data['pay_time'] = this.payTime;
    data['expired_time'] = this.expiredTime;
    data['finish_time'] = this.finishTime;
    return data;
  }
}
