import '../base_model.dart';

class MessageListData extends BaseModel<Data> {
  MessageListData.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    print("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  int count;
  List<Message> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<Message>();
      json['list'].forEach((v) {
        list.add(new Message.fromJson(v));
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

class Message {
  int id;
  String title;
  int appId;
  int gameId;
  int type;
  int createTime;
  String content;
//  Null game;
  String viewUrl;
  int status;

  Message(
      {this.id,
      this.title,
      this.appId,
      this.gameId,
      this.type,
      this.createTime,
      this.content,
//        this.game,
      this.viewUrl,
      this.status});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    appId = json['app_id'];
    gameId = json['game_id'];
    type = json['type'];
    createTime = json['create_time'];
    content = json['content'];
//    game = json['game']!=null?json['game'];
    viewUrl = json['view_url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['app_id'] = this.appId;
    data['game_id'] = this.gameId;
    data['type'] = this.type;
    data['create_time'] = this.createTime;
    data['content'] = this.content;
//    data['game'] = this.game;
    data['view_url'] = this.viewUrl;
    data['status'] = this.status;
    return data;
  }
}
