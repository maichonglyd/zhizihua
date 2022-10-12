import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GmGameItemState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 14, right: 14, top: 12, bottom: 12),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                child: ClipRRect(
                  child: new HuoNetImage(
                    imageUrl: state.game.icon,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  child: Row(
                                    children: <Widget>[
                                      LimitedBox(
                                        child: Text(
                                          state.game.gameName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff333333),
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxWidth: 150,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 10),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffEBF3F8),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2))),
                                        margin: EdgeInsets.only(right: 5),
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 1,
                                            bottom: 1),
                                        child: Text(getText(name: 'textGmVersion'),
                                            style: TextStyle(
                                              color: Color(0xff3D87C2),
                                              fontSize: 11,
                                            )),
                                      ),
                                      Text(
                                        state.game.size,
                                        style: TextStyle(
                                          color: AppTheme.colors.textSubColor2,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 10, top: 4),
                                ),
                                Container(
                                  child: Text(
                                    state.game.oneWord,
                                    style: TextStyle(
                                      color: AppTheme.colors.textSubColor2,
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  margin: EdgeInsets.only(left: 10, top: 4),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              state.game.gmUrl == null || state.game.gmUrl.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: DownView(game: state.game, type: TYPE_GAME_ITEM),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        dispatch(GmGameItemActionCreator.gotoGm());
                      },
                      child: Container(
                        child: Material(
                          color: Colors.white,
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                getText(name: 'textGmPermission'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            width: 55,
                            height: 55,
                          ),
                          textStyle:
                              TextStyle(color: Color(0xff3D87C2), fontSize: 13),
                          shape: RoundedRectangleBorder(
                              side: new BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xff3D87C2),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                      ),
                    )
            ],
          ),
          onTap: () {
            dispatch(GmGameItemActionCreator.onAction());
          },
        ),
      ),
      Container(
        height: 1,
        padding: EdgeInsets.only(left: 14, right: 14),
        color: AppTheme.colors.lineColor,
      )
    ],
  );
}
