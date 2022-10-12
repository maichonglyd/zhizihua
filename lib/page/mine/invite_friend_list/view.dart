import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/user/share_men_list_data.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    InviteListState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: huoTitle(getText(name: 'textInviteList')),
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
    body: Column(
      children: <Widget>[
        SplitLine(),
        Container(
          height: 44,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(getText(name: 'textFriendAccount')),
              Text(getText(name: 'textRegisterGame')),
              Text(getText(name: 'textRegisterTime')),
            ],
          ),
        ),
        Expanded(
            child: state.refreshHelper.getEasyRefresh(
          ListView(
            children: state.mems
                .asMap()
                .keys
                .map((index) => buildItem(state.mems, index))
                .toList(),
          ),
          controller: state.refreshHelperController,
          onRefresh: () {
            dispatch(InviteListActionCreator.getShareMemList(1));
          },
          loadMore: (page) {
            dispatch(InviteListActionCreator.getShareMemList(page));
          },
        ))
      ],
    ),
  );
}

Widget buildItem(List<Mem> mems, int index) {
  return Container(
    height: 55,
    color: index % 2 == 0 ? Colors.white : Color(0xFFFDEEEE),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(mems[index].username),
        Text(mems[index].gameName),
        Text(AppUtil.formatDate1(mems[index].createTime)),
      ],
    ),
  );
}
