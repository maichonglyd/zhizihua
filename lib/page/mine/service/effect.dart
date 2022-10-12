import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'action.dart';
import 'state.dart';
import 'package:url_launcher/url_launcher.dart';

Effect<ServiceState> buildEffect() {
  return combineEffects(<Object, Effect<ServiceState>>{
    ServiceAction.action: _onAction,
    ServiceAction.openCall: _openCall,
    ServiceAction.openQQ: _openQQ,
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<ServiceState> ctx) {}
void _openCall(Action action, Context<ServiceState> ctx) {
  launch("tel:${ctx.state.serviceInfo.data.tel}");
}

void _openQQ(Action action, Context<ServiceState> ctx) {
  print("mqq://im/chat?chat_type=wpa&uin=${ctx.state.serviceInfo.data.qq[0]}");
  launch(
      "mqq://im/chat?chat_type=wpa&uin=${ctx.state.serviceInfo.data.qq[0]}&version=1&src_type=web");
}

void _init(Action action, Context<ServiceState> ctx) {
  UserService.getServiceInfo().then((data) {
    if (data.code == 200) {
      ctx.dispatch(ServiceActionCreator.update(data));
    }
  });
}
