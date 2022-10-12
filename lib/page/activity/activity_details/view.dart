import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';

import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ActivityDetailsState state, Dispatch dispatch, ViewService viewService) {
  String title = getText(name: 'textInformationDetails');
  switch (state.type) {
    case 2:
      title = getText(name: 'textActivityDetail');
      break;
    case 4:
      title = getText(name: 'textAnnouncementDetail');
      break;
    case 3:
      title = getText(name: 'textStrategyDetail');
      break;
  }
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: huoTitle(title),
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
          Expanded(
            child: (state.type == 2)
                ? (state.newsDetailsData != null
                    ? Stack(
                        children: <Widget>[
                          ListView(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                  top: 14,
                                  left: 14,
                                  right: 14,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(5),
                                      bottom: Radius.circular(5)),
                                  child: Container(
                                    height: 163,
                                    width: double.infinity,
                                    child: HuoNetImage(
                                      imageUrl:
                                          state.newsDetailsData.data.thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    height: 82,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFFDD3C),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    margin: EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    child: Center(
                                      child: Text(
                                        state.newsDetailsData.data.postTitle,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: AppTheme.colors.textColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 82,
                                    margin: EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    padding: EdgeInsets.all(8),
                                    child: Image.asset(
                                      "images/hd_zs_bg.png",
                                      height: 42,
                                      width: double.maxFinite,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          "${AppUtil.formatDate1(state.newsDetailsData.data.startTime)} - ${AppUtil.formatDate1(state.newsDetailsData.data.endTime)}",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.colors.textSubColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Processing(
                                            state
                                                .newsDetailsData.data.startTime,
                                            state.newsDetailsData.data.endTime)
                                        ? Row(
                                            children: <Widget>[
                                              Container(
                                                height: 5,
                                                width: 5,
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5))),
                                              ),
                                              Text(
                                                getText(name: 'textInProcess'),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppTheme
                                                        .colors.textColor),
                                              )
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2))),
                                margin: EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: HtmlWidget(
                                  state.newsDetailsData.data.postContent,
                                ),
                              ),
                            ],
                          ),
//                  Align(
//                    alignment: Alignment.bottomCenter,
//                    child:
//                    Container(
//                      height: 50,
//                      margin: EdgeInsets.only(bottom: 14),
//                      child: Row(
//                        children: <Widget>[
//                          Expanded(child:GestureDetector(
//                            onTap: (){
//                              dispatch(ActivityDetailsActionCreator.showDownDialog());
//                            },
//                            child: Container(
//                              height: 45,
//                              decoration: BoxDecoration(
//
//                                  gradient: LinearGradient(colors: [
//                                    Color(0xff5EC4FF),
//                                    Color(0xff07A0F8),
//
//                                  ]),
//                                  borderRadius: BorderRadius.all(Radius.circular(20))),
//                              margin: EdgeInsets.only(
//                                  left: 14, right: 7, top: 10, bottom: 10),
//                              child: Center(
//                                child: Text(
//                                  "下载",
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(fontSize: 15, color: Colors.white),
//                                ),
//                              ),
//                            ),
//                          ),flex: 1,),
//                          Expanded(child: GestureDetector(
//                            onTap: (){
//                              dispatch(ActivityDetailsActionCreator.gotoGameDetails());
//                            },
//                            child: Container(
//                              height: 45,
//                              decoration: BoxDecoration(
//
//                                  gradient: LinearGradient(colors: [
//                                    Color(0xffFF9666),
//                                    Color(0xffEE5151),
//
//                                  ]),
//                                  borderRadius: BorderRadius.all(Radius.circular(20))),
//                              margin: EdgeInsets.only(
//                                  left: 7, right: 14, top: 10, bottom: 10),
//                              child: Center(
//                                child: Text(
//                                  "进入游戏详情",
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(fontSize: 15, color: Colors.white),
//                                ),
//                              ),
//                            ),
//                          ),flex: 1,),
//                        ],
//                      ),
//                    ),
//                  )
                        ],
                      )
                    : Container())
                : (state.newsDetailsData != null
                    ? ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 14, right: 14, top: 15, bottom: 20),
                            child: Text(
                              state.newsDetailsData.data.postTitle,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.colors.textColor),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 14,
                              right: 14,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(2)),
                              child: Container(
                                height: 163,
                                width: double.infinity,
                                child: HuoNetImage(
                                  imageUrl:
                                      state.newsDetailsData.data.thumbnail,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          HtmlWidget(
                            state.newsDetailsData.data.postContent,
                          ),
                        ],
                      )
                    : Container()),
          ),
          (state.newsDetailsData != null &&
                  (state.newsDetailsData.data.game != null))
              ? Column(
                  children: <Widget>[
                    Container(
                      height: 1,
                      color: AppTheme.colors.textSubColor3,
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 7, bottom: 7),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 60,
                                child: ClipRRect(
                                  child: new HuoNetImage(
                                    imageUrl:
                                        state.newsDetailsData.data.gameIcon,
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        state.newsDetailsData.data.gameName,
                                        style: TextStyle(
                                          color: AppTheme.colors.textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10, top: 4),
                                    ),
                                    Container(
                                      child: Text(
                                        state.newsDetailsData.data.gameName,
                                        style: TextStyle(
                                          color: Color(0xff666660),
                                          fontSize: 11,
                                        ),
                                      ),
                                      margin: EdgeInsets.only(left: 10, top: 4),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  child: DownView(
//                                      game: getGameBean(
//                                          state.newsDetailsData.data.appId,
//                                          state.newsDetailsData.data.gameName,
//                                          state.newsDetailsData.data.gameIcon),
                                      game: getGameBean(
                                          state.newsDetailsData.data.appId,
                                          state.newsDetailsData.data.gameName,
                                          state.newsDetailsData.data.gameIcon,
                                          state.newsDetailsData.data.oneWord,
                                          state.newsDetailsData.data.size,
                                          state.newsDetailsData.data.type,
                                          state.newsDetailsData.data.game),
                                      type: TYPE_GAME_ITEM),
                                ),
                                onTap: () {
                                  //  dispatch(ActivityDetailsActionCreator.showDownDialog());
                                },
                              )
                            ]),
                      ),
                      onTap: () {
                        dispatch(
                            ActivityDetailsActionCreator.gotoGameDetails());
                      },
                    )
                  ],
                )
              : Container()
        ],
      ));
}

Game getGameBean(int gameId, String gameName, String gameIcon, String oneWord,
    String size, List<String> types, Game originGame) {
  Game game = Game();
  game.gameId = gameId;
  game.gameName = gameName;

  //下面几个参数都得传不然下载报错
  game.packageName = originGame.packageName;
  game.isBt = originGame.isBt;
//  game.type = originGame.type;
  game.type = types;
  game.size = size;
  game.oneWord = oneWord;

  game.tagsArr = originGame.tagsArr;
  game.singleTag = originGame.singleTag;
  game.icon = originGame.icon;
  game.status = originGame.status;
  game.clientId = originGame.clientId;
  game.downCnt = originGame.downCnt;
  game.install = originGame.install;
  game.rate = originGame.rate;
//  game.size = originGame.size;
//  game.oneWord = originGame.oneWord;

  return game;
}

//Game getGameBean(int gameId, String gameName, String gameIcon) {
//  Game game = Game();
//  game.gameId = gameId;
//  game.gameName = gameName;
//  return game;
//}

bool Processing(int startTime, int endTime) {
  var now = new DateTime.now();
  if ((startTime * 1000 < now.millisecondsSinceEpoch) &&
      (now.millisecondsSinceEpoch < endTime * 1000)) return true;

  return false;
}
