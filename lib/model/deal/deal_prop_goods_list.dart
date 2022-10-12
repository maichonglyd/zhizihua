import '../base_model.dart';

class DealPropGoodsListData extends BaseModel<Data> {
  DealPropGoodsListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
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
  int id;
  int goodsId;
  int memId;
  int appId;
  String title;
  String description;
  dynamic price;
  String serverId;
  String serverName;
  String roleId;
  String roleName;
  List<String> image;
  int status;
  int createTime;
  int updateTime;
  int gameId;
  String gameIcon;
  String gameName;
  int isMine;
  Mem mem;

  Goods(
      {this.id,
      this.goodsId,
      this.memId,
      this.appId,
      this.title,
      this.description,
      this.price,
      this.serverId,
      this.serverName,
      this.roleId,
      this.roleName,
      this.image,
      this.status,
      this.createTime,
      this.updateTime,
      this.gameId,
      this.gameIcon,
      this.gameName,
      this.isMine,
      this.mem});

  Goods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsId = json['goods_id'];
    memId = json['mem_id'];
    appId = json['app_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    serverId = json['server_id'];
    serverName = json['server_name'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    image = json['image'].cast<String>();
    status = json['status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    gameId = json['game_id'];
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    isMine = json['is_mine'];
    mem = json['mem'] != null ? new Mem.fromJson(json['mem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goods_id'] = this.goodsId;
    data['mem_id'] = this.memId;
    data['app_id'] = this.appId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['server_id'] = this.serverId;
    data['server_name'] = this.serverName;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['image'] = this.image;
    data['status'] = this.status;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    data['game_id'] = this.gameId;
    data['game_icon'] = this.gameIcon;
    data['game_name'] = this.gameName;
    data['is_mine'] = this.isMine;
    if (this.mem != null) {
      data['mem'] = this.mem.toJson();
    }
    return data;
  }
}

class Mem {
  int id;
  String username;
  String nickname;

  Mem({this.id, this.username, this.nickname});

  Mem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    return data;
  }
}
