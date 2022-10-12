import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/app_config.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AccountRecyclePaybackState state, Dispatch dispatch,
    ViewService viewService) {
  return AnimatedPadding(
      padding: MediaQuery.of(viewService.context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: viewService.context,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: 300,
              height: 305,
              padding: EdgeInsets.only(top: 17, bottom: 17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        getText(name: 'textPayPriceColon'),
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.colors.textSubColor),
                      ),
                      Text(
                        state.recycleProOrder.data.amount.toString(),
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFFF35A58)),
                      ),
                    ],
                  ),
                  Container(
                    color: AppTheme.colors.lineColor,
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            getText(name: 'textBalancePrice', args: [AppConfig.ptzName, state.recycleProOrder.data.ptbRemain]),
                            style: TextStyle(
                                color: AppTheme.colors.textSubColor3,
                                fontSize: 13),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      getText(name: 'textSelectPayWay'),
                      style: TextStyle(
                          color: AppTheme.colors.textColor, fontSize: 15),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: state.recycleProOrder.data.payWay
                        .asMap()
                        .keys
                        .map((index) {
                      var payWay = state.recycleProOrder.data.payWay[index];
                      return buildPayItem(dispatch, index, payWay.icon,
                          payWay.name, state.payIndex == index ? true : false);
                    }).toList(),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 17, right: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(viewService.context);
                          },
                          child: Container(
                            height: 41,
                            width: 111,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(21)),
                              border: Border.all(
                                color: AppTheme.colors.textSubColor3,
                              ),
                            ),
                            child: Text(
                              getText(name: 'textCancel'),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppTheme.colors.textSubColor),
                            ),
                          ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            dispatch(AccountRecyclePaybackActionCreator.pay());
                          },
                          child: Container(
                            height: 41,
                            width: 111,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21)),
                                color: AppTheme.colors.themeColor),
                            child: Text(
                              getText(name: 'textConfirm'),
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
}

Widget buildPayItem(
    Dispatch dispatch, int index, String image, String payType, bool isSelect) {
  return GestureDetector(
    onTap: () {
      dispatch(AccountRecyclePaybackActionCreator.switchPay(index));
    },
    child: Container(
      height: 95,
      width: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            child: HuoNetImage(
              imageUrl: image,
            ),
          ),
          Text(
            payType,
            style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 13),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          border: Border.all(
            color: Color(isSelect ? 0xFFF35A58 : 0xFFDDDDDD),
          )),
    ),
  );
}
