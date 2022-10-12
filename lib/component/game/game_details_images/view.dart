import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/component/index/index_row_game/view.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_control_bar_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_loading_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_play_options.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_top_bar_style.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/game_details.dart';
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/marquee/flutter_marquee.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GameDetailsImagesState state, Dispatch dispatch, ViewService viewService) {
  final double leading = 0.9;
  final double textLineHeight = 0.5;

  /// 文本间距
  return Column(
    children: <Widget>[
      Container(
          height: 180,
          color: Colors.white,
          padding: EdgeInsets.only(left: 10, right: 0, bottom: 10),
//          margin:EdgeInsets.only(left: 10, right: 10, bottom: 10) ,
          child: ListView(
            scrollDirection: Axis.horizontal,
            controller: state.scrollController,
            padding: EdgeInsets.all(0),
            children: <Widget>[
              state.news != null && state.news.length > 0
                  ? Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          child: ClipRRect(
                            child: Container(
                              height: 180,
                              child: AwsomeVideoPlayer(
                                state.news[0].videoUrl,
                                videoType: HuoVideoManager.type_game_detail,
                                isGameDetails: true,
                                isOpenVolume: VideoUtil.getOpenVolume(),

                                /// 视频播放配置
                                playOptions: VideoPlayOptions(
                                    seekSeconds: 30,
                                    //左侧垂直手势调节视频亮度的单位（0～1之间，不能小于0，不能大于1）
                                    brightnessGestureUnit: 0.05,
                                    //右侧垂直手势调节视频音量的单位（0～1之间，不能小于0，不能大于1）
                                    volumeGestureUnit: 0.05,
                                    //横行手势调节视频进度的单位秒数
                                    progressGestureUnit: 2000,
                                    loop: false,
                                    autoplay: true,
                                    allowScrubbing: true,
                                    startPosition: Duration(seconds: 0)),
                                isShowVolumeIcon: true,
                                onGotofullscreen: (controller) {
                                  //全屏切换的回调
                                  AppUtil.gotoPageByName(viewService.context,
                                      VideoPlayPage.pageName,
                                      arguments: {
                                        "controller": controller,
//                                    "game": state.news[0].game
                                        "game": null
                                      }).then((data) {});
                                },
                                onended: (value) {
                                  //播放完成回调,需要重写这个方法,不然重新播放会有问题
                                  HuoLog.d("value$value");
                                },

                                /// 自定义视频样式
                                videoStyle: VideoStyle(
                                  /// 自定义视频暂停时视频中部的播放按钮
                                  playIcon: Image.asset(
                                    "images/icon_n_play.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                  pauseIcon: Image.asset(
                                    "images/icon_n_stop.png",
                                    width: 40,
                                    height: 40,
                                  ),

                                  /// 暂停时是否显示视频中部播放按钮
                                  showPlayIcon: true,
                                  videoLoadingStyle: VideoLoadingStyle(
                                    /// 重写部分（二选一）
                                    // 重写Loading的widget
                                    // customLoadingIcon: CircularProgressIndicator(strokeWidth: 2.0),
                                    // 重写Loading 下方的Text widget
                                    // customLoadingText: Text("加载中..."),
                                    /// 设置部分（二选一）
                                    // 设置Loading icon 下方的文字
                                    loadingText: "Loading...",
                                    // 设置loading icon 下方的文字颜色
                                    loadingTextFontColor: Colors.white,
                                    // 设置loading icon 下方的文字大小
                                    loadingTextFontSize: 20,
                                  ),

                                  /// 自定义顶部控制栏
                                  videoTopBarStyle: VideoTopBarStyle(
                                    show: false,
                                    //是否显示
                                    height: 30,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    barBackgroundColor:
                                        Color.fromRGBO(0, 0, 0, 0.5),
                                    popIcon: Icon(
                                      Icons.arrow_back,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    contents: [
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            '123',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      )
                                    ], //自定义顶部控制栏中间显示区域
                                  ),

                                  /// 自定义底部控制栏
                                  videoControlBarStyle: VideoControlBarStyle(
                                    /// 自定义颜色
                                    // barBackgroundColor: Colors.blue,
                                    ///添加边距
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),

                                    ///设置控制拦的高度，默认为30，如果图标设置过大但是高度不够就会出现图标被裁剪的现象
                                    height: 40,

                                    /// 更改进度栏的播放按钮
                                    playIcon: Icon(Icons.play_arrow,
                                        color: Colors.white, size: 16),

                                    /// 更改进度栏的暂停按钮
                                    pauseIcon: Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                      size: 16,
                                    ),

                                    /// 更改进度栏的全屏按钮
                                    fullscreenIcon: Icon(
                                      Icons.fullscreen,
                                      size: 20,
                                      color: Colors.white,
                                    ),

                                    /// 决定控制栏的元素以及排序，示例见上方图3
                                    itemList: [
//                                  "play",
                                      "position-time",
                                      //当前播放时间
                                      "progress",
                                      //线条形进度条（与‘basic-progress’二选一）
                                      // "basic-progress",//矩形进度条（与‘progress’二选一）
                                      "duration-time",
                                      //视频总时长
                                      // "time",//格式：当前时间/视频总时长
                                      "fullscreen"
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        )
                      ],
                    )
                  : Container(),
              ListView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  children: state.images
                      .asMap()
                      .keys
                      .map((index) => GestureDetector(
                            onTap: () {
                              dispatch(
                                  GameDetailsImagesActionCreator.gotoGallery(
                                      index));
                            },
                            child: Hero(
                                tag: state.images[index].url,
                                child: Container(
                                    margin:
                                        EdgeInsets.only(left: 2.5, right: 2.5),
                                    height: 180,
                                    width: 108,
                                    child: ClipRRect(
                                      child: HuoNetImage(
                                        imageUrl: state.images[index].url,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    )
//                                  child: HuoNetImage(
//                                    imageUrl: state.images[index].url,
//                                    fit: BoxFit.cover,
//                                  ),
                                    )),
                          ))
                      .toList()),
            ],
          )),
      Container(
          width: 360,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: ExpandableNotifier(
            child: ScrollOnExpand(
              child: Column(
                children: [
                  Expandable(
                    collapsed: Text(
                      state.dec,
                      strutStyle: StrutStyle(
                          forceStrutHeight: true,
                          height: textLineHeight,
                          leading: leading),
                      softWrap: true,
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Text(
                      state.dec,
                      strutStyle: StrutStyle(
                          forceStrutHeight: true,
                          height: textLineHeight,
                          leading: leading),
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 12, color: AppTheme.colors.textSubColor),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Builder(
                      builder: (context) {
                        var controller =
                        ExpandableController.of(context, required: true);
                        return GestureDetector(
                          onTap: () {
                            controller.toggle();
                          },
                          child: controller.expanded ? Transform.rotate(
                              angle: pi,
                              child: Icon(
                                Icons.expand_more,
                                color: AppTheme.colors.textSubColor2,
                                size: 28,
                              )
                          ): Icon(
                            Icons.expand_more,
                            color: AppTheme.colors.textSubColor2,
                            size: 28,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
      if (state.vipDescription != null && state.isBt == 2)
        _buildVipItem(
            state, dispatch, viewService, getText(name: 'textVipIntroduction'), state.vipDescription.title),
      if (state.activityNews != null && state.activityNews.length >= 0)
        _buildActivityItem(
            state, dispatch, viewService, getText(name: 'textLatestActivity'), state.activityNews),
      SplitLine(),
      if (null != state.gameList && 0 < state.gameList.length)
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 14, top: 13, bottom: 10),
          child: Text(
            getText(name: 'textGameAbout'),
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      if (null != state.gameList && 0 < state.gameList.length)
        _buildGameListView(state, dispatch, viewService),
    ],
  );
}

Widget _buildActivityItem(GameDetailsImagesState state, Dispatch dispatch,
    ViewService viewService, String title, List<News> news) {
  return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        AppUtil.gotoH5Web(viewService.context, news[0].viewUrl,
            title: news[0].title);
      },
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 14),
        height: 52,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16),
              child: Text(
                title,
                style: TextStyle(
                    color: AppTheme.colors.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: FlutterMarquee(
                  children: news
                      .map((n) => Text(
                            n.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppTheme.colors.textSubColor,
                                fontSize: 14),
                          ))
                      .toList(),
                  onChange: (index) {
                    AppUtil.gotoH5Web(viewService.context, news[index].viewUrl,
                        title: news[index].title);
                  },
                  onRoll: (index) {
                    state.activityIndex = index;
                  },
                  animationDirection: AnimationDirection.t2b,
                  duration: 5),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ],
        ),
      ));
}

Widget _buildVipItem(GameDetailsImagesState state, Dispatch dispatch,
    ViewService viewService, String title, String subTitle) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      AppUtil.gotoH5Web(viewService.context, state.vipDescription.viewUrl,
          title: state.vipDescription.title);
    },
    child: Container(
      padding: EdgeInsets.only(left: 14, right: 14),
      height: 52,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Text(
              title,
              style: TextStyle(
                  color: AppTheme.colors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: AppTheme.colors.textSubColor, fontSize: 14),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 12,
          ),
        ],
      ),
    ),
  );
}

Widget _buildGameListView(
    GameDetailsImagesState state, Dispatch dispatch, ViewService viewService) {
  List<Game> games = [];
  if (null != state.gameList && state.gameList.length > 0) {
    games = state.gameList.sublist(0, 8 < state.gameList.length ? 8 : state.gameList.length);
  }
  return Container(
    margin: EdgeInsets.only(left: 24, right: 24, top: 10),
    child: Wrap(
      spacing: 24,
      runSpacing: 20,
      children: games.map((game) => _buildGameItemView(state, dispatch, viewService, game)).toList(),
    ),
  );
}

Widget _buildGameItemView(GameDetailsImagesState state, Dispatch dispatch,
    ViewService viewService, Game game) {
  String singleTag = (game.singleTag != null && game.singleTag.length > 0)
      ? game.singleTag[0]
      : "";
  List<String> singleTagList = List();
  if (singleTag.isEmpty) {
  } else {
    List<String> singleTagData = singleTag.split("|");
    singleTagList = singleTagData;
  }
  return GestureDetector(
    onTap: () {
      AppUtil.gotoGameDetailOrH5Game(viewService.context, game);
    },
    child: Container(
      width: 60,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                child: ClipRRect(
                  child: HuoNetImage(
                    imageUrl: game.icon,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                ),
              ),
              singleTagList.length > 0
                  ? ClipPath(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(bottom: 5),
                        height: 19,
                        width: 60,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xffFF5E46),
                              Color(0xffFF4040),
                            ]),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10))),
                        child: Text(
                          singleTagList.length > 0
                              ? singleTagList[0]
                              : singleTag,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      clipper: MyClipper(),
                    )
                  : Container(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 2),
            child: Text(
              game.gameName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: AppTheme.colors.textColor),
            ),
            width: 55,
          ),
          Container(
            child: Text(
              '${game.starCnt}分',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: AppTheme.colors.themeColor),
            ),
            width: 55,
          ),
        ],
      ),
    ),
  );
}
