import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

import 'package:flutter_huoshu_app/component/vip/vip_privilege/component.dart'
    as vip_fun;

class MemberCenterPage extends Page<MemberCenterState, Map<String, dynamic>> {
  static final String pageName = "MemberCenterPage";

  MemberCenterPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MemberCenterState>(
              adapter: null,
              slots: <String, Dependent<MemberCenterState>>{
//                  vip_fun.VIPPrivilegeComponent.componentName:
//                  VIPFuncConnector() + vip_fun.VIPPrivilegeComponent(),
              }),
          middleware: <Middleware<MemberCenterState>>[],
        );
}
