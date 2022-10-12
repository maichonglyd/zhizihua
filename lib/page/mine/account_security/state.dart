import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/Service_help_info.dart';

class SecurityState implements Cloneable<SecurityState> {
  ServiceInfo serviceInfo;
  @override
  SecurityState clone() {
    return SecurityState()..serviceInfo = serviceInfo;
  }
}

SecurityState initState(Map<String, dynamic> args) {
  return SecurityState();
}
