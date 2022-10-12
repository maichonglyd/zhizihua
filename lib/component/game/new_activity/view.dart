import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/activity/activity_details/page.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    NewActivityState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 178,
    padding: EdgeInsets.only(left: 14, top: 12),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Container(
//          height: 45,
          margin: EdgeInsets.only(bottom: 10, right: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(getText(name: 'textLatestActivity'),
                    style: commonTextStyle(AppTheme.colors.textColor,
                        HuoTextSizes.title, FontWeight.w600)),
              ),
              GestureDetector(
                onTap: () {
                  AppUtil.gotoPageByName(
                      viewService.context, ActivityNewsPage.pageName,
                      arguments: null);
                },
                child: Text(getText(name: 'textMore'),
                    textAlign: TextAlign.center,
                    style: commonTextStyle(AppTheme.colors.textSubColor,
                        HuoTextSizes.second_title, FontWeight.w400)),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(state, index, dispatch, viewService);
            },
            itemCount: state.news.length,
          ),
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size, FontWeight fontWeight) {
  return TextStyle(color: color, fontSize: size, fontWeight: fontWeight);
}

Widget buildItem(NewActivityState state, int index, Dispatch dispatch,
    ViewService viewService) {
  return GestureDetector(
    child: Column(
      children: <Widget>[
        Container(
          height: 90,
//          width: 186,
          margin: EdgeInsets.only(right: 10),
          child: new AspectRatio(
            aspectRatio: 57 / 32, //横纵比 长宽比  3:2
            child: ClipRRect(
                child: HuoNetImage(
                  imageUrl: state.news[index].thumbnail,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5), bottom: Radius.circular(0))),
          ),
        ),
        Container(
          height: 30,
          width: 160,
          margin: EdgeInsets.only(right: 10, bottom: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(5), top: Radius.circular(0)),
              boxShadow: [
                BoxShadow(
                    color: Color(0x12000000),
                    offset: Offset(2.0, 1), //阴影xy轴偏移量
                    blurRadius: 10.0, //阴影模糊程度
                    spreadRadius: 0.0 //阴影扩散程度
                    )
              ]),
          child: Text(state.news[index].title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: commonTextStyle(
                  AppTheme.colors.textSubColor, 11, FontWeight.normal)),
        ),
      ],
    ),
    onTap: () {
//      if (state.news[index] != null) {
//        String url = state.news[index].noticeUrl;
//        if (url != null && url.isNotEmpty) {
//          AppUtil.gotoH5Web(viewService.context, url, title:  state.news[index].title);
//          return;
//        }
//      }

      if (state.news[index] != null) {
        int newsId = state.news[index].newsId;
        int gameId = state.news[index].gameId;
        String url = state.news[index].url;
        if (url != null && url.isNotEmpty) {
          AppUtil.gotoH5Web(viewService.context, url,
              title: state.news[index].title);
          return;
        }
        AppUtil.gotoPageByName(
            viewService.context, ActivityDetailsPage.pageName,
            arguments: {"newsId": newsId, "type": 2, "gameId": gameId});
      }
    },
  );
}
