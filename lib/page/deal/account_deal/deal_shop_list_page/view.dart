import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DealShopListPageState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
      appBar: AppBar(
        title: huoTitle(state.playedGame.gameName),
        centerTitle: true,
      ),
      body: state.refreshHelper.getEasyRefresh(
          ListView.builder(
              itemBuilder: listAdapter.itemBuilder,
              itemCount: listAdapter.itemCount), onRefresh: () {
        dispatch(DealShopListPageActionCreator.onGetData(1));
      }, loadMore: (page) {
        dispatch(DealShopListPageActionCreator.onGetData(page));
      }, controller: state.refreshHelperController));
}
