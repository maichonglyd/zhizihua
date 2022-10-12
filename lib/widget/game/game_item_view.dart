import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game_list_fragment/component.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/bt_tag_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

const gameItemMargin = EdgeInsets.only(left: 15, right: 15);
const gameItemPadding = EdgeInsets.all(0);

class GameItemView extends StatefulWidget {
  Game game;
  bool showSplitView;
  double contentHeight;
  double gameIconWidth;
  EdgeInsetsGeometry contentMargin;
  EdgeInsetsGeometry contentPadding;
  int kfType;

  GameItemView(
    this.game, {
    this.showSplitView = true,
    this.contentHeight = 84.0,
    this.gameIconWidth = 60.0,
    this.contentMargin = gameItemMargin,
    this.contentPadding = gameItemPadding,
    this.kfType = 1,
  });

  @override
  State<StatefulWidget> createState() {
    return GameItemState();
  }
}

class GameItemState extends State<GameItemView> {
  @override
  Widget build(BuildContext context) {
    if (null == widget.game) {
      return SizedBox();
    }

    String gameType = "";
    // 只显示两个标签
    if (null != widget.game.type && widget.game.type.length > 0) {
      for (int i = 0; i < widget.game.type.length; i++) {
        gameType += widget.game.type[i];
        if (0 == i) {
          gameType += '·';
        } else {
          gameType += '  ';
          break;
        }
      }
    }
    String server = getText(name: 'textDynamicServiceOpening');
    // 历史开服的区服和时间用不同字段
  //  if (GameListState.TYPE_KF_OLD == widget.kfType || GameListState.TYPE_KF_TODAY == widget.kfType) {
      if (null != widget.game.serverName && null != widget.game.startTime && 0 != widget.game.startTime) {
        server = widget.game.serverName +
            ' ' +
            AppUtil.formatDate17(widget.game.startTime);
      }
 //   }
    // else {
    //   if (null != widget.game.serlist &&
    //       null != widget.game.serlist.list &&
    //       widget.game.serlist.list.length > 0) {
    //     if (0 != widget.game.serlist.list[0].startTime) {
    //       server = widget.game.serlist.list[0].serverName + ' ';
    //       server += AppUtil.formatDate17(widget.game.serlist.list[0].startTime);
    //     }
    //   }
    // }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        AppUtil.gotoGameDetailById(context, widget.game.gameId);
      },
      child: Container(
        height: widget.contentHeight,
        margin: widget.contentMargin,
        padding: widget.contentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: widget.gameIconWidth,
                      width: widget.gameIconWidth,
                      margin: EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        child: HuoNetImage(
                          imageUrl: widget.game.icon,
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.game.gameName ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppTheme.colors.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  if (0 < widget.game.rate &&
                                      1 > widget.game.rate)
                                    Container(
                                      width: 40,
                                      height: 18,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 10),
                                      padding: EdgeInsets.only(bottom: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFFF4605A),
                                              Color(0xFFFD9064),
                                            ]),
                                      ),
                                      child: Text(
                                        (10 * widget.game.rate)
                                                .toStringAsFixed(1) +
                                            getText(name: 'textDiscount'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2, bottom: 2),
                              child: Text.rich(TextSpan(children: [
                                if (gameType.isNotEmpty)
                                  TextSpan(
                                    text: gameType,
                                    style: TextStyle(
                                        color: AppTheme.colors.textSubColor,
                                        fontSize: 11),
                                  ),
                                if (server.isNotEmpty)
                                  TextSpan(
                                    text: server,
                                    style: TextStyle(
                                        color: Color(0xFFCD8812), fontSize: 11),
                                  ),
                              ])),
                            ),
                            shouldShowBtTag(
                                    widget.game.btTags, widget.game.isBt)
                                ? buildBtTagView(widget.game.btTags)
                                : Text(
                                    widget.game.oneWord,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppTheme.colors.textSubColor,
                                        fontSize: 11),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (widget.showSplitView)
              Container(
                height: 1,
                color: AppTheme.colors.lineColor,
              ),
          ],
        ),
      ),
    );
  }
}
