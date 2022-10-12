import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingleTickerProviderStfState<IndexTabTitleState>
    extends ComponentState<IndexTabTitleState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<IndexTabTitleState>
    on Component<IndexTabTitleState> {
  @override
  SingleTickerProviderStfState<IndexTabTitleState> createState() =>
      SingleTickerProviderStfState<IndexTabTitleState>();
}

class IndexTabTitleComponent extends Component<IndexTabTitleState>
    with SingleTickerProviderMixin {
  static final String componentName = "IndexTabTitleComponent";
  IndexTabTitleComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<IndexTabTitleState>(
              adapter: null, slots: <String, Dependent<IndexTabTitleState>>{}),
        );
}
