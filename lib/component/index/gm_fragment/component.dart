import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/game/gm_game_fragment/component.dart';
import 'package:flutter_huoshu_app/component/index/index_banner/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class SingleTickerProviderStfState<GmFragmentState>
    extends ComponentState<GmFragmentState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<GmFragmentState> on Component<GmFragmentState> {
  @override
  SingleTickerProviderStfState<GmFragmentState> createState() =>
      SingleTickerProviderStfState<GmFragmentState>();
}

class GmFragmentComponent extends Component<GmFragmentState>
    with SingleTickerProviderMixin {
  static final String componentName = "gm_fragment";
  static final String typeName = "gm";
  GmFragmentComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<GmFragmentState>(
                adapter: null,
                slots: <String, Dependent<GmFragmentState>>{
                  "gmgame_fragment":
                      GMGameFragmentConnector() + GMGameFragmentComponent(),
                  "gmhelp_fragment":
                      GMHelpFragmentConnector() + GMGameFragmentComponent(),
                  IndexBannerComponent.componentName:
                      IndexBannerConnector() + IndexBannerComponent(),
                }),
            wrapper: keepAliveWrapper);
}
