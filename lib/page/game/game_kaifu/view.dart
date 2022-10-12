import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    KaifuGameState state, Dispatch dispatch, ViewService viewService) {
  return null == state.kfFragmentState
      ? Container()
      : Container(
          child: viewService.buildComponent("kf_fragment"),
        );
}
