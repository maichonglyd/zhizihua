import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

class GameMod extends BaseModel<GameMod> {
  GameMod.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = GameMod.fromJson(jsonRes);
  }
}

class Item {
  String name; //	STRING	游戏名称
  String type; //	STRING	游戏类别
  int id; //游戏id
  String url; //游戏图片链接
  Item(this.name, this.type, this.id, this.url);

  Item.fromJson(Map<String, dynamic> json) {
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
    return 'Item{name: $name, type: $type, id: $id, url: $url}';
  }
}
