import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/vip/vip_record_list.dart';

class OpenRecordState implements Cloneable<OpenRecordState> {
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  List<String> testDatas = ["123", "456"];

  List<RecordMod> recordList;

  @override
  OpenRecordState clone() {
    return OpenRecordState()
      ..refreshHelperController = refreshHelperController
      ..recordList = recordList
      ..refreshHelper = refreshHelper;
  }
}

OpenRecordState initState(Map<String, dynamic> args) {
  return OpenRecordState();
}
