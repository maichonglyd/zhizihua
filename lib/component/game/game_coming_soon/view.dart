import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/view.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_special.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameComingSoonState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 165,
    margin: EdgeInsets.only(left: 10, bottom: 5),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemView(state, dispatch, viewService, index);
      },
      itemCount: state.serverList.length,
    ),
  );
}

Widget _buildItemView(GameComingSoonState state, Dispatch dispatch,
    ViewService viewService, int index) {
  ServerBean game = state.serverList[index];
  String singleTag = (game.singleTag != null && game.singleTag.length > 0)
      ? game.singleTag[0]
      : "";
  List<String> singleTagList = List();
  if (singleTag.isEmpty) {
  } else {
    List<String> singleTagData = singleTag.split("|");
    singleTagList = singleTagData;
  }

  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailById(viewService.context, game.appId);
    },
    child: Container(
      width: 110,
      height: 154,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 1), //阴影xy轴偏移量
          blurRadius: 3.0, //阴影模糊程度
        )
      ]),
      child: Column(
        children: [
          Expanded(
            flex: 105,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            child: HuoNetImage(
                              imageUrl: game.gameIcon ?? '',
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                          ),
                        ),
                        singleTagList.length > 0
                            ? ClipPath(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(bottom: 5),
                            height: 19,
                            width: 60,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffFF5E46),
                                  Color(0xffFF5E46),
                                ]),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10))),
                            child: Text(
                              singleTagList.length > 0
                                  ? singleTagList[0]
                                  : singleTag,
                              style: TextStyle(
                                fontSize: HuoTextSizes.game_tag_sub,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          clipper: MyClipper(),
                        )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      game.gameName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppTheme.colors.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 49,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF0BC4B1),
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      game.serverName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      AppUtil.formatDate17(game.startTime) + getText(name: 'textService'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(forceStrutHeight: true, height:0, leading: 1),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
