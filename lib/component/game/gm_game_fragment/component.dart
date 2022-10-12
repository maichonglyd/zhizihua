import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'effect.dart';
import 'list_adapt/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<GMGameFragmentState>
    extends ComponentState<GMGameFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<GMGameFragmentState>
    on Component<GMGameFragmentState> {
  @override
  SingleTickerProviderStfState<GMGameFragmentState> createState() =>
      SingleTickerProviderStfState<GMGameFragmentState>();
}

class GMGameFragmentComponent extends Component<GMGameFragmentState>
    with PrivateReducerMixin<GMGameFragmentState> {
  GMGameFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GMGameFragmentState>(
                adapter: NoneConn<GMGameFragmentState>() + GmGameAdapter(),
                slots: <String, Dependent<GMGameFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
