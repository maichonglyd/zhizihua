import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

///vip会员特权四个功能项
class VIPPrivilegeComponent extends Component<VIPPrivilegeState> {
  static final componentName = "VIPPrivilegeComponent";
  VIPPrivilegeComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<VIPPrivilegeState>(
              adapter: null, slots: <String, Dependent<VIPPrivilegeState>>{}),
        );
}
