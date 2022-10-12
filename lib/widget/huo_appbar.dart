import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/game/game_search/page.dart';

class HuoAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool isShowBack;
  void Function() clickCall;

  HuoAppBar({this.title, this.isShowBack = false, this.clickCall});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Container(
            margin: EdgeInsets.only(top: 6),
            child: Row(
              children: <Widget>[
                Builder(builder: (BuildContext context) {
                  return isShowBack
                      ? IconButton(
                          iconSize: 44,
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                          icon: Image.asset(
                            "images/icon_toolbar_return_icon_dark.png",
                            height: 44,
                            width: 44,
                          ),
                          tooltip: MaterialLocalizations.of(context)
                              .backButtonTooltip,
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                        )
                      : Container();
                }),
                Container(
                  margin: EdgeInsets.only(left: 14),
                  child: Text(
                    this.title,
                    style: TextStyle(
                        fontSize: 18, color: AppTheme.colors.textColor),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: clickCall == null
                      ? () {
                          AppUtil.gotoPageByName(
                              context, GameSearchPage.pageName);
                        }
                      : clickCall,
                  child: Container(
                    height: 33,
                    padding: EdgeInsets.only(left: 12, right: 12),
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "images/tobar_ic_search_gray.png",
                          height: 24,
                          width: 24,
                        ),
                        Text(
                          getText(name: 'textSearchKeywords'),
                          style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.colors.textSubColor2),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.all(Radius.circular(17.5))),
                  ),
                )),
              ],
            )));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(44);
}
