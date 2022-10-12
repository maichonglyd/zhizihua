import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexRowGameState state, Dispatch dispatch, ViewService viewService) {
  if (state.games == null || state.games.length == 0) {
    return Container();
  }
  return Column(
    children: <Widget>[
      Container(
        color: Colors.white,
        height: 120,
        padding: EdgeInsets.only(top: 6, bottom: 0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              String singleTag = (state.games[index].singleTag != null &&
                      state.games[index].singleTag.length > 0)
                  ? state.games[index].singleTag[0]
                  : "";
              List<String> singleTagList = List();
              if (singleTag.isEmpty) {
              } else {
                List<String> singleTagData = singleTag.split("|");
                singleTagList = singleTagData;
              }
              String type = "";
              if (state.games[index].type != null &&
                  state.games[index].type.length > 0) {
                for (String typeString in state.games[index].type) {
                  type = type + (type.isEmpty ? "" : " | ") + typeString;
                }
              }

              return GestureDetector(
                onTap: () {
//                  dispatch(IndexRowGameActionCreator.gotoGameDetails(
//                      state.games[index].gameId));
                  AppUtil.gotoGameDetailOrH5Game(
                      viewService.context, state.games[index]);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 55,
                            child: ClipRRect(
                              child: HuoNetImage(
                                imageUrl: state.games[index].icon,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(11)),
                            ),
                          ),
                          singleTagList.length > 0
                              ? ClipPath(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(bottom: 5),
                                    height: 19,
                                    width: 55,
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
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 2),
                        child: Text(
                          state.games[index].gameName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: HuoTextSizes.mine_tab,
                              color: AppTheme.colors.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        width: 55,
                      ),
                      Container(
                        child: Text(
                          type,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.colors.textSubColor),
                        ),
                        width: 55,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: state.games.length),
      ),
      if (state.showLine) SplitLine(),
    ],
  );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height - 6.0); //第2个点
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEdnPoint = Offset(size.width, size.height - 6.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEdnPoint.dx, firstEdnPoint.dy);
    path.lineTo(size.width, size.height - 6.0); //第3个点
    path.lineTo(size.width, 0); //第4个点
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
