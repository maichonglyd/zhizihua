import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealBuyAgreeState state, Dispatch dispatch, ViewService viewService) {
  DateTime lastPopTime;
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
              width: 271,
              height: 411,
              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    getText(name: 'textSellerNotice'),
                    style: TextStyle(
                        fontSize: 17,
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    getText(name: 'textPropDealTip1'),
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.colors.textSubColor,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 41,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffeeeeee), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp(r'\d+')),
                        LengthLimitingTextInputFormatter(11)
                      ],
                      keyboardType: TextInputType.text,
                      controller: state.mobileController,
                      decoration: InputDecoration(
                        hintText: getText(name: 'mobileInputHint'),
                        hintStyle: TextStyle(
                          color: AppTheme.colors.hintTextColor,
                        ),
                        contentPadding: EdgeInsets.only(left: 15),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyle(
                        color: AppTheme.colors.textColor,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 41,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffeeeeee), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              maxLength: 16,
                              controller: state.passwordController,
                              decoration: InputDecoration(
                                hintText: getText(name: 'textPleaseInputPassword'),
                                hintStyle: TextStyle(
                                  color: AppTheme.colors.hintTextColor,
                                ),
                                contentPadding: EdgeInsets.only(left: 15),
                                counterText: "",
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                color: AppTheme.colors.textColor,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: AppTheme.colors.themeColor,
                          value: true,
                          onChanged: (value) {}),
                      Text(
                        getText(name: 'textReadBuyerNotice'),
                        style: TextStyle(
                            fontSize: 12, color: AppTheme.colors.textSubColor2),
                      )
                    ],
                  ),
                  Row(
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
                            borderRadius: BorderRadius.all(Radius.circular(21)),
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
                        onTap: () {
                          if (lastPopTime == null ||
                              DateTime.now().difference(lastPopTime) >
                                  Duration(seconds: 2)) {
                            lastPopTime = DateTime.now();
                            dispatch(PropDealBuyAgreeActionCreator.commit());
                          } else {
                            lastPopTime = DateTime.now();
                            showToast(getText(name: 'toastClickRepeat'));
                          }
//                          dispatch(PropDealBuyAgreeActionCreator.commit());
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
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ));
}
