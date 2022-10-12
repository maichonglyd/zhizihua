import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

class CardList extends BaseModel<CardList> {
  CardList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = CardList.fromJson(jsonRes);
  }
}

class Card {
  String title; //	开通会员卡标题
  String content; //	开通会员卡内容
  int id; //卡片id
  String url; //游戏图片链接
  Card(this.title, this.content, this.id, this.url);

  Card.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['url'] = this.url;
    data['id'] = this.id;

    return data;
  }

//  @override
//  String toString() {
//    return 'Card{name: $name, type: $type, id: $id, url: $url}';
//  }

}
