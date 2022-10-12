import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/Service_help_info.dart';

//TODO replace with your own action
enum SecurityAction { action, gotoUpdatePassword, gotoUpdateMobile, update }

class SecurityActionCreator {
  static Action onAction() {
    return const Action(SecurityAction.action);
  }

  static Action gotoUpdatePassword() {
    return const Action(SecurityAction.gotoUpdatePassword);
  }

  static Action gotoUpdateMobile() {
    return const Action(SecurityAction.gotoUpdateMobile);
  }

  static Action update(ServiceInfo serviceInfo) {
    return Action(SecurityAction.update, payload: serviceInfo);
  }
}
