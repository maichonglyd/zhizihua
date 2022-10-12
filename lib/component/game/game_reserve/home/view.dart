import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/page.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    NewGameReserveState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 230,
    padding: EdgeInsets.only(left: 14, top: 12),
//    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Container(
//          height: 45,
          margin: EdgeInsets.only(bottom: 10, right: 14),
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text("${state.topicName}",
                    style: commonTextStyle(AppTheme.colors.textColor,
                        HuoTextSizes.title, FontWeight.w600)),
              ),
              GestureDetector(
                onTap: () {
                  AppUtil.gotoPageByName(
                      viewService.context, GameReservePage.pageName,
                      arguments: {
                        "isBT": state.isBT,
                        "isH5": state.isH5,
                        "isZK": state.isZK
                      });
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
            itemCount: state.games.length,
          ),
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size, FontWeight fontWeight) {
  return TextStyle(color: color, fontSize: size, fontWeight: fontWeight);
}

Widget buildItem(NewGameReserveState state, int index, Dispatch dispatch,
    ViewService viewService) {
  String type;
  String sizeString = state.games[index].size.toString();
  if (state.games[index].type.length > 0) {
    //类别先取第一个
    type = state.games[index].type[0];
    sizeString = "$sizeString | $type";
  }
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: <Widget>[
//          Column(
//            children: <Widget>[
//              Container(
//                height: 190,
//                width: 140,
//                child: ClipRRect(
//                    child: HuoNetImage(
//                      imageUrl: state.games[index].pcHomeImgStyle1,
//                      fit: BoxFit.cover,
//                      height: 190,
//                      width: 140,
//                    ),
////                    child:Image.network(state.games[index].pcHomeImgStyle1, fit: BoxFit.cover),
//                    borderRadius: BorderRadius.all(Radius.circular(10))),
//              ),
//            ],
//          ),
          Container(
            height: 190,
            width: 140,
            child: ClipRRect(
                child: HuoNetImage(
                  imageUrl: state.games[index].pcHomeImgStyle1,
                  fit: BoxFit.cover,
                  height: 190,
                  width: 140,
                ),
//                    child:Image.network(state.games[index].pcHomeImgStyle1, fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          Container(
            height: 190,
            width: 140,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 140,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x72000000), Color(0x00000000)],
                        ),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 140,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 140,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0x72000000)],
                        ),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(10))),
                  ),
                )
              ],
            ),
          ),
//          Container(
//            height: 190,
//            width: 140,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage("images/pic_black.png"),
//                fit: BoxFit.cover,
//              ),
//            ),
//          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              child: Text(
                state.games[index].runTime == 0
                    ? getText(name: 'textWillStartSoon')
                    : getText(name: 'textDateToStartSoon', args: [AppUtil.formatDate7(state.games[index].runTime)]),
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Positioned(
            left: 5,
            bottom: 8,
            child: Container(
                height: 35,
                width: 140,
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                        child: HuoNetImage(
                          imageUrl: state.games[index].icon,
                          fit: BoxFit.cover,
                          width: 30,
                          height: 30,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              state.games[index].gameName ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            width: 100,
                            margin: EdgeInsets.only(bottom: 1),
                          ),
                          Container(
                            width: 100,
                            alignment: Alignment.topLeft,
                            child: Container(
                              child: Text(
                                "$sizeString",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    ),
    onTap: () {
      //跳转游戏详情
      if (state.games[index] != null) {
        int gameId = state.games[index].gameId;
        if (gameId > 0) {
          AppUtil.gotoPageByName(viewService.context, GameDetailsPage.pageName,
              arguments: {"gameId": gameId});
          return;
        }
      }
    },
  );
}
