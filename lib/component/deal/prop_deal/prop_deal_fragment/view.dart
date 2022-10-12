import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/CustomFloatingActionButtonLocation.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealFragmentState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter adapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    floatingActionButtonLocation: CustomFloatingActionButtonLocation(
        FloatingActionButtonLocation.endDocked, 0, -150),
    floatingActionButton: GestureDetector(
      onTap: () {
        dispatch(PropDealFragmentActionCreator.onGotoSellEdit());
      },
      child: Image.asset(
        "images/icon_n_sale.png",
        height: 60,
        width: 60,
      ),
    ),
    body: state.refreshHelper.getEasyRefresh(
        ListView.builder(
          itemBuilder: adapter.itemBuilder,
          itemCount: adapter.itemCount,
        ), onRefresh: () {
      dispatch(PropDealFragmentActionCreator.getIndexData());
    }, loadMore: (page) {
      dispatch(PropDealFragmentActionCreator.getGoods(page));
    }, controller: state.refreshHelperController),
  );
}
