import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();
  return state.refreshHelper.getEasyRefresh(
      ListView.builder(
        itemBuilder: listAdapter.itemBuilder,
        itemCount: listAdapter.itemCount,
      ), onRefresh: () {
    dispatch(GameListActionCreator.getData(1));
  }, loadMore: (page) {
    dispatch(GameListActionCreator.getData(page));
  }, controller: state.refreshHelperController);
}
