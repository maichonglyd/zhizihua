import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<BtFragmentState>
    extends ComponentState<BtFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<BtFragmentState> on Component<BtFragmentState> {
  @override
  SingleTickerProviderStfState<BtFragmentState> createState() =>
      SingleTickerProviderStfState<BtFragmentState>();
}

class BtFragmentComponent extends Component<BtFragmentState>
    with SingleTickerProviderMixin {
  static final String componentName = "bt_fragment";
  static const String typeName = "bt";
  BtFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<BtFragmentState>(
                adapter: NoneConn<BtFragmentState>() + BTListAdapter(),
                slots: <String, Dependent<BtFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
