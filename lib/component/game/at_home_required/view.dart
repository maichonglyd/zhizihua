import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_special_head/state.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameSpecialHeadState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    height: 100,
    margin: EdgeInsets.only(bottom: 0, top: 12),
    padding: EdgeInsets.only(
      left: 14,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(state, index, dispatch, viewService);
            },
            itemCount: state.gameSpecial.gameList.length,
          ),
        )
      ],
    ),
  );
}

TextStyle commonTextStyle(Color color, double size, FontWeight fontWeight) {
  return TextStyle(color: color, fontSize: size, fontWeight: fontWeight);
}

Widget buildItem(GameSpecialHeadState state, int index, Dispatch dispatch,
    ViewService viewService) {
  String singleTag = (state.gameSpecial.gameList[index].singleTag != null &&
          state.gameSpecial.gameList[index].singleTag.length > 0)
      ? state.gameSpecial.gameList[index].singleTag[0]
      : "";
  List<String> singleTagList = List();
  if (singleTag.isNotEmpty) {
    List<String> singleTagData = singleTag.split("|");
    singleTagList = singleTagData;
  }
  num rate = state.gameSpecial.gameList[index].rate * 10;

  String type = "";
  if (state.gameSpecial.gameList[index].type != null &&
      state.gameSpecial.gameList[index].type.length > 0) {
    for (String typeString in state.gameSpecial.gameList[index].type) {
      type = type + (type.isEmpty ? "" : " | ") + typeString;
    }
  }
  return GestureDetector(
    onTap: () {
//        AppUtil.gotoGameDetailOrH5Game(
//            viewService.context, state.gameSpecial.gameList[index]);
      AppUtil.gotoGameDetail(
          viewService.context, state.gameSpecial.gameList[index]);
    },
    child: Container(
      margin: EdgeInsets.only(right: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 55,
                width: 55,
                child: ClipRRect(
                  child: HuoNetImage(
                    imageUrl: state.gameSpecial.gameList[index].icon,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
              ),
              singleTagList.length > 0
                  ? ClipPath(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 2.5),
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
                          singleTagList[0],
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
              state.gameSpecial.gameList[index].gameName,
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
                  fontSize: HuoTextSizes.game_title_sub,
                  color: AppTheme.colors.textSubColor),
            ),
            width: 55,
          ),
        ],
      ),
    ),
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
