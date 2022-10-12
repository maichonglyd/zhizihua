import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    JPGameItemState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailOrH5Game(viewService.context, state.game);
    },
    child: Container(
      height: 290,
      margin: EdgeInsets.only(left: 14, right: 14, top: 0, bottom: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  height: 55,
                  width: 55,
                  child: ClipRRect(
                    child: new HuoNetImage(
                      imageUrl: state.game.icon,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.game.gameName,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: HuoTextSizes.second_title,
                            color: AppTheme.colors.textColor,
                          ),
                        ),
                        Container(
                          height: 6,
                        ),
                        Text(
                          "${state.game.singleTag}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: HuoTextSizes.index_tab,
                              color: AppTheme.colors.textSubColor2),
                        )
                      ],
                    ),
                  ),
                ),
                //                   DownView(game: state.game, type: TYPE_GAME_ITEM),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "images/ic_pfstar_red.png",
                          height: 17,
                          width: 17,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            state.game.starCnt.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                color: AppTheme.colors.themeColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Text(
                        getText(name: 'textNumberRating', args: [state.game.commentCount]),
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.themeColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
          Container(
            height: 160,
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 5),
            child: new AspectRatio(
              aspectRatio: 66 / 32, //横纵比 长宽比  3:2
              child: ClipRRect(
                child: new HuoNetImage(
                  imageUrl: state.game.fineImage,
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
//            child: ClipRRect(
//              child: new HuoNetImage(
//                imageUrl: state.game.appHotImage,
//                fit: BoxFit.cover,
//              ),
//              borderRadius: BorderRadius.all(Radius.circular(6)),
//            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 15, bottom: 0),
            child: Text(
              state.game.desc,
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: HuoTextSizes.index_tab,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff000000)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 5),
            height: 0.7,
            color: AppTheme.colors.lineColor,
          )
        ],
      ),
    ),
  );
}
