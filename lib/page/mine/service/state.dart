import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/model/user/Service_help_info.dart';

class ServiceState implements Cloneable<ServiceState> {
  ServiceInfo serviceInfo;
  @override
  ServiceState clone() {
    return ServiceState()..serviceInfo = serviceInfo;
  }
}

ServiceState initState(Map<String, dynamic> args) {
  return ServiceState();
}
