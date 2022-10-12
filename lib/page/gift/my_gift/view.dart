import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyGiftState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: huoTitle(getText(name: 'textMyGift')),
      centerTitle: true,
      elevation: 0,
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
        itemBuilder: listAdapter.itemBuilder,
        itemCount: listAdapter.itemCount,
      ),
      onRefresh: () {
        dispatch(MyGiftActionCreator.getGifts(1));
      },
      loadMore: (page) {
        dispatch(MyGiftActionCreator.getGifts(page));
      },
      controller: state.refreshHelperController,
    ),
  );
}
