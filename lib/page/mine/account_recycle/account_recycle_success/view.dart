import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_commit/action.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AccountRecycleSuccessState state, Dispatch dispatch,
    ViewService viewService) {
  return Material(
    color: Colors.transparent,
    child: AnimatedPadding(
        padding: MediaQuery.of(viewService.context).viewInsets +
            const EdgeInsets.symmetric(),
        duration: Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: viewService.context,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      height: 204,
                      width: 275,
                      margin: EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    Image.asset(
                      "images/sucai_piandai.png",
                      width: 330,
                      height: 51,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      child: Text(
                        getText(name: 'textRecycleSuccessful'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 51),
                        height: 153,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              getText(name: 'textCongratulation'),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.colors.textColor),
                            ),
                            Image.asset(
                              "images/sucai_jinbi.png",
                              width: 85,
                              height: 61,
                            ),
                            Text(
                              "+${state.amount}${AppConfig.ptzName}",
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFFFF9500)),
                            ),
                          ],
                        )),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(viewService.context);
                        dispatch(AccountRecycleCommitActionCreator.close());
                      },
                      child: Image.asset(
                        "images/huosdk_yy_close.png",
                        height: 27,
                        width: 27,
                      ),
                    ))
              ],
            ),
          ),
        )),
  );
}
