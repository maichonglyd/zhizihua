import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/page/activity/activity_details/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ActivityListState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: Color(0xFFFAF7F8),
    child: state.refreshHelper.getEasyRefresh(
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return buildItem(state, state.dataList[index], viewService);
          },
          itemCount: state.dataList.length,
        ), onRefresh: () {
      dispatch(ActivityListActionCreator.getData(1));
    }, loadMore: (page) {
      dispatch(ActivityListActionCreator.getData(page));
    }, controller: state.refreshHelperController),
  );
}

Widget buildItem(ActivityListState state, New data, ViewService viewService) {
  return GestureDetector(
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            AppUtil.formatDate4(data.startTime),
            style:
                TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, left: 14.5, right: 14.5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(9.6))),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(9.6)),
                child: Container(
                  height: 163,
                  width: double.infinity,
                  child: HuoNetImage(
                    imageUrl: data.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 58,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4, right: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.postTitle,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.colors.textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                state.type == 2
//                                    ? "活动日期：${AppUtil.formatDate1(data.startTime)} - ${AppUtil.formatDate1(data.endTime)}"
                                    ? getText(name: 'textActivityDate', args: [AppUtil.formatDate1(data.startTime), AppUtil.formatDate1(data.endTime)])
                                    : data.excerpt,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.colors.textSubColor2,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    (state.type == 2 &&
                            Processing(data.startTime, data.endTime))
                        ? Container(
                            margin: EdgeInsets.only(left: 4, right: 4),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 5,
                                  width: 5,
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                                Text(
                                  getText(name: 'textInProcess'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.colors.textColor),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ),
    onTap: () {
      if (data.url != null && data.url.isNotEmpty) {
        AppUtil.gotoH5Web(viewService.context, data.url,
            title: getText(name: 'textInformationDetails'));
        return;
      }
      AppUtil.gotoPageByName(viewService.context, ActivityDetailsPage.pageName,
          arguments: {
            "newsId": data.newsId,
            "type": state.type,
            "gameId": data.gameId
          });
    },
  );
}

bool Processing(int startTime, int endTime) {
  var now = new DateTime.now();
  if ((startTime * 1000 < now.millisecondsSinceEpoch) &&
      (now.millisecondsSinceEpoch < endTime * 1000)) return true;

  return false;
}
