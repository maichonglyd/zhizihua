import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexPlayedItemState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    height: 100,
    color: Color(0xffF8F8F8),
    child: Row(
      children: <Widget>[
        Container(
          height: 62,
          width: 31,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff2DE089),
                Color(0xff0BC4B1),
              ]),
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(35))),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              getText(name: 'textPlayed'),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(state, index, dispatch, viewService);
            },
            itemCount: state.playedList.list.length >= 4
                ? 4
                : state.playedList.list.length,
          ),
        )
      ],
    ),
  );
}

Widget buildItem(IndexPlayedItemState state, int index, Dispatch dispatch,
    ViewService viewService) {
  return GestureDetector(
    onTap: () {
//      AppUtil.gotoGameDetailOrH5Game(viewService.context,  state.playedList.list[index].game);
      //这里只跳转详情
      AppUtil.gotoGameDetail(
          viewService.context, state.playedList.list[index].game);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 55,
          width: 55,
          margin: EdgeInsets.only(right: 12, top: 8, left: 12),
          child: ClipRRect(
              child: HuoNetImage(
                imageUrl: state.playedList.list[index].gameIcon,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        Container(
          height: 34,
          width: 55,
          margin: EdgeInsets.only(right: 12, left: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(5), top: Radius.circular(0)),
          ),
          child: Text(state.playedList.list[index].gameName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13)),
        ),
      ],
    ),
  );
}
