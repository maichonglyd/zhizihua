import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';

class TurnGameModel extends BaseModel<Data> {
  TurnGameModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num count;
  List<TurnGameBean> list;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<TurnGameBean>();
      json['list'].forEach((v) {
        list.add(TurnGameBean.fromJson(v));
      });
    }
  }
}

class TurnGameBean {
  num activityId;
  num startTime;
  num endTime;
  num highestReward;
  TurnGame game;

  TurnGameBean.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    highestReward = json['highest_reward'];
    game = TurnGame.fromJson(json['game']);
  }
}

class TurnGame {
  num id;
  String name;
  String icon;
  List<String> type;
  num userCnt;
  num starCnt;

  TurnGame.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    type = null != json['type'] ? json['type'].cast<String>() : [];
    userCnt = json['user_cnt'];
    starCnt = json['start_cnt'];
  }
}
