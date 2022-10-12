import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/video/screen_service.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_data.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_role_model.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_stop_model.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

class TurnGameDialog extends StatefulWidget {
  TurnGame toGame;
  TurnGameStopBean fromGame;
  List<TurnGameRoleBean> roleList;
  Function(num roleId, TurnGameStopBean fromGame) confirmFun;

  TurnGameDialog({
    Key key,
    this.toGame,
    this.fromGame,
    this.roleList,
    this.confirmFun,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TurnGameState();
  }
}

class TurnGameState extends State<TurnGameDialog> {
  bool roleViewExpand = false;
  int roleIndex = 0;

  TurnGameState();

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 290,
              height: 314,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 25),
                    alignment: Alignment.center,
                    child: Text(
                      getText(name: 'textSelectRightRole'),
                      style: TextStyle(
                          color: AppTheme.colors.textColor, fontSize: 15),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 96,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                child: HuoNetImage(
                                  imageUrl: widget.fromGame.icon ?? '',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                widget.fromGame.name ?? '',
                                style: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getText(name: 'textTurn'),
                              style: TextStyle(
                                  color: AppTheme.colors.themeColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Image.asset(
                                'images/pic_arrow_red.png',
                                width: double.infinity,
                                height: 10,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 96,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                child: HuoNetImage(
                                  imageUrl: widget.toGame.icon ?? '',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(
                                widget.toGame.name ?? '',
                                style: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32, bottom: 10),
                    child: Text(
                      getText(name: 'textSelectRightRoleToTurn'),
                      style: TextStyle(
                        color: AppTheme.colors.textSubColor2,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        roleViewExpand = !roleViewExpand;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppTheme.colors.bgColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 13),
                              child: Text(
                                widget.roleList[roleIndex].roleName ?? '',
                                style: TextStyle(
                                    color: AppTheme.colors.textColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 13),
                            child: Image.asset(
                              roleViewExpand
                                  ? 'images/icon_shangla_grey.png'
                                  : 'images/icon_xiala_grey.png',
                              width: 12,
                              height: 7,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 120,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                  color: AppTheme.colors.lineColor, width: 1),
                            ),
                            child: Text(
                              getText(name: 'textCancel'),
                              style: TextStyle(
                                  color: AppTheme.colors.textSubColor,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (null != widget.confirmFun) {
                              Navigator.pop(context);
                              widget.confirmFun(
                                  widget.roleList[roleIndex].roleId, widget.fromGame);
                            }
                          },
                          child: Container(
                            width: 120,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.colors.themeColor,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Text(
                              getText(name: 'textConfirmToTurn'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (roleViewExpand)
            Container(
              height: 120,
              margin: EdgeInsets.only(
                  top: ScreenService.halfHeight + 74, left: 50, right: 50),
              padding: EdgeInsets.only(left: 13, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x2A000000),
                    offset: Offset(0, 1), //阴影xy轴偏移量
                    blurRadius: 3.0, //阴影模糊程度
                  )
                ],
              ),
              child: ListView(
                children: widget.roleList
                    .asMap()
                    .keys
                    .map((index) => _buildRoleItemView(index))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildRoleItemView(int index) {
    TurnGameRoleBean bean = widget.roleList[index];
    return GestureDetector(
      onTap: () {
        _updateRole(index);
      },
      child: Container(
        padding: EdgeInsets.only(top: 2, bottom: 2),
        child: Text(
          bean.roleName ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
        ),
      ),
    );
  }

  void _updateRole(int index) {
    roleViewExpand = !roleViewExpand;
    roleIndex = index;
    setState(() {});
  }
}
