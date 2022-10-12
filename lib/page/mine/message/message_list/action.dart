import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/message_list_data.dart';

//TODO replace with your own action
enum MessageListAction {
  action,
  update,
  gotoDetail,
  getMessages,
  readedMessage,
}

class MessageListActionCreator {
  static Action onAction() {
    return const Action(MessageListAction.action);
  }

  static Action getMessages(int page) {
    return Action(MessageListAction.getMessages, payload: page);
  }

  static Action update(List<Message> messages) {
    return Action(MessageListAction.update, payload: messages);
  }

  static Action gotoDetail(Message message) {
    return Action(MessageListAction.gotoDetail, payload: message);
  }

  static Action readedMessage(Message message) {
    return Action(MessageListAction.readedMessage, payload: message);
  }
}
