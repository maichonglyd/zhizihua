import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameDetailsComponentState state, Dispatch dispatch,
    ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Container(
    padding: EdgeInsets.only(top: 16),
    child: state.refreshHelper.getEasyRefresh(
      ListView.builder(
        padding: EdgeInsets.all(0),
        itemBuilder: listAdapter.itemBuilder,
        itemCount: listAdapter.itemCount,
      ),
      controller: state.refreshHelperController,
    ),
  );
}
