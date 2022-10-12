import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    DownLoadGameListState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return ListView.builder(
    itemBuilder: listAdapter.itemBuilder,
    itemCount: listAdapter.itemCount,
  );
}
