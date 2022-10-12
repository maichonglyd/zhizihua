import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameSpecialHeadState state, Dispatch dispatch, ViewService viewService) {
  var colors = [
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
    Color(0xffF35A58),
    Color(0xffF35A58),
    Color(0xFF3D87C2),
    Color(0xFFF67C29),
  ];
  var colors2 = [
    Color(0xFFF2F9FF),
    Color(0xFFFFF7F2),
    Color(0xffFFF5F5),
    Color(0xffFFF5F5),
    Color(0xFFF2F9FF),
    Color(0xFFFFF7F2),
  ];
  List<String> tagsArr = state.gameSpecial.game.singleTag;

  Widget finalWidget = Container();
  finalWidget = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: Wrap(
          children: tagsArr
              .sublist(0, tagsArr.length > 3 ? 3 : tagsArr.length)
              .asMap()
              .keys
              .map((index) => Container(
                    decoration: BoxDecoration(
                        color: colors2[index % 6],
                        borderRadius: BorderRadius.all(Radius.circular(2.5))),
                    margin: EdgeInsets.only(right: 5),
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                    child: Text(tagsArr[index % 3],
                        style: TextStyle(
                          color: colors[index % 6],
                          fontSize: 11,
                        )),
                  ))
              .toList(),
        ),
      ),
      tagsArr.length > 3
          ? Container(
              margin: EdgeInsets.only(left: 15, top: 2),
              child: Wrap(
                children: tagsArr
                    .sublist(3, tagsArr.length > 6 ? 6 : tagsArr.length)
                    .asMap()
                    .keys
                    .map((index) => Container(
                          decoration: BoxDecoration(
                              color: colors2[index % 6],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.5))),
                          margin: EdgeInsets.only(right: 5),
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 0, bottom: 0),
                          child: Text(tagsArr[index + 3],
                              style: TextStyle(
                                color: colors[index % 6],
                                fontSize: 11,
                              )),
                        ))
                    .toList(),
              ),
            )
          : Container()
    ],
  );
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.only(left: 12, right: 15),
      margin: EdgeInsets.only(bottom: 8, top: 10),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, left: 4, bottom: 10),
            height: 145,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0x14000000),
                      offset: Offset(2.0, 0.5), //阴影xy轴偏移量
                      blurRadius: 20.0, //阴影模糊程度
                      spreadRadius: 0.0 //阴影扩散程度
                      )
                ]),
            width: double.maxFinite,
            child: ClipRRect(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: HuoNetImage(
                            imageUrl: state.gameSpecial.game.icon,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          // decoration: BoxDecoration(
                          // gradient: LinearGradient(colors: [
                          //   Color(0xffffffff),
                          //   Color(0x80ffffff),
                          // ]),
                          // ),
                          height: 250,
                        )
                      ],
                    ),
                  )
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          Container(
            height: 165,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: 57, bottom: 2, left: 15, right: 8),
                      child: Text(
                        state.gameSpecial.game.gameName,
                        style: TextStyle(
                            color: AppTheme.colors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 2, bottom: 4, left: 15, right: 8),
                      child: Text(
                        state.gameSpecial.game.desc,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppTheme.colors.textSubColor, fontSize: 11),
                      ),
                    ),
                    finalWidget
                  ],
                )),
                Container(
                  height: 90,
                  width: 90,
                  margin: EdgeInsets.only(right: 15),
                  child: ClipRRect(
                      child: HuoNetImage(
                        imageUrl: state.gameSpecial.game.icon,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(top: 4, bottom: 4, right: 8),
//                          decoration: BoxDecoration(
//                              color: Color(0xffF35A58),
//                              borderRadius: BorderRadius.horizontal(
//                                  left: Radius.circular(0),
//                                  right: Radius.circular(15))),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/bt_bq_bg.png",
                  width: 72,
                  height: 27,
                ),
                Container(
                  width: 72,
                  height: 27,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    state.gameSpecial.topicName,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    onTap: () {
      if (state.gameSpecial.gameUrl.isNotEmpty) {
        AppUtil.gotoH5Game(viewService.context, state.gameSpecial.gameUrl,
            state.gameSpecial.direction);
      } else {
        dispatch(IndexRecommendActionCreator.gotoGameDetails(
            int.parse(state.gameSpecial.gameId)));
      }
    },
  );
}
