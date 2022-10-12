import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

class Mod extends BaseModel<ModData> {
  Mod.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = ModData.fromJson(jsonRes);
  }
}

class ModData {
  String name; //	STRING	首页标签
  String type; //	STRING	首页标签type="bt",type="jp"
  String listOrder;

  //是否选中
  bool isSelected;

  ModData(this.name, this.type, this.listOrder, this.isSelected);

  ModData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    listOrder = json['list_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['list_order'] = this.listOrder;
    return data;
  }

  @override
  String toString() {
    return 'ModData{name: $name, type: $type, listOrder: $listOrder}';
  }
}

class Game {
  String name; //	STRING	游戏名称
  String type; //	STRING	游戏类别
  int id; //游戏id
  String url; //游戏图片链接
  Game(this.name, this.type, this.id, this.url);

  Game.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['url'] = this.url;
    data['id'] = this.id;

    return data;
  }

  @override
  String toString() {
    return 'Game{name: $name, type: $type, id: $id, url: $url}';
  }
}
