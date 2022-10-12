import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/CustomFloatingActionButtonLocation.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexDealFragmentState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    body: state.refreshHelper.getEasyRefresh(
      ListView.builder(
        itemBuilder: listAdapter.itemBuilder,
        itemCount: listAdapter.itemCount,
      ),
      onRefresh: () {
        dispatch(IndexDealFragmentActionCreator.getDealGoods(1));
      },
      loadMore: (page) {
        dispatch(IndexDealFragmentActionCreator.getDealGoods(page));
      },
      controller: state.refreshHelperController,
    ),
    floatingActionButtonLocation: CustomFloatingActionButtonLocation(
        FloatingActionButtonLocation.endDocked, 0, -150),
    floatingActionButton: GestureDetector(
      onTap: () {
        dispatch(IndexDealFragmentActionCreator.onGotoSellEdit(null, null));
      },
      child: Image.asset(
        "images/icon_n_sale.png",
        height: 60,
        width: 60,
      ),
    ),
  );
}
