import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/ptb_consume_record.dart';

//TODO replace with your own action
enum PtbExpenseAction { action, getData, update }

class PtbExpenseActionCreator {
  static Action onAction() {
    return const Action(PtbExpenseAction.action);
  }

  static Action getData(int page) {
    return Action(PtbExpenseAction.getData, payload: page);
  }

  static Action update(List<Consume> consumes) {
    return Action(PtbExpenseAction.update, payload: consumes);
  }
}
