class DealGoods {
  int id;
  int goodsId;
  int memId;
  int appId;
  int mgMemId;
  String title;
  String description;
  String price;
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
  Mg mg;
  Mem mem;

  String sumMoney;
  int isMine;
  int isBt;
  String gamePublicity;

  DealGoods(
      {this.id,
      this.goodsId,
      this.memId,
      this.appId,
      this.mgMemId,
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
      this.mg,
      this.mem,
      this.sumMoney,
      this.isMine,
      this.isBt,
      this.gamePublicity});

  DealGoods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsId = json['goods_id'];
    memId = json['mem_id'];
    appId = json['app_id'];
    mgMemId = json['mg_mem_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'].toString();
    serverId = json['server_id'];
    serverName = json['server_name'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    image = json['image'] != null ? json['image'].cast<String>() : List();
    status = json['status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    gameId = json['game_id'];
    gameIcon = json['game_icon'];
    gameName = json['game_name'];
    mg = json['mg'] != null ? new Mg.fromJson(json['mg']) : null;
    mem = json['mem'] != null ? new Mem.fromJson(json['mem']) : null;

    sumMoney = json['sum_money'].toString();
    isMine = json['is_mine'];
    isBt = json['is_bt'];
    gamePublicity = json['game_publicity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['goods_id'] = this.goodsId;
    data['mem_id'] = this.memId;
    data['app_id'] = this.appId;
    data['mg_mem_id'] = this.mgMemId;
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
    if (this.mg != null) {
      data['mg'] = this.mg.toJson();
    }
    if (this.mem != null) {
      data['mem'] = this.mem.toJson();
    }
    data['sum_money'] = this.sumMoney;
    data['is_mine'] = this.isMine;
    data['is_bt'] = this.isBt;
    return data;
  }
}

class Mg {
  int id;
  String nickname;

  Mg({this.id, this.nickname});

  Mg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
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
