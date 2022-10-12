import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/component/index/bt_fragment/list_adapter/adapter.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/component/index/index_top_tab/component.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<ZKFragmentState>
    extends ComponentState<ZKFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<ZKFragmentState> on Component<ZKFragmentState> {
  @override
  SingleTickerProviderStfState<ZKFragmentState> createState() =>
      SingleTickerProviderStfState<ZKFragmentState>();
}

class ZKFragmentComponent extends Component<ZKFragmentState>
    with SingleTickerProviderMixin {
  static final String componentName = "zk_fragment";
  static const String typeName = "rate";
  ZKFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ZKFragmentState>(
                adapter: NoneConn<ZKFragmentState>() + ZKListAdapter(),
                slots: <String, Dependent<ZKFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
