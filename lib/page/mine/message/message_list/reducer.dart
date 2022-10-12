import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import 'package:flutter_huoshu_app/model/user/message_list_data.dart';

Reducer<MessageListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MessageListState>>{
      MessageListAction.action: _onAction,
      MessageListAction.update: update,
      MessageListAction.readedMessage: _readedMessage,
    },
  );
}

MessageListState _onAction(MessageListState state, Action action) {
  final MessageListState newState = state.clone();
  return newState;
}

MessageListState update(MessageListState state, Action action) {
  final MessageListState newState = state.clone();
  newState.messages = action.payload;
  return newState;
}

MessageListState _readedMessage(MessageListState state, Action action) {
  Message message = action.payload;
  message.status = 2;
  final MessageListState newState = state.clone();
  return newState;
}
