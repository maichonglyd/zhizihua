import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/page/game/game_comment_response/page.dart';
import 'package:flutter_huoshu_app/widget/Star_widget.dart';
import 'package:flutter_huoshu_app/widget/expand_collapse/readmore.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameCommentItemState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 14, right: 14),
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              height: 30,
              width: 30,
              child: ClipOval(
                child: HuoNetImage(
                  imageUrl: state.comment.memAvatar,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(state.comment.memName, style: TextStyle(color: Color(0xFF3C77D7), fontSize: 13),),
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
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: ReadMoreText(
              state.comment.content,
              trimLines: 5,
              colorClickableText: AppTheme.colors.themeColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: getText(name: 'textCollapsed'),
              trimExpandedText: getText(name: 'textExpanded'),
            ),
          ),
        ),
        _buildOtherCommentView(state, dispatch, viewService),
        _buildCommentInfoView(state, dispatch, viewService),
      ],
    ),
  );
}

//一个字就显示全部的，两个字第一个字显示后面用*号代替,三个字以上中间显示*,如"大*******撒"
Widget buildText(String text) {
  String subText;
  StringBuffer sb = new StringBuffer();
  if (text.length <= 1) {
    subText = text;
  } else if (text.length == 2) {
    subText = "${text.substring(0, 1)}*";
  } else {
    for (int i = 0; i < text.length - 2; i++) {
      sb.write("*");
    }
    subText =
        "${text.substring(0, 1)}${sb.toString()}${text.substring(text.length - 1, text.length)}";
  }
  return Container(
    child: Text(subText),
  );
}

Widget _buildOtherCommentView(
    GameCommentItemState state, Dispatch dispatch, ViewService viewService) {
  if (null == state.comment.sub || state.comment.sub.length <= 0) {
    return SizedBox();
  }

  bool isOfficial = false;
  SubComment officialComment;
  for (SubComment subComment in state.comment.sub) {
    if (0 == subComment.memId) {
      isOfficial = true;
      officialComment = subComment;
    }
  }
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      AppUtil.gotoPageByName(
          viewService.context, GameCommentResponsePage.pageName,
          arguments: {'comment': state.comment, 'gameId': state.gameId});
    },
    child: Container(
      margin: EdgeInsets.only(left: 17, right: 14, top: 0, bottom: 10),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 2),
            decoration: BoxDecoration(
                color: AppTheme.colors.bgColor,
                borderRadius: BorderRadius.circular(3)),
            child: isOfficial
                ? _buildOfficialResponseView(
                    state, dispatch, viewService, officialComment)
                : _buildResponseView(state, dispatch, viewService),
          ),
          if (isOfficial)
            Positioned(
              left: 0,
              top: 9,
              child: Container(
                width: 66,
                height: 23,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/pic_response_bg_red.png"),
                  fit: BoxFit.fill,
                )),
                child: Text(
                  getText(name: 'textOfficialReply'),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildOfficialResponseView(GameCommentItemState state, Dispatch dispatch,
    ViewService viewService, SubComment comment) {
  return Container(
    margin: EdgeInsets.only(left: 15, top: 40, bottom: 18),
    decoration: BoxDecoration(
        color: AppTheme.colors.bgColor, borderRadius: BorderRadius.circular(3)),
    child: Text(
      comment.content ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
    ),
  );
}

Widget _buildResponseView(
    GameCommentItemState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgetList = [];
  for (int i = 0; i < state.comment.sub.length; i++) {
    if (i < 2) {
      widgetList.add(_buildOneResponseView(
          state, dispatch, viewService, state.comment.sub[i]));
    } else {
      break;
    }
  }

  if (2 < state.comment.sum) {
    widgetList.add(Container(
      margin: EdgeInsets.only(top: 2),
      child: Text(getText(name: 'textLookAllComment', args: [state.comment.sum ?? 0]),
          style:
          TextStyle(color: AppTheme.colors.hintTextColor, fontSize: 13)),
    ));
  }

  return Container(
    margin: EdgeInsets.only(left: 15, top: 10, bottom: 10),
    decoration: BoxDecoration(
        color: AppTheme.colors.bgColor, borderRadius: BorderRadius.circular(3)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgetList,
    ),
  );
}

Widget _buildOneResponseView(GameCommentItemState state, Dispatch dispatch,
    ViewService viewService, SubComment subComment) {
  return Container(
    margin: EdgeInsets.only(top: 0),
    child: Text.rich(TextSpan(children: [
      TextSpan(
        text: '${subComment.memName ?? ''}：',
        style: TextStyle(color: Color(0xFF3C77D7), fontSize: 13),
      ),
      TextSpan(
        text: subComment.content ?? '',
        style: TextStyle(color: AppTheme.colors.textColor, fontSize: 13),
      ),
    ])),
  );
}

Widget _buildCommentInfoView(
    GameCommentItemState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 14, bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            AppUtil.formatDate1(state.comment.createTime),
            style:
                TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor2),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            dispatch(GameCommentItemActionCreator.clickLike(
                state.comment.id, 2 == state.comment.isLike ? 1 : 2));
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoImage(
                2 == state.comment.isLike
                    ? 'images/ic_dianzan_active_small.png'
                    : 'images/icon_comment_good_grey.png',
              ),
              _buildInfoText('${state.comment.likeCnt ?? ''}', 30, rightMargin: 20),
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            AppUtil.gotoPageByName(
                viewService.context, GameCommentResponsePage.pageName,
                arguments: {'comment': state.comment, 'gameId': state.gameId});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoImage('images/icon_comment_count_grey.png'),
              _buildInfoText('${state.comment.sum}', 26),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoImage(String url, {Function() onClick}) {
  return Image.asset(
    url,
    width: 13,
    height: 13,
    fit: BoxFit.fill,
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
