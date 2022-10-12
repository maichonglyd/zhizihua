import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/game/game_details_comment_item/view.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/widget/Star_widget.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(GameCommentResponseState state, Dispatch dispatch,
    ViewService viewService) {
  List<Widget> widgetList = [];
  if (null != state.comment) {
    widgetList.add(_buildMainCommentView(state, dispatch, viewService));
  }
  widgetList.add(SplitLine(
    height: 10,
  ));
  widgetList.add(_buildTitleView());
  if (null != state.commentList) {
    widgetList.addAll(state.commentList.map((value) =>
        _buildOtherCommentView(state, dispatch, viewService, value)));
  }

  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
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
    body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: state.refreshHelper.getEasyRefresh(
            ListView(
              children: widgetList,
            ),
            controller: state.refreshHelperController,
            onRefresh: () {
              dispatch(GameCommentResponseActionCreator.getData(1));
            },
            loadMore: (page) {
              dispatch(GameCommentResponseActionCreator.getData(page));
            }
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildCommentEditView(state, dispatch, viewService),
        )
      ],
    ),
  );
}

Widget _buildMainCommentView(GameCommentResponseState state, Dispatch dispatch,
    ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 14, right: 14),
    padding: EdgeInsets.only(bottom: 13),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              height: 30,
              width: 30,
              child: ClipOval(
                child: HuoNetImage(
                  imageUrl: state.comment.memAvatar ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTextView(state.comment.memName ?? ''),
                  StarWidget((state.comment.starCnt / 2).round()),
                ],
              ),
            ),
          ],
        ),
        Container(
          //修改为可以收缩的
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 19, top: 10, bottom: 10),
          child: Text(
            state.comment.content,
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
          ),
        ),
        _buildCommentInfoView(state, dispatch, viewService),
      ],
    ),
  );
}

Widget _buildCommentInfoView(GameCommentResponseState state, Dispatch dispatch,
    ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            AppUtil.formatDate19(state.comment.createTime),
            style:
                TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
          ),
        ),
        _buildInfoImage(
          2 == state.comment.isLike
              ? 'images/ic_dianzan_active_small.png'
              : 'images/icon_comment_good_grey.png',
          onClick: () {
            dispatch(GameCommentResponseActionCreator.clickLike());
          },
        ),
        _buildInfoText('${state.comment.likeCnt ?? ''}', 30),
      ],
    ),
  );
}

Widget _buildInfoImage(String url, {Function() onClick}) {
  return GestureDetector(
    onTap: () {
      if (null != onClick) {
        onClick();
      }
    },
    child: Image.asset(
      url,
      width: 13,
      height: 13,
      fit: BoxFit.fill,
    ),
  );
}

Widget _buildInfoText(String text, int flex, {double rightMargin = 0}) {
  return Container(
    padding: EdgeInsets.only(left: 2, right: rightMargin),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, color: Color(0xFFBBBBBB)),
    ),
  );
}

Widget _buildTitleView() {
  return Container(
    margin: EdgeInsets.only(left: 33, top: 14),
    child: Text(
      getText(name: 'textAllResponse'),
      style: TextStyle(
          color: AppTheme.colors.textColor,
          fontSize: 15,
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget _buildOtherCommentView(GameCommentResponseState state, Dispatch dispatch,
    ViewService viewService, Comment comment) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(left: 14, top: 14),
              child: ClipOval(
                child: HuoNetImage(
                  imageUrl: comment.memAvatar ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: _buildTextView(null != comment.memName && comment.memName.isNotEmpty ? comment.memName : getText(name: 'textOfficialReply')),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 33, top: 7),
          child: Text(
            comment.content ?? '',
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 33, top: 10, bottom: 6),
          child: Text(
            AppUtil.formatDate19(comment.createTime),
            style:
                TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCommentEditView(GameCommentResponseState state, Dispatch dispatch,
    ViewService viewService) {
  return Container(
    height: 58,
    padding: EdgeInsets.only(left: 14, right: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0x2A000000),
          offset: Offset(0, 1),
          blurRadius: 3,
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: AppTheme.colors.bgColor,
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: state.contentController,
              decoration: InputDecoration(
                hintText: getText(name: 'textPleaseInputComment'),
                hintStyle: TextStyle(
                    color: AppTheme.colors.textSubColor2, fontSize: 14),
                contentPadding: EdgeInsets.only(left: 15, bottom: 10),
                counterText: "",
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
              ),
              style: TextStyle(
                  color: AppTheme.colors.textSubColor,
                  fontSize: 14,
                  textBaseline: TextBaseline.alphabetic),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            dispatch(GameCommentResponseActionCreator.addComment());
          },
          child: Container(
            margin: EdgeInsets.only(left: 15),
            child: Image.asset(
              'images/chat_ic_send.png',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    ),
  );
}

Text _buildTextView(String text) {
  return Text(
    text ?? '',
    style: TextStyle(color: Color(0xFF3C77D7), fontSize: 13),
  );
}
