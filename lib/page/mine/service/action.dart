import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/Service_help_info.dart';

//TODO replace with your own action
enum ServiceAction { action, update, openCall, openQQ }

class ServiceActionCreator {
  static Action onAction() {
    return const Action(ServiceAction.action);
  }

  static Action openCall() {
    return const Action(ServiceAction.openCall);
  }

  static Action openQQ() {
    return const Action(ServiceAction.openQQ);
  }

  static Action update(ServiceInfo serviceInfo) {
    return Action(ServiceAction.update, payload: serviceInfo);
  }
}
