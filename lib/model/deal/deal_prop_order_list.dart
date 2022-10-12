import '../base_model.dart';

class DealPropOrderListData extends BaseModel<Data> {
  DealPropOrderListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
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
  String sellNickname;
  String buyNickname;
  String title;
  int gameId;
  String gameIcon;
  String gameName;
  String gamename;
  String price;
  String realPrice;
  String serverId;
  String serverName;
  String roleId;
  String roleName;
  String payway;
  int status;
  int payTime;
  String expired_time;

  Order(
      {this.orderId,
      this.sellNickname,
      this.buyNickname,
      this.title,
      this.gameId,
      this.gameIcon,
      this.gameName,
      this.gamename,
      this.price,
      this.realPrice,
      this.serverId,
      this.serverName,
      this.roleId,
      this.roleName,
      this.payway,
      this.status,
      this.payTime});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    sellNickname = json['sell_nickname'];
    buyNickname = json['buy_nickname'];
    title = json['title'];
    gameId = json['game_id'];
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    gamename = json['gamename'];
    price = json['price'];
    realPrice = json['real_price'];
    serverId = json['server_id'];
    serverName = json['server_name'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    payway = json['payway'];
    status = json['status'];
    payTime = json['pay_time'];
    expired_time = json['expired_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['sell_nickname'] = this.sellNickname;
    data['buy_nickname'] = this.buyNickname;
    data['title'] = this.title;
    data['game_id'] = this.gameId;
    data['game_icon'] = this.gameIcon;
    data['game_name'] = this.gameName;
    data['gamename'] = this.gamename;
    data['price'] = this.price;
    data['real_price'] = this.realPrice;
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['payway'] = this.payway;
    data['status'] = this.status;
    data['pay_time'] = this.payTime;
    return data;
  }
}
