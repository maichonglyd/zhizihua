import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/activity/activty_home/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ActivityNewsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      title: huoTitle(getText(name: 'textActivityNews')),
      centerTitle: true,
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
    body: Container(
      child: viewService.buildComponent(ActivityHomeComponent.componentName),
    ),
  );
}
