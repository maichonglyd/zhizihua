import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/gift/gift_list/component.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/gift/my_gift/page.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameGiftState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      title: huoTitle(getText(name: 'textGift')),
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
      actions: [
        GestureDetector(
          onTap: () {
            AppUtil.gotoPageByName(viewService.context, MyGiftPage.pageName);
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 15),
            child: Text(
              getText(name: 'textReceivingRecord'),
              style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 14),
            ),
          ),
        )
      ],
    ),
    body: Container(
      child: viewService.buildComponent(GiftListFragment.componentName),
    ),
  );
}
