import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';

//TODO replace with your own action
enum OpenRecordAction { action, updateRecordList, getRecordList }

class OpenRecordActionCreator {
  static Action onAction() {
    return const Action(OpenRecordAction.action);
  }

  static Action updateRecordList(List<RecordMod> recordList) {
    return Action(OpenRecordAction.updateRecordList, payload: recordList);
  }

  static Action getRecordList(int page) {
    return Action(OpenRecordAction.getRecordList, payload: page);
  }
}
