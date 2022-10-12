import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/share_men_list_data.dart';

class InviteListState implements Cloneable<InviteListState> {
  List<Mem> mems;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();
  @override
  InviteListState clone() {
    return InviteListState()
      ..mems = mems
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

InviteListState initState(Map<String, dynamic> args) {
  return InviteListState()..mems = List();
}
