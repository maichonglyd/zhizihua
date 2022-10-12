import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PropDealBuyState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textPropsDetail')),
      elevation: 1,
    ),
    body: Stack(
      children: <Widget>[
        RefreshHelper().getEasyRefresh(
            ListView(
              children: <Widget>[
                SplitLine(),
                buildGameItem(dispatch, state, viewService),
                SplitLine(),
                buildKnowItem(viewService),
                SplitLine(),
                buildEditGame(state, viewService),
                Container(
                  height: 200,
                )
              ],
            ),
            controller: RefreshHelperController()),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 360,
              height: 59,
              padding:
                  EdgeInsets.only(left: 30, bottom: 10, right: 30, top: 10),
              color: Colors.white,
              child: MaterialButton(
                onPressed: () {
                  dispatch(PropDealBuyActionCreator.buy());
                },
                height: 39,
                minWidth: 300,
                color: AppTheme.colors.themeColor,
                child: Text(
                  getText(name: 'textBuyNow'),
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            )),
      ],
    ),
  );
}

Widget buildGameItem(Dispatch dispatch, PropDealBuyState state, ViewService viewService) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 83,
      padding: EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          ClipRRect(
            child: new HuoNetImage(
              imageUrl: state.goods.gameIcon,
              placeholder: (context, url) => new CircularProgressIndicator(),
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(11)),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    state.goods.gameName,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.colors.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${getText(name: 'textCurrencySymbol')}${state.goods.price}",
                    style: TextStyle(fontSize: 15, color: Color(0xFFFF3300)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildKnowItem(ViewService viewService) {
  return Container(
    height: 121,
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            getText(name: 'textBuyerNotice'),
            style: TextStyle(
                fontSize: 16,
                color: AppTheme.colors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          getText(name: 'textBuyerTip1'),
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 13),
        ),
        Text(
          getText(name: 'textBuyerTip2'),
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 13),
        ),
        Text(
          getText(name: 'textBuyerTip3'),
          style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 13),
        )
      ],
    ),
  );
}

Widget buildEditGame(PropDealBuyState state, ViewService viewService) {
  return Container(
    padding: EdgeInsets.only(left: 14, right: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            getText(name: 'textInputGameDetail'),
            style: TextStyle(
                fontSize: 16,
                color: AppTheme.colors.textColor,
                fontWeight: FontWeight.w600),
          ),
        ),
        buildEditItem(state, getText(name: 'textBelongServiceColon'), 0),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        buildEditItem(state, getText(name: 'textRoleColon'), 1),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        buildEditItem(state, getText(name: 'textPhoneColon'), 2),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        buildEditItem(state, getText(name: 'textAccountColon'), 3),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        buildEditItem(state, getText(name: 'textPasswordColon'), 4),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
        buildEditItem(state, getText(name: 'textRemarkColon'), 5),
        Container(
          height: 1,
          color: AppTheme.colors.lineColor,
        ),
      ],
    ),
  );
}

Widget buildEditItem(PropDealBuyState state, String text, int index) {
  return Container(
    height: 50,
    child: Row(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 14, color: AppTheme.colors.textSubColor),
        ),
        Expanded(
            child: TextField(
          textAlign: TextAlign.left,
          inputFormatters: [
//            WhitelistingTextInputFormatter(RegExp(r'\d+')),
//            LengthLimitingTextInputFormatter(8)
          ],
          controller: state.textEditingControllers[index],
          keyboardType: index == 2 ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintStyle:
                TextStyle(color: AppTheme.colors.hintTextColor, fontSize: 14),
            contentPadding: EdgeInsets.only(left: 15),
            counterText: "",
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
          style: TextStyle(
            color: AppTheme.colors.textColor,
          ),
        )),
      ],
    ),
  );
}
