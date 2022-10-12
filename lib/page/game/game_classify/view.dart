import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/game/game_search/page.dart';
import 'package:flutter_huoshu_app/widget/huo_appbar.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameClassifyState state, Dispatch dispatch, ViewService viewService) {
  List<String> tag = [getText(name: 'textWhole'), getText(name: 'textBTGame'), getText(name: 'textDiscountGame')];
  if (AppConfig.hasH5) tag.add(getText(name: 'textH5Game'));
  List<String> type = [getText(name: 'textWhole')];
  type.addAll(state.gameType != null
      ? state.gameType.list.map((type) => type.typeName).toList()
      : []);

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          AppUtil.gotoPageByName(
              viewService.context, GameSearchPage.pageName);
        },
        child: Container(
          height: 33,
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Row(
            children: <Widget>[
              Image.asset(
                "images/tobar_ic_search_gray.png",
                height: 24,
                width: 24,
              ),
              Text(
                getText(name: 'textSearchKeywords'),
                style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.colors.textSubColor2),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius:
              BorderRadius.all(Radius.circular(17.5))),
        ),
      ),
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
//        Container(
//          height: 42,
//          child: Text(S.of(viewService.context).textConditionalFiltering),
//          alignment: Alignment.centerLeft,
//          margin: EdgeInsets.only(left: 14),
//        ),
//        Container(
//          margin: EdgeInsets.only(bottom: 12, left: 14, right: 14),
//          height: 1,
//          color: AppTheme.colors.lineColor,
//        ),
//        buildSlideBlock(tag, state, dispatch),
        Container(
            margin: EdgeInsets.only(left: 14),
            height: 42,
            child: Text(getText(name: 'textTypeFiltering')),
            alignment: Alignment.centerLeft),
        Container(
          margin: EdgeInsets.only(bottom: 12, right: 14, left: 14),
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        buildSlideBlock2(type, state, dispatch),
        Expanded(
            child: Container(
          child: viewService.buildComponent("game_list"),
          margin: EdgeInsets.only(top: 10),
        ))
      ],
    ),
  );
}

Widget buildSlideBlock(
    List<String> tag, GameClassifyState state, Dispatch dispatch) {
  return Container(
    height: 32,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: tag
          .asMap()
          .keys
          .map((i) => GestureDetector(
                onTap: () {
                  dispatch(GameClassifyActionCreator.selectIndex(i));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 32,
                  width: 72,
                  margin: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                      color: i == state.index
                          ? AppTheme.colors.themeColor
                          : Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color: (state.index == i
                              ? Colors.transparent
                              : Color(0xFFECECEC))),
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                  child: Text(
                    tag[i],
                    style: TextStyle(
                        color: state.index == i
                            ? Colors.white
                            : AppTheme.colors.textSubColor2,
                        fontSize: 12),
                  ),
                ),
              ))
          .toList(),
    ),
  );
}

Widget buildSlideBlock2(
    List<String> tag, GameClassifyState state, Dispatch dispatch) {
  return Container(
    height: 32,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: tag
          .asMap()
          .keys
          .map((i) => GestureDetector(
                onTap: () {
                  dispatch(GameClassifyActionCreator.selectTypeIndex(i));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 32,
                  margin: EdgeInsets.only(left: 14),
                  padding: EdgeInsets.only(left: 23, right: 23),
                  decoration: BoxDecoration(
                      color: state.typeIndex == i
                          ? AppTheme.colors.themeColor
                          : Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color: (state.typeIndex == i
                              ? Colors.transparent
                              : Color(0xFFECECEC))),
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                  child: Text(
                    tag[i],
                    style: TextStyle(
                        color: state.typeIndex == i
                            ? Colors.white
                            : AppTheme.colors.textSubColor2,
                        fontSize: 12),
                  ),
                ),
              ))
          .toList(),
    ),
  );
}
