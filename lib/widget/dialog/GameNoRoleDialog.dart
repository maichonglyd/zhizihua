import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/index/turn_game_model/turn_game_stop_model.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

class GameNoRoleDialog extends StatefulWidget {
  Game game;

  GameNoRoleDialog({
    Key key,
    this.game,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GameNoRoleState();
  }
}

class GameNoRoleState extends State<GameNoRoleDialog> {
  GameNoRoleState();

  @override
  Widget build(BuildContext context) {
    return Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        child: Container(
          width: 290,
          height: 261,
          padding: EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 25),
                alignment: Alignment.center,
                child: Text(
                  getText(name: 'textTip'),
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor, fontSize: 15),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      child: HuoNetImage(
                        imageUrl:
                            widget.game.icon ?? '',
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 2),
                  //   child: Text(
                  //     '炫酷小子',
                  //     style: TextStyle(
                  //       color: AppTheme.colors.textSubColor,
                  //       fontSize: 14,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 14, bottom: 10),
                child: Text(
                  getText(name: 'textTurnGameBeforeCreateRole'),
                  style: TextStyle(
                    color: AppTheme.colors.textSubColor2,
                    fontSize: 12,
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
                    Container(
                      width: 120,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.colors.themeColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: DownView(game: widget.game,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
