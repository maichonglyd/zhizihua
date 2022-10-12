import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    JpFragmentState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();
  return Container(
    child: state.refreshHelper.getEasyRefresh(
        ListView.builder(
            itemCount: listAdapter.itemCount,
            itemBuilder: listAdapter.itemBuilder), onRefresh: () {
      dispatch(JpFragmentActionCreator.getHomeByJp(1));
    }, loadMore: (page) {
      dispatch(JpFragmentActionCreator.getHomeByJp(page));
    }, controller: state.refreshHelperController),
  );
}
