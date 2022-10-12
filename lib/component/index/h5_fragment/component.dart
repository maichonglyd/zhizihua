import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

import 'effect.dart';
import 'list_adapter/adapter.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

export 'state.dart';

import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<H5FragmentState>
    extends ComponentState<H5FragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<H5FragmentState> on Component<H5FragmentState> {
  @override
  SingleTickerProviderStfState<H5FragmentState> createState() =>
      SingleTickerProviderStfState<H5FragmentState>();
}

class H5FragmentComponent extends Component<H5FragmentState>
    with SingleTickerProviderMixin {
  static final String componentName = "h5_fragment";
  static const String typeName = "h5";
  H5FragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<H5FragmentState>(
                adapter: NoneConn<H5FragmentState>() + H5ListAdapter(),
                slots: <String, Dependent<H5FragmentState>>{}),
            wrapper: keepAliveWrapper);
}
