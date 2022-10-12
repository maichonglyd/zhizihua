import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(IntegralShopFragmentState state, Dispatch dispatch,
    ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();

  return Container(
    child: state.refreshHelper.getEasyRefresh(
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 5.0,
                //横轴间距
                crossAxisSpacing: 0.0,
                //子组件宽高长度比例
                childAspectRatio: 1.18),
            padding: EdgeInsets.all(0),
            itemCount: listAdapter.itemCount,
            itemBuilder: listAdapter.itemBuilder), onRefresh: () {
      dispatch(IntegralShopFragmentActionCreator.getIntegralGoods(1));
    }, loadMore: (page) {
      dispatch(IntegralShopFragmentActionCreator.getIntegralGoods(page));
    }, controller: state.refreshHelperController),
  );
}
