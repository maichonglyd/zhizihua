import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';

import '../base_model.dart';
import 'game_bean.dart';

class GameSpecialList extends BaseModel<Data> {
  GameSpecialList.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}
class Data{
  int count;
  List<Game> list;
  TopicData topicData;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['topic_data'] != null) {
      topicData = TopicData.fromJson(json['topic_data']);
    }

    if (json['list'] != null) {
      list = new List<Game>();
      json['list'].forEach((v) {
        list.add(new Game.fromJson(v));
      });
    }
  }
}

class TopicData{
  num topicId;
  String topicName;
  String image;
  num gameId;
  String url;
  String desc;

  TopicData.fromJson(Map<String, dynamic> json) {
    topicId = AppUtil.stringToNum(json['topic_id'].toString());
    topicName = json['topic_name'];
    image = json['image'];
    gameId = AppUtil.stringToNum(json['game_id'].toString());
    url = json['url'];
    desc = json['desc'];
  }
}