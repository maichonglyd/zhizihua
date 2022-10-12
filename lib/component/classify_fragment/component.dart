import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/classify/component.dart';
import 'package:flutter_huoshu_app/component/game/game_new_round_list/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ClassifyFragmentTickerProviderStfState<KfFragmentState>
    extends ComponentState<KfFragmentState> with TickerProviderStateMixin {}

mixin ClassifyFragmentTickerProviderMixin<KfFragmentState>
    on Component<KfFragmentState> {
  @override
  ClassifyFragmentTickerProviderStfState<KfFragmentState> createState() =>
      ClassifyFragmentTickerProviderStfState<KfFragmentState>();
}

class ClassifyFragmentComponent extends Component<ClassifyFragmentState>
    with ClassifyFragmentTickerProviderMixin {
  static final String componentName = "ClassifyFragmentComponent";

  ClassifyFragmentComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ClassifyFragmentState>(
              adapter: null,
              slots: <String, Dependent<ClassifyFragmentState>>{
                ClassifyComponent.componentName:
                    ClassifyFragmentConnector() + ClassifyComponent(),
                "first_game_new_round_list":
                    FirstGameNewRoundListFragmentConnector() +
                        GameNewRoundListComponent(),
                "second_game_new_round_list":
                    SecondGameNewRoundListFragmentConnector() +
                        GameNewRoundListComponent(),
                "third_game_new_round_list":
                    ThirdGameNewRoundListFragmentConnector() +
                        GameNewRoundListComponent(),
              }),
        );
}
