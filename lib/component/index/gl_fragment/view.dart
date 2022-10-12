import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/index/gl_fragment/action.dart';

import 'state.dart';

Widget buildView(
    GlFragmentState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();
  return Container(
    child: state.refreshHelper.getEasyRefresh(
        ListView.builder(
            itemCount: listAdapter.itemCount,
            itemBuilder: listAdapter.itemBuilder), onRefresh: () {
      dispatch(GlFragmentActionCreator.getHomeByGl(1));
    }, loadMore: (page) {
      dispatch(GlFragmentActionCreator.getHomeByGl(page));
    }, controller: state.refreshHelperController),
  );
}
