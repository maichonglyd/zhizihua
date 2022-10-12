import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

import 'package:flutter_huoshu_app/widget/keep_alive.dart';

class ActivityListComponent extends Component<ActivityListState>
    with PrivateReducerMixin<ActivityListState> {
  static final String componentName = "ActivityListComponent";

  ActivityListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ActivityListState>(
                adapter: null, slots: <String, Dependent<ActivityListState>>{}),
            wrapper: keepAliveWrapper);
}
