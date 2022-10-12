import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';

class IndexTopTabModel extends BaseModel<Data> {
  IndexTopTabModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num count;
  List<IndexTopTabBean> list;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<IndexTopTabBean>();
      json['list'].forEach((v) {
        list.add(IndexTopTabBean.fromJson(v));
      });
    }
  }
}

class IndexTopTabBean {
  int topicId;
  String topicName;
  String topicKey;
  String image;
  int gameId;
  String gameUrl;
  String topicIcon;

  IndexTopTabBean.fromJson(Map<String, dynamic> json) {
    topicId = json['topic_id'];
    topicName = json['topic_name'];
    topicKey = json['topic_key'];
    image = json['image'];
    gameId = json['game_id'];
    gameUrl = json['game_url'];
    topicIcon = json['topic_icon'];
  }
}
