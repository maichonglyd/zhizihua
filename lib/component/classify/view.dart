import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_game.dart';
import 'package:flutter_huoshu_app/component/classify/model/classify_mod.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/inviewnotifier/inview_notifier_list.dart';
import 'package:flutter_huoshu_app/inviewnotifier/video_widget_up.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/widget/game/game_item_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ClassifyState state, Dispatch dispatch, ViewService viewService) {
  return SafeArea(
      child: Row(
    children: <Widget>[
      state.tabs != null && state.tabs.length > 0
          ? Container(
              child: ListView(
                children: state.tabs.asMap().keys.map((index) {
                  return buildLeftItem(
                      state.tabs[index], index, dispatch, viewService);
                }).toList(),
                scrollDirection: Axis.vertical,
              ),
              color: Color(0xffF8F8F8),
              width: 75,
            )
          : Container(),
      10011 == state.selectTypeId
          ? _buildVideoList(state, dispatch, viewService)
          : Expanded(
              child: state.refreshHelper.getEasyRefresh(
              ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  state.games != null && state.games.length > 0
                      ? Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                          child: GestureDetector(
                            child: SizedBox(
                              width: 263,
                              height: 147,
                              child: ClipRRect(
                                child: HuoNetImage(
                                  imageUrl: state.games[0].fineImage ?? "",
                                  height: 151,
                                  width: 270,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onTap: () {
                              AppUtil.gotoPageByName(
                                  viewService.context, GameDetailsPage.pageName,
                                  arguments: {"gameId": state.games[0].gameId});
                            },
                          ))
                      : Container(
                          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                          height: 147,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: GestureDetector(
                            child: Image.asset(
                              "images/huo_app_default.png",
                              height: 147,
                              width: 263,
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              AppUtil.gotoPageByName(
                                  viewService.context, GameDetailsPage.pageName,
                                  arguments: {"gameId": state.gameId});
                            },
                          )),
                  state.games != null && state.games.length > 0
                      ? Container(
                          child: ListView(
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            children: state.games.map((game) {
                              return GameItemView(
                                game,
                                contentHeight: 80,
                                gameIconWidth: 55,
                                contentMargin:
                                    EdgeInsets.only(left: 13, right: 2),
                              );
                            }).toList(),
                          ),
                        )
                      : Container(),
                ],
              ),
              loadMore: (page) {
                dispatch(ClassifyActionCreator.getGameList(page));
              },
              controller: state.refreshHelperController,
            ))
    ],
  ));
}

Widget buildRightItem(Game game, dispatch, ViewService viewService) {
  return RepaintBoundary(
    child: Container(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          dispatch(ClassifyActionCreator.gotoGameDetails(game.gameId));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ClipRRect(
                child: HuoNetImage(
                  imageUrl: game.icon,
                  height: 72,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  game.gameName ?? "",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
                  overflow: TextOverflow.ellipsis,
                ),
                alignment: Alignment.center,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildLeftItem(
    GameClassifyType mod, int index, dispatch, ViewService viewService) {
  return GestureDetector(
      onTap: () {
        dispatch(ClassifyActionCreator.onSelectedTabs(index));
      },
      child: Container(
        color: mod.isSelected ? Colors.white : Color(0xffF8F8F8),
        width: 70,
        alignment: Alignment.centerLeft,
        child: Stack(
          children: <Widget>[
            mod.isSelected
                ? Align(
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 1),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                            color: AppTheme.colors.themeColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  )
                : Container(),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text(
                  mod.typeName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: mod.isSelected
                          ? AppTheme.colors.themeColor
                          : AppTheme.colors.textSubColor),
                ),
                alignment: Alignment.center,
                width: 80,
                height: 40,
              ),
            )
          ],
        ),
      ));
}

Widget _buildVideoList(
    ClassifyState state, Dispatch dispatch, ViewService viewService) {
  return Expanded(
    child: Container(
        child: InViewNotifierList(
      scrollDirection: Axis.vertical,
      initialInViewIds: ['0'],
      shrinkWrap: false,
      isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
        return deltaTop < (0.5 * viewPortDimension) &&
            deltaBottom > (0.5 * viewPortDimension);
      },
      itemCount: state.games.length,
      hasSmartRefresher: true,
      refreshController: state.refreshController,
      enablePullDown: false,
      enablePullUp: true,
      onLoading: () {
        state.page++;
        dispatch(ClassifyActionCreator.getGameList(state.page));
        HuoLog.d("onLoading");
      },
      builder: (BuildContext context, int index) {
        return buildNotifierListItem(
            index, state.games[index], dispatch, viewService, state);
      },
    )),
  );
}

Widget buildNotifierListItem(int index, Game game, Dispatch dispatch,
    ViewService viewService, ClassifyState state) {
  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailOrH5Game(viewService.context, game);
    },
    child: Container(
      height: 236,
      margin: EdgeInsets.only(left: 10, right: 11, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: GameItemView(game, contentHeight: 72, showSplitView: false, gameIconWidth: 55, contentMargin: EdgeInsets.only(left: 0, right: 0),),
          )),
          game.videoUrl != null && game.videoUrl != ""
              ? Container(
                  width: double.infinity,
                  height: 151.0,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return InViewNotifierWidget(
                        id: '$index',
                        builder: (BuildContext context, bool isInView,
                            Widget child) {
                          return ClipRRect(
                            child: VideoWidget2(
                              play: isInView,
                              url: game.videoUrl,
                              videoType: state.videoType + "#${index}",
                              gameId: game.gameId,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          );
                        },
                      );
                    },
                  ),
                )
              : Container(
                  height: 151,
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 0),
                  child: new AspectRatio(
                    aspectRatio: 66 / 32, //横纵比 长宽比  3:2
                    child: ClipRRect(
                        child: new HuoNetImage(
                          imageUrl: game.appHotImage,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 0),
            height: 0.7,
            color: AppTheme.colors.lineColor,
          )
        ],
      ),
    ),
  );
}
