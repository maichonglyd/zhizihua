import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameDetailsDealFragmentState state, Dispatch dispatch,
    ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Column(
    children: <Widget>[
      Expanded(
        child: Container(
          child: state.refreshHelper.getEasyRefresh(
              ListView.builder(
                padding: EdgeInsets.all(0),
                itemBuilder: listAdapter.itemBuilder,
                itemCount: listAdapter.itemCount,
              ),
              controller: state.refreshHelperController, loadMore: (page) {
            dispatch(GameDetailsDealFragmentActionCreator.getDealGoods(page));
          }),
          height: 720,
        ),
      ),
    ],
  );
}
