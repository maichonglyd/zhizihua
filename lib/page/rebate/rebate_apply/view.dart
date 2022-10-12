import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RebateApplyState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: huoTitle(getText(name: 'textRebate')),
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
      centerTitle: true,
      elevation: 0,
      actions: <Widget>[
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 14),
            child: Text(
              getText(name: 'textApplyHistory'),
            ),
          ),
          onTap: () {
            dispatch(RebateApplyActionCreator.gotoRebateRecord());
          },
        )
      ],
    ),
    body: Column(
      children: <Widget>[
        SplitLine(),
        Expanded(
            child: state.refreshHelper.getEasyRefresh(
          ListView.builder(
            itemBuilder: listAdapter.itemBuilder,
            itemCount: listAdapter.itemCount,
          ),
          controller: state.refreshHelperController,
          onRefresh: () {
            dispatch(RebateApplyActionCreator.getData(1));
          },
          loadMore: (page) {
            dispatch(RebateApplyActionCreator.getData(page));
          },
        ))
      ],
    ),
  );
}
