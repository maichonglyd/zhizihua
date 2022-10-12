import '../base_model.dart';

class MemListData extends BaseModel<Data> {
  MemListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Mem> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Mem>();
      json['list'].forEach((v) {
        list.add(new Mem.fromJson(v));
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

class Mem {
  int id;
  String username;
  int createTime;
  String regMobile;
  String gameName;

  Mem({this.id, this.username, this.createTime, this.regMobile, this.gameName});

  Mem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    createTime = json['create_time'];
    regMobile = json['reg_mobile'];
    gameName = json['game_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['create_time'] = this.createTime;
    data['reg_mobile'] = this.regMobile;
    data['game_name'] = this.gameName;
    return data;
  }
}
