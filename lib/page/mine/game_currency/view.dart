import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameCurrencyListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      title: huoTitle(getText(name: 'textGameCoin')),
      leading: new IconButton(
        icon: Image.asset(
          "images/icon_toolbar_return_icon_dark.png",
          width: 40,
          height: 44,
        ),
        onPressed: () {
          Navigator.pop(viewService.context);
        },
      ),
    ),
    body: state.refreshHelper.getEasyRefresh(
      ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: listAdapter.itemCount,
          itemBuilder: listAdapter.itemBuilder),
      onRefresh: () {
        dispatch(GameCurrencyListActionCreator.getGameCurrencyList(1));
      },
      loadMore: (page) {
        dispatch(GameCurrencyListActionCreator.getGameCurrencyList(page));
      },
      controller: state.refreshHelperController,
    ),
  );
}
