import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/api/user_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/share_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/component/video/video_list/action.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart';
import 'package:flutter_huoshu_app/component/video/volume/flutter_volume.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/model/user/share_info.dart' as share;
import 'package:flutter_huoshu_app/model/user/share_info.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/widget/bottom_input_dialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/CommentDialog.dart';
import 'package:flutter_huoshu_app/widget/pop_route/pop_route.dart';
import 'package:oktoast/oktoast.dart';

Effect<VideoState> buildEffect() {
  return combineEffects(<Object, Effect<VideoState>>{
    VideoAction.action: _onAction,
    Lifecycle.initState: _initState,
    Lifecycle.deactivate: _deactivate,
    Lifecycle.dispose: _dispose,
    VideoAction.getComment: _getComment,
    VideoAction.commentsLike: _commentsLike,
    VideoAction.addComment: _addComment,
    VideoAction.getData: _getData,
    VideoAction.videoLike: _videoLike,
    VideoAction.showShare: _showShare,
    VideoAction.shareNotify: _shareNotify,
    VideoAction.onIndexChange: _onIndexChange,
  });
}

void _onIndexChange(Action action, Context<VideoState> ctx) {
  int index = action.payload;
  //暂停其他视频播放
  ctx.state.swiperController.index = index;
  HuoVideoManager.setViewActive(ctx.state.videoType + "#${index}");
  print("playIndex--_onIndexChange: $index");
}

//不可见的时候,重置状态
void _deactivate(Action action, Context<VideoState> ctx) {}

void _dispose(Action action, Context<VideoState> ctx) {
  print("_dispose");
}

void _onAction(Action action, Context<VideoState> ctx) {}

void _initState(Action action, Context<VideoState> ctx) {
  GameService.getNewList(12, 1, 200).then((data) {
    ctx.dispatch(VideoActionCreator.updateData(data.data.list));
  });

  // 获取视频声音是否播放
  ctx.dispatch(VideoActionCreator.updateVideoVolume(VideoUtil.getOpenVolume()));
}

void _getComment(Action action, Context<VideoState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }
  GameService.getCommentsList(action.payload, 1, 50).then((data) {
    showModalBottomSheet(
        context: ctx.context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return CommentDialog(data.data.list, ctx, action.payload);
        });
  });
}

void _commentsLike(Action action, Context<VideoState> ctx) {
  int commentId = action.payload['commentId'];
  int type = action.payload['type'];
  GameService.commentsLike(commentId, type).then((data) {});
}

void _addComment(Action action, Context<VideoState> ctx) {
  int objectId = action.payload['objectId'];
  String content = action.payload['content'];
  GameService.addComments(objectId, content).then((data) {
    if (data['code'] == 200) {
      showToast(getText(name: 'toastCommentSuccessful'));
    }
    ctx.dispatch(VideoActionCreator.updateData(data.data.list));
  });
}

void _videoLike(Action action, Context<VideoState> ctx) {
  //暂停播放
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }
  int newsId = action.payload['news_id'];
  GameService.videoLike(newsId).then((data) {
    ctx.dispatch(VideoActionCreator.getData());
  });
}

void _getData(Action action, Context<VideoState> ctx) {
  GameService.getNewList(12, 1, 200).then((data) {
    ctx.dispatch(VideoActionCreator.updateData(data.data.list));
  });
}

void _showShare(Action action, Context<VideoState> ctx) {
  if (!LoginControl.isLogin()) {
    AppUtil.gotoPageByName(ctx.context, LoginPage.pageName);
    return;
  }
  New news = action.payload;
  UserService.getShareDataByGame(news.game.gameId).then((data) {
    if (data.code == 200) {
      showModalBottomSheet(
          context: ctx.context,
          backgroundColor: Colors.transparent,
          builder: (BuildContext context) {
            return Container(
              height: 150,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      print("启动微信好友分享");
                      //等待dialog
                      showToast(getText(name: 'toastStartShare'));
                      shareToWechat(context, data, (type) {
                        ctx.dispatch(VideoActionCreator.shareNotify(news.id));
                        Navigator.pop(context);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "images/share_wechat.png",
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          getText(name: 'textWxFriend'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("启动微信朋友圈分享");
                      shareToWechatFavorites(context, data, (type) {
                        ctx.dispatch(VideoActionCreator.shareNotify(news.id));
                        Navigator.pop(context);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "images/share_circle.png",
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          getText(name: 'textFriendGroup'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("启动QQ好友分享");
                      showToast(getText(name: 'toastStartShare'));
                      shareQQCustom(context, data, (type) {
                        ctx.dispatch(VideoActionCreator.shareNotify(news.id));
                        Navigator.pop(context);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "images/share_qq.png",
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          getText(name: 'textQQ'),
                          style: TextStyle(
                              color: AppTheme.colors.textSubColor,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
            );
          });
    }
  });
}

void _shareNotify(Action action, Context<VideoState> ctx) {
  showToast(getText(name: 'textShareSuccessful'));
  int newsId = action.payload;
  GameService.shareNotify(newsId).then((data) {
    ctx.dispatch(VideoActionCreator.getData());
  });
}
