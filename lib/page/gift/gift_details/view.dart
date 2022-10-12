import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/gift/my_gift_item/component.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GiftDetailsState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: huoTitle(getText(name: 'textGiftDetail')),
      centerTitle: true,
      elevation: 0,
      leading: new IconButton(
        icon: Image.asset(
          "images/icon_toolbar_return_icon_dark.png",
          width: 40,
          height: 44,
        ),
        onPressed: () {
          Navigator.pop(viewService.context);
        },
      ),
    ),
    body: RefreshHelper().getEasyRefresh(
        ListView(
          children: <Widget>[
            SplitLine(),
            Container(
              height: 84,
              padding: EdgeInsets.only(left: 14, right: 14),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          margin: EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            child: new HuoNetImage(
                              imageUrl: state.gift.gameIcon,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                state.gift.title,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.colors.textColor),
                              ),
                              Text(state.typeText,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11, color: Color(0xFFFF9666))),
                              Text(
                                  state.gift.giftCode != null
                                      ? getText(name: 'textGiftCode', args: [state.gift.giftCode])
                                      : getText(name: 'textFinishDate', args: [AppUtil.formatDate1(state.gift.endTime)]),
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: state.gift.giftCode != null
                                          ? AppTheme.colors.themeColor
                                          : AppTheme.colors.textSubColor2))
                            ],
                          ),
                        ),
                        Container(
                          height: HuoDimens.buttonheight1,
                          width: HuoDimens.buttonWidth1,
                          child: MaterialButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              dispatch(GiftDetailsActionCreator.addGift());
                            },
                            child: Text(
                              state.buttonText,
                              style: TextStyle(
                                  fontSize: 12, color: state.buttonColor),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(HuoDimens.buttonRadius)),
                              border: Border.all(color: state.buttonColor)),
                        )
                      ],
                    ),
                  )),
                  Container(
                    height: 1,
                    color: AppTheme.colors.lineColor,
                  )
                ],
              ),
            ),
            SplitLine(),
            buildDetailsItem(getText(name: 'textReceiveDeadline'),
                getText(name: 'textDateToDate', args: [AppUtil.formatDate2(state.gift.startTime), AppUtil.formatDate2(state.gift.endTime)])),
            buildDetailsItem(getText(name: 'textGiftContent'), state.gift.content),
            buildDetailsItem(getText(name: 'textUseMethod'), state.gift.func),
          ],
        ),
        controller: RefreshHelperController()),
  );
}

Widget buildDetailsItem(String title, String details) {
  return Container(
    padding: EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 15,
              width: 3,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: AppTheme.colors.themeColor,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
            ),
            Text(
              title,
              style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: HuoTextSizes.second_title),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 13, top: 5),
          child: Text(
            details,
            style: TextStyle(
                color: AppTheme.colors.textSubColor,
                fontSize: HuoTextSizes.index_tab),
          ),
        )
      ],
    ),
  );
}
