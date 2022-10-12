import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<HtFragmentState>
    extends ComponentState<HtFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<HtFragmentState> on Component<HtFragmentState> {
  @override
  SingleTickerProviderStfState<HtFragmentState> createState() =>
      SingleTickerProviderStfState<HtFragmentState>();
}

class HtFragmentComponent extends Component<HtFragmentState>
    with SingleTickerProviderMixin {
  static final String componentName = "HtFragmentComponent";

  HtFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HtFragmentState>(
                adapter: NoneConn<HtFragmentState>() + HtListAdapter(),
                slots: <String, Dependent<HtFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
