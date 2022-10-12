import '../base_model.dart';

class DealMyOrderListData extends BaseModel<Data> {
  DealMyOrderListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Order> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Order>();
      json['list'].forEach((v) {
        list.add(new Order.fromJson(v));
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

class Order {
  String orderId;
  int mgMemId;
  String nickname;
  String sellNickname;
  String buyNickname;
  String title;
  int gameId;
  String gameIcon;
  String gameName;
  num price;
  num realPrice;
//  String price;
//  String realPrice;
  String serverId;
  String serverName;
  String roleId;
  String roleName;
  String payway;
  int status;
  int payTime;
  int goodsId;
  List<String> image;
  String description;
  String expiredTime;

  Order(
      {this.orderId,
      this.mgMemId,
      this.nickname,
      this.sellNickname,
      this.buyNickname,
      this.title,
      this.gameId,
      this.gameIcon,
      this.gameName,
      this.price,
      this.realPrice,
      this.serverId,
      this.serverName,
      this.roleId,
      this.roleName,
      this.payway,
      this.status,
      this.payTime,
      this.goodsId,
      this.expiredTime});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    mgMemId = json['mg_mem_id'];
    nickname = json['nickname'];
    sellNickname = json['sell_nickname'];
    buyNickname = json['buy_nickname'];
    title = json['title'];
    gameId = json['game_id'];
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    price = json['price'];
    realPrice = json['real_price'];
    serverId = json['server_id'];
    serverName = json['server_name'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    payway = json['payway'];
    status = json['status'];
    payTime = json['pay_time'];
    goodsId = json['goods_id'];
    description = json['description'];
    image = json['image'] != null ? json['image'].cast<String>() : List();
    expiredTime = json['expired_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['mg_mem_id'] = this.mgMemId;
    data['nickname'] = this.nickname;
    data['sell_nickname'] = this.sellNickname;
    data['buy_nickname'] = this.buyNickname;
    data['title'] = this.title;
    data['game_id'] = this.gameId;
    data['game_icon'] = this.gameIcon;
    data['game_name'] = this.gameName;
    data['price'] = this.price;
    data['real_price'] = this.realPrice;
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['payway'] = this.payway;
    data['status'] = this.status;
    data['pay_time'] = this.payTime;
    data['goods_id'] = this.goodsId;
    return data;
  }
}
