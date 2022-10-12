import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_control_bar_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_loading_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_play_options.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_top_bar_style.dart';

import 'package:flutter_huoshu_app/component/video/video_list/action.dart';
import 'package:flutter_huoshu_app/component/video/video_list/state.dart';
import 'package:flutter_huoshu_app/component/video/volume/flutter_volume.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/model/game/new_list.dart';
import 'package:flutter_huoshu_app/page/game/game_search/page.dart';
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:video_player/video_player.dart';

import '../video_play_view_controller.dart';

Widget buildView(VideoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: MediaQuery.removeViewInsets(
        context: viewService.context,
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        child: Stack(
          children: <Widget>[
            (state.news != null && state.news.length > 0)
                ? Container(
                    child: Swiper(
                        itemCount: state.news.length,
                        controller: state.swiperController,
                        scrollDirection: Axis.vertical,
                        viewportFraction: 1,
                        autoplayDelay: 60000,
                        autoplay: false,
                        onIndexChanged: (index) {
                          //当切换页面的index变化时候调用,请求一下当前页面的资讯
                          dispatch(VideoActionCreator.onIndexChange(index));
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 720,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Container(
                                        color: Colors.black,
                                        width: 360,
                                        child: AwsomeVideoPlayer(
                                          state.news[index].videoUrl,
                                          isOpenVolume: state.isShowVolume,
                                          videoType:
                                              state.videoType + "#${index}",
                                          playIndex: index,

                                          /// 视频播放配置
                                          playOptions: VideoPlayOptions(
                                              seekSeconds: 30,
                                              //左侧垂直手势调节视频亮度的单位（0～1之间，不能小于0，不能大于1）
                                              brightnessGestureUnit: 0.05,
                                              //右侧垂直手势调节视频音量的单位（0～1之间，不能小于0，不能大于1）
                                              volumeGestureUnit: 0.05,
                                              //横行手势调节视频进度的单位秒数
                                              progressGestureUnit: 2000,
                                              aspectRatio:
                                                  state.news[index].videoScale,
                                              loop: true,
                                              autoplay: true,
                                              allowScrubbing: true,
                                              startPosition:
                                                  Duration(seconds: 0)),
                                          isShowVolumeIcon: false,
                                          onGotofullscreen: (controller) {
                                            //全屏切换的回调
                                            AppUtil.gotoPageByName(
                                                    viewService.context,
                                                    VideoPlayPage.pageName,
                                                    arguments: controller)
                                                .then((data) {});
                                          },
                                          onended: (value) {
                                            //播放完成回调,需要重写这个方法,不然重新播放会有问题
                                            print("value$value");
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
                                            videoLoadingStyle:
                                                VideoLoadingStyle(
                                              /// 重写部分（二选一）
                                              // 重写Loading的widget
                                              // customLoadingIcon: CircularProgressIndicator(strokeWidth: 2.0),
                                              // 重写Loading 下方的Text widget
                                              // customLoadingText: Text("加载中..."),
                                              /// 设置部分（二选一）
                                              // 设置Loading icon 下方的文字
                                              loadingText: "Loading...",
                                              // 设置loading icon 下方的文字颜色
                                              loadingTextFontColor:
                                                  Colors.white,
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
                                                    margin:
                                                        EdgeInsets.symmetric(
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
                                            videoControlBarStyle:
                                                VideoControlBarStyle(
                                              /// 自定义颜色
                                              // barBackgroundColor: Colors.blue,
                                              ///添加边距
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 10),

                                              ///设置控制拦的高度，默认为30，如果图标设置过大但是高度不够就会出现图标被裁剪的现象
                                              height: 40,

                                              /// 更改进度栏的播放按钮
                                              playIcon: Icon(Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 16),

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
                                                "position-time",
                                                //当前播放时间
                                                "progress",
                                                //线条形进度条（与‘basic-progress’二选一）
                                                // "basic-progress",//矩形进度条（与‘progress’二选一）
                                                "duration-time",
                                                //视频总时长
                                                // "time",//格式：当前时间/视频总时长
//                                        "fullscreen"
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        height: 75,
                                        margin: EdgeInsets.only(bottom: 25),
                                        child: state.news[index].game != null
                                            ? _buildGameInfo(
                                                state.news[index].game,
                                                viewService,
                                                state)
                                            : Container()),
                                  ),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 60),
                                        child: _buildRightView(
                                            state.news[index],
                                            viewService,
                                            dispatch,
                                            state),
                                      )),
                                ],
                              ),
                            ),
                          );
                        }))
                : Container(),
            SafeArea(
                child: Container(
                    margin: EdgeInsets.only(top: 6),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 14),
                          child: Text(
                            getText(name: 'textRecommendVideo'),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            //暂停播放
                            AppUtil.gotoPageByName(
                                viewService.context, GameSearchPage.pageName);
                          },
                          child: Container(
                            height: 33,
                            padding: EdgeInsets.only(left: 12, right: 12),
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "images/tobar_ic_search_gray.png",
                                  height: 24,
                                  width: 24,
                                ),
                                Text(
                                  getText(name: 'textSearchKeywords'),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.colors.textSubColor2),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0x28FFFFFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(17.5))),
                          ),
                        )),
                      ],
                    )))
          ],
        ),
      ));
}

Widget _buildGameInfo(Game game, ViewService viewService, VideoState state) {
//  HuoVideoManager.pauseByType(
//      HuoVideoManager.type_video);

  String sizeString;
  "${game.classify != 5 ? game.size : ""} ${game.classify == 5 || game.type.length <= 0 ? "" : "|"} ${game.type.length > 0 ? game.type[0] : ""}";
  return Column(
    children: <Widget>[
      Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 14,
          right: 14,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 70,
                width: 70,
                child: ClipRRect(
                  child: new HuoNetImage(
                    imageUrl: game.icon ?? "",
                    fit: BoxFit.fill,
                    height: 70,
                    width: 70,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 20,
                                  child: Row(
                                    children: <Widget>[
                                      LimitedBox(
                                        child: Text(
                                          game.gameName ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxWidth: 150,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(left: 10),
                                ),
                                Container(
                                  child: Text(
                                    sizeString ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(left: 10, top: 4),
                                ),
                                Container(
                                  child: Text(
                                    game.oneWord ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(left: 10, top: 4),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  ),
                ),
              ),
              DownView(game: game, type: TYPE_GAME_ITEM),
            ],
          ),
          onTap: () {
//            HuoVideoManager.setViewPause(state.videoType);
            AppUtil.gotoGameDetailOrH5Game(viewService.context, game);
          },
        ),
      ),
    ],
  );
}

Widget _buildRightView(
    New news, ViewService viewService, Dispatch dispatch, VideoState state) {
  DateTime lastClickTime;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: 10, right: 10),
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 14, right: 0),
                child: GestureDetector(
                  child: Image.asset(
                      state.isShowVolume
                          ? "images/video_ic_shengyin_open.png"
                          : "images/video_ic_shengyin_off.png",
                      width: 24,
                      height: 24),
                  onTap: () {
                    dispatch(VideoActionCreator.switchVolume());
                  },
                ),
              ),
              Image.asset(
                news.isLike == 2
                    ? "images/ic_dianzan_select.png"
                    : "images/ic_dianzan_normal.png",
                width: 38,
                height: 38,
              ),
              Text("${news.likeCnt}",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
          onTap: () {
            if (news.isLike != 2) {
              dispatch(VideoActionCreator.videoLike(news.id));
            }
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 14, bottom: 24, right: 10),
        child: GestureDetector(
          child: Column(
            children: <Widget>[
              Image.asset(
                "images/ic_plun_normal.png",
                width: 38,
                height: 38,
              ),
              Text("${news.commentCnt}",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
          onTap: () {
            dispatch(VideoActionCreator.getComment(news.id));
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 10, right: 10),
        child: GestureDetector(
          onTap: () {
            dispatch(VideoActionCreator.showShare(news));
          },
          child: Column(
            children: <Widget>[
              Image.asset(
                "images/ic_zfa_normal.png",
                width: 38,
                height: 38,
              ),
              Text("${news.shareCnt}",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
        ),
      ),
    ],
  );
}
