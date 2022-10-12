import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameDetailsGiftFragmentState state, Dispatch dispatch,
    ViewService viewService) {
  ListAdapter adapter = viewService.buildAdapter();
  return Column(
    children: <Widget>[
      Expanded(
          child: state.refreshHelper.getEasyRefresh(
              ListView.builder(
                padding: EdgeInsets.all(0),
                itemBuilder: adapter.itemBuilder,
                itemCount: adapter.itemCount,
              ),
              controller: state.refreshHelperController, onRefresh: () {
        dispatch(GameDetailsGiftFragmentActionCreator.getGift(1));
      }, loadMore: (page) {
        dispatch(GameDetailsGiftFragmentActionCreator.getGift(page));
      }))
    ],
  );
}
