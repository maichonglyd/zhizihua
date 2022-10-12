import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/base_model.dart';

class TurnGameStopModel extends BaseModel<Data> {
  TurnGameStopModel.fromJson(jsonRes) : super.fromJson(jsonRes);

  @override
  void initialResult(jsonRes) {
    HuoLog.d("initialResult");
    data = Data.fromJson(jsonRes);
  }
}

class Data {
  num count;
  List<TurnGameStopBean> list;

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = List<TurnGameStopBean>();
      json['list'].forEach((v) {
        list.add(TurnGameStopBean.fromJson(v));
      });
    }
  }
}

class TurnGameStopBean {
  num id;
  String name;
  String icon;
  num cumulativeRecharge;
  num intoStatus;

  TurnGameStopBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    cumulativeRecharge = json['cumulative_recharge'];
    intoStatus = json['into_status'];
  }
}

class TurnGameStopStatus {
  static int never = 0;
  static int wait = 1;
  static int success = 2;
  static int fail = 2;
}

String getTurnGameStopStatusText(int status) {
  if (TurnGameStopStatus.never == status) {
    return getText(name: 'textTurnGame');
  } else if (TurnGameStopStatus.wait == status) {
    return getText(name: 'textTurningGame');
  } else if (TurnGameStopStatus.success == status) {
    return getText(name: 'textTurnGameSuccessful');
  } else if (TurnGameStopStatus.fail == status) {
    return getText(name: 'textTurnGameFailed');
  }
  return '';
}
