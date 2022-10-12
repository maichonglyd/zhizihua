import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/video/video_list/action.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart' hide Image;
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/soft_key_board.dart';

class CommentDialog extends StatefulWidget {
  List<Comment> comment;
  int videoId;

  CommentDialog(this.comment, this.ctx, this.videoId);

  Context<VideoState> ctx;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceState(comment, ctx, videoId);
  }
}

class ServiceState extends State<CommentDialog> with WidgetsBindingObserver {
  List<Comment> comment;
  Context<VideoState> ctx;
  int videoId;
  bool isVisible = false;
  double keyboardHeight = 270.0;

  ServiceState(this.comment, this.ctx, this.videoId);

  FocusNode _focusNode = new FocusNode();

  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
//    widget.focusNode.addListener(_ensureVisible);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          //关闭键盘
          isVisible = false;
        } else {
          //显示键盘,消息内容滚动到底部
//          _focusNode.requestFocus(_focusNode);
          isVisible = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff1B1B1B),
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  "${comment.length}${getText(name: 'textCommentCount')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "images/video_ic_off.png",
                      height: 17,
                      width: 17,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: RefreshHelper().getEasyRefresh(
                  ListView(
                    children:
                        comment.map((ser) => buildItem(ser, ctx)).toList(),
                  ),
                  controller: RefreshHelperController())),
          Container(
            height: 42,
            color: Colors.black,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: contentController,
//                      focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: getText(name: 'textCommentSpeak'),
                      hintStyle: TextStyle(
                          color: AppTheme.colors.textSubColor, fontSize: 14),
                      contentPadding: EdgeInsets.only(left: 15, bottom: 13),
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
                GestureDetector(
                  onTap: () {
                    ctx.dispatch(VideoActionCreator.addComment(
                        videoId, contentController.text.toString()));
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10, left: 8),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Image.asset("images/ic_fasong_xxh.png"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8, left: 4),
                          child: Text(
                            getText(name: 'textSend'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffDDDDDD), fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Container(
              height: keyboardHeight,
            ),
          )
        ],
      ),
    );
  }

  Widget buildItem(Comment comment, Context<VideoState> ctx) {
    return Container(
      margin: EdgeInsets.only(top: 8, right: 8),
      padding: EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            child: ClipRRect(
              child: new HuoNetImage(
                imageUrl: comment.memAvatar,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    comment.memName,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    comment.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 4),
                ),
                Container(
                  child: Text(
                    AppUtil.formatDate2(comment.createTime),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 4),
                ),
              ],
            ),
          )),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print("点赞");
                  if (!LoginControl.isLogin()) {
                    AppUtil.gotoPageByName(context, LoginPage.pageName);
                    return;
                  }
                  comment.isLike == 1 ? comment.likeCnt++ : comment.likeCnt--;
                  ctx.dispatch(VideoActionCreator.commentsLike(
                      comment.id, comment.isLike == 1 ? 2 : 1));
                  comment.isLike == 1 ? comment.isLike = 2 : comment.isLike = 1;

                  setState(() {});
                },
                child: Container(
                  height: 30,
                  width: 30,
                  child: ClipRRect(
                    child: new Image.asset(
                      comment.isLike == 1
                          ? "images/ic_dianzan_gray_small.png"
                          : "images/ic_dianzan_active_small.png",
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              Container(
                child: Text(
                  comment.likeCnt.toString(),
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
