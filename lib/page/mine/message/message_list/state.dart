import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/model/user/message_list_data.dart';

class MessageListState implements Cloneable<MessageListState> {
  List<Message> messages;
  RefreshHelper refreshHelper = RefreshHelper();
  RefreshHelperController refreshHelperController = RefreshHelperController();

  @override
  MessageListState clone() {
    return MessageListState()
      ..messages = messages
      ..refreshHelperController = refreshHelperController
      ..refreshHelper = refreshHelper;
  }
}

MessageListState initState(Map<String, dynamic> args) {
  return MessageListState()..messages = List();
}
