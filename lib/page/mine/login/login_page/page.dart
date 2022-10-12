import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/widget/app_localization.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SingleTickerProviderStfState<LoginState>
    extends ComponentState<LoginState> with TickerProviderStateMixin {}

mixin SingleTickerProviderMixin<LoginState> on Component<LoginState> {
  @override
  SingleTickerProviderStfState<LoginState> createState() =>
      SingleTickerProviderStfState<LoginState>();
}

class LoginPage extends Page<LoginState, Map<String, dynamic>>
    with SingleTickerProviderMixin {
  static final String pageName = "LoginPage";

  LoginPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<LoginState>(
              slots: <String, Dependent<LoginState>>{}),
        );
}
