import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/index/index_bt_fragment/action.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/user/message_list_data.dart';

Effect<MessageListState> buildEffect() {
  return combineEffects(<Object, Effect<MessageListState>>{
    MessageListAction.action: _onAction,
    MessageListAction.gotoDetail: _gotoDetail,
    MessageListAction.getMessages: _getMessages,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<MessageListState> ctx) {}

void _getMessages(Action action, Context<MessageListState> ctx) {
  UserService.getMessages(action.payload, 10).then((data) {
    if (data.code == 200) {
      var newData = ctx.state.refreshHelperController.controllerRefresh(
          data.data.list, ctx.state.messages, action.payload);
      ctx.dispatch(MessageListActionCreator.update(newData));
    }
  });
}

void _gotoDetail(Action action, Context<MessageListState> ctx) {
  Message message = action.payload;

  AppUtil.gotoH5Web(ctx.context, message.viewUrl, title: message.title)
      .then((data) {
    ctx.dispatch(MessageListActionCreator.readedMessage(message));
  });
}

void _init(Action action, Context<MessageListState> ctx) {
  ctx.dispatch(MessageListActionCreator.getMessages(1));
}
