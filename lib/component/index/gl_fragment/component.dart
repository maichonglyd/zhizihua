import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_huoshu_app/common/redux_connector/private_action_mixin.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/list_adapter/adapter.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

/// wrapper: keepAliveWrapper这个不加上去,viewService.buildComponent("gl_fragment")这个就会加载错误

class SingleTickerProviderStfState<GlFragmentState>
    extends ComponentState<GlFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<GlFragmentState> on Component<GlFragmentState> {
  @override
  SingleTickerProviderStfState<GlFragmentState> createState() =>
      SingleTickerProviderStfState<GlFragmentState>();
}

class GlFragmentComponent extends Component<GlFragmentState>
    with SingleTickerProviderMixin, ComplexSafeActionMixin<GlFragmentState> {
  static final String componentName = "gl_fragment";
  static final String typeName = "gl";

  GlFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GlFragmentState>(
                adapter: NoneConn<GlFragmentState>() + GlAdapter(),
                slots: <String, Dependent<GlFragmentState>>{}),
            wrapper: keepAliveWrapper);
}
