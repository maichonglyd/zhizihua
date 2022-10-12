import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/Service_help_info.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ServiceState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgets = List();
  widgets.add(Container(
    height: 34,
    width: 360,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Text(
      "常见问题",
      style: TextStyle(
          fontSize: HuoTextSizes.title, color: AppTheme.colors.textColor),
    ),
  ));
  widgets.add(Container(
    padding: EdgeInsets.only(left: 14, right: 14),
    color: AppTheme.colors.lineColor,
    height: 1,
  ));
  if (state.serviceInfo != null) {
    widgets.addAll(
        state.serviceInfo.data.faq.list.map((faq) => buildItem(faq)).toList());
  }

  return Stack(
    children: <Widget>[
      Image.asset(
        "images/n_bg.png",
        height: 250,
        fit: BoxFit.fill,
      ),
      Material(
          type: MaterialType.transparency,
          child: Container(
            margin: EdgeInsets.only(top: 150),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Container(
                  width: 230,
                  child: Text(getText(name: 'textServiceTimeDay') + "${null != state.serviceInfo ? state.serviceInfo.data.serviceTime ?? "" : ""}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0xff852C00))),
                )
              ],
            ),
          )),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: new IconButton(
            icon: Image.asset(
              "images/icon_n_toolbar_return_tint.png",
              width: 40,
              height: 44,
            ),
            onPressed: () {
              Navigator.pop(viewService.context);
            },
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 150),
            padding: EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: RefreshHelper().getEasyRefresh(
                        ListView(
                          children: widgets,
                        ),
                        controller: RefreshHelperController())),
                Container(
                  height: 55,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            dispatch(ServiceActionCreator.openCall());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: Color(0xFFFEF1EF),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/n_phone.png",
                                  height: 15,
                                  width: 15,
                                ),
                                Text(
                                  getText(name: 'textPhoneService'),
                                  style: TextStyle(color: Color(0xFFF35A58)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          dispatch(ServiceActionCreator.openQQ());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: Color(0xFFF2F8FE),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/n_qq.png",
                                height: 15,
                                width: 15,
                              ),
                              Text(
                                getText(name: 'textQQService'),
                                style: TextStyle(color: Color(0xFF73B0E1)),
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            )),
      ),
    ],
  );
}

Widget buildItem(Faq faq) {
  return Container(
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            faq.title,
            style: TextStyle(fontSize: 15, color: AppTheme.colors.textColor),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            faq.answer,
            style:
                TextStyle(fontSize: 13, color: AppTheme.colors.textSubColor2),
          ),
        ),
        Container(
          color: AppTheme.colors.lineColor,
          height: 1,
        )
      ],
    ),
  );
}
