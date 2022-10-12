import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexSelectProviderStfState<IndexSelectTabState>
    extends ComponentState<IndexSelectTabState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<IndexSelectTabState>
    on Component<IndexSelectTabState> {
  @override
  IndexSelectProviderStfState<IndexSelectTabState> createState() =>
      IndexSelectProviderStfState<IndexSelectTabState>();
}

class IndexSelectTabComponent extends Component<IndexSelectTabState>
    with SingleTickerProviderMixin {
  static final String componentName = "IndexSelectTabComponent";
  IndexSelectTabComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IndexSelectTabState>(
                adapter: null,
                slots: <String, Dependent<IndexSelectTabState>>{}),
            wrapper: keepAliveWrapper);
}
