import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/download/download_manage/page.dart';
import 'package:flutter_huoshu_app/page/game/game_new_notice/page.dart';
import 'package:flutter_huoshu_app/page/game/game_new_tour_list/page.dart';
import 'package:flutter_huoshu_app/page/game/game_search/page.dart';
import 'package:flutter_huoshu_app/page/mine/message/message_list/page.dart';
import 'package:flutter_huoshu_app/utils/fragment_util.dart';

const int TOP_SEARCH_TYPE_NEW_GAME = 0;
const int TOP_SEARCH_TYPE_NOTICE = 1;
const int TOP_SEARCH_TYPE_DOWNLOAD = 2;
const int TOP_SEARCH_TYPE_MESSAGE = 3;

Widget topSearchIconButton(BuildContext context, int type) {
  String iconUrl = "";
  String name = "";
  Function() click;
  switch (type) {
    case TOP_SEARCH_TYPE_NEW_GAME:
      iconUrl = "images/icon_trophy_black.png";
      name = getText(name: 'textNewGameList');
      click = () {
        AppUtil.gotoPageByName(context, GameNewTourListPage.pageName);
      };
      break;
    case TOP_SEARCH_TYPE_NOTICE:
      iconUrl = "images/icon_search_notice.png";
      name = getText(name: 'textAdvanceNotice');
      click = () {
        if (-1 != FragmentConstant.newGameNoticeTopicId) {
          AppUtil.gotoPageByName(context, GameNewNoticePage.pageName, arguments: {
            "title": FragmentConstant.newGameNoticeTopicTitle,
            "specialId": FragmentConstant.newGameNoticeTopicId,
          });
        }
      };
      break;
    case TOP_SEARCH_TYPE_DOWNLOAD:
      iconUrl = "images/icon_search_download.png";
      name = getText(name: 'textToDownload');
      click = () {
        AppUtil.gotoPageByName(context, DownLoadManagePage.pageName);
      };
      break;
    case TOP_SEARCH_TYPE_MESSAGE:
      iconUrl = "images/icon_message.png";
      name = getText(name: 'textInformation');
      click = () {
        AppUtil.gotoPageByName(context, MessageListPage.pageName);
      };
      break;
  }
  return GestureDetector(
    onTap: () {
      if (null != click) {
        click();
      }
    },
    child: Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        children: [
          Image.asset(
            iconUrl,
            width: 22,
            height: 22,
            fit: BoxFit.cover,
          ),
          Container(
            child: Text(
              name,
              style:
                  TextStyle(color: AppTheme.colors.textColor, fontSize: 10),
            ),
          )
        ],
      ),
    ),
  );
}

Widget topSearchView(BuildContext context, {List<int> typeList}) {
  List<Widget> widgetList = [];

  Widget searchView = Expanded(
    child: GestureDetector(
      child: Container(
        height: 35,
        padding: EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Image.asset(
              AppTheme.images.icon_n_search,
              height: 24,
              width: 24,
            ),
            Text(
              getText(name: 'textSearchPlayGame'),
              style:
                  TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xFFF8F8F8),
            borderRadius: BorderRadius.all(Radius.circular(17.5)),
            border: Border.all(color: AppTheme.colors.bgColor, width: 1)),
      ),
      onTap: () {
        AppUtil.gotoPageByName(context, GameSearchPage.pageName);
      },
    ),
  );
  widgetList.add(searchView);

  if (null != typeList && typeList.length > 0) {
    for (int type in typeList) {
      widgetList.add(topSearchIconButton(context, type));
    }
  }

  return Container(
    margin: EdgeInsets.only(left: 15, top: 0, right: 15, bottom: 6),
    child: Row(
      children: widgetList,
    ),
  );
}
