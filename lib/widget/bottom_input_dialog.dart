import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/refresh_helper.dart';
import 'package:flutter_huoshu_app/component/video/video_list/action.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_comments.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart' hide Image;
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

class BottomInputDialog extends StatefulWidget {
  List<Comment> comment;
  int videoId;

  BottomInputDialog(this.comment, this.ctx, this.videoId);

  Context<VideoState> ctx;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceState(comment, ctx, videoId);
  }
}

class ServiceState extends State<BottomInputDialog> {
  List<Comment> comment;
  Context<VideoState> ctx;
  int videoId;

  ServiceState(this.comment, this.ctx, this.videoId);

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Color(0xff1B1B1B),
        height: 400,
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
                      autofocus: true,
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
            )
          ],
        ),
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
                  comment.isLike == 1 ? comment.likeCnt++ : comment.likeCnt--;
                  ctx.dispatch(VideoActionCreator.commentsLike(
                      comment.id, comment.isLike == 1 ? 1 : 0));
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
