import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GMGameFragmentState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();

  return state.refreshHelper.getEasyRefresh(
    ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listAdapter.itemCount,
        itemBuilder: listAdapter.itemBuilder),
    onRefresh: () {
      dispatch(GMGameFragmentActionCreator.getGmGameData(1));
    },
    loadMore: (page) {
      dispatch(GMGameFragmentActionCreator.getGmGameData(page));
    },
    controller: state.refreshHelperController,
  );
}
