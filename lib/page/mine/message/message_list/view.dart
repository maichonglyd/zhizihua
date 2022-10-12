import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/user/message_list_data.dart';
import 'package:flutter_huoshu_app/widget/huo_html_text/html_text_view.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MessageListState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Color(0xFFF8F8F8),
    appBar: AppBar(
      centerTitle: true,
      title: huoTitle(getText(name: 'textMessage')),
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
    body: state.refreshHelper.getEasyRefresh(
        ListView(
          children: state.messages
              .map((message) => buildItem(message, dispatch, viewService))
              .toList(),
        ), onRefresh: () {
      dispatch(MessageListActionCreator.getMessages(1));
    }, loadMore: (page) {
      dispatch(MessageListActionCreator.getMessages(page));
    },
        controller: state.refreshHelperController,
        emptyImageUrl: "Images/default_nonew.png"),
  );
}

Widget buildItem(Message message, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      dispatch(MessageListActionCreator.gotoDetail(message));
    },
    child: Container(
      margin: EdgeInsets.only(top: 7, left: 14, right: 14, bottom: 7),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                message.type == 1
                    ? "images/n_activity.png"
                    : "images/n_setting.png",
                height: 28,
                width: 28,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(message.type == 1 ? getText(name: 'textActivityMessage') : getText(name: 'textSystemMessage'),
                    style: TextStyle(
                        fontSize: 12, color: AppTheme.colors.textSubColor)),
              )),
              Text(AppUtil.formatDate1(message.createTime),
                  style: TextStyle(
                      fontSize: 12, color: AppTheme.colors.textSubColor)),
              message.status == 1
                  ? Container(
                      height: 4,
                      width: 4,
                      margin: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffff0000),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    )
                  : Container()
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Text(message.title),
          ),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 9),
            height: 1,
            color: AppTheme.colors.lineColor,
          ),
          Container(
            child: HtmlTextView(
              data: message.content,
            ),
          )
        ],
      ),
    ),
  );
}
