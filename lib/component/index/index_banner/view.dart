import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/swiper_pagination.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_control_bar_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_loading_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_play_options.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_style.dart';
import 'package:flutter_huoshu_app/component/video/video_lib/video_top_bar_style.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/global_store/action.dart';
import 'package:flutter_huoshu_app/global_store/store.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/multi_click_button.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../video/huo_video_manager.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    IndexBannerState state, Dispatch dispatch, ViewService viewService) {
  return Column(
    children: <Widget>[
      Container(
        height: 210,
        margin: EdgeInsets.only(top: 12, bottom: 0, left: 10, right: 10),
        child: Swiper(
            onIndexChanged: (index) {
              HuoVideoManager.setViewActive(state.videoType + "#${index}");
//              state.swiperController.index = index;
            },
            itemCount: state.gameBannerItems.length,
            pagination: new SwiperPagination(
                alignment: Alignment.topLeft,
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                builder: LongDotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: AppTheme.colors.themeColor,
                    size: 4,
                    activeWidthSize: 13,
                    space: 6,
                    activeSize: 6)),
            controller: state.swiperController,
//            viewportFraction: 0.915,
            viewportFraction: 1,
            autoplayDelay: 6000,
            autoplay: (state.gameBannerItems != null &&
                        state.gameBannerItems.length > 0) &&
                    !state.hasVideo
                ? state.gameBannerItems[0].image.isNotEmpty
                : false,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  state.gameBannerItems[index].typeName != null &&
                          state.gameBannerItems[index].typeName == "game" &&
                          state.gameBannerItems[index].url.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.only(left: 4, right: 4),
                          child: ClipRRect(
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              child: AwsomeVideoPlayer(
                                state.gameBannerItems[index].url,
//                                    "https://sp.huoyx.cn/video/6226/xhdbz62261.mp4",
                                videoType: state.videoType + "#${index}",
                                isControllerPause: false,
                                playIndex: -1,
                                isVideoAspectRatio: true,
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
                                    aspectRatio:
                                        state.gameBannerItems[index].videoScale,
                                    loop: false,
                                    autoplay: true,
                                    allowScrubbing: true,
                                    startPosition: Duration(seconds: 0)),
                                isShowVolumeIcon: true,
                                onGotofullscreen: (controller) {
                                  //全屏切换的回调
                                  AppUtil.gotoPageByName(viewService.context,
                                      VideoPlayPage.pageName, arguments: {
                                    "controller": controller,
                                    "game": state.gameBannerItems[index].game
                                  }).then((data) {});
                                },
                                onended: (value) {
                                  //播放完成回调,需要重写这个方法,不然重新播放会有问题
                                  HuoLog.d("value $value");
                                  // 视频播放后自动播放下一个
                                  state.swiperController.next(animation: true);
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
//                                      "play",
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
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(5)),
                          ),
                        )
                      : GestureDetector(
                          child: Container(
                            height: 160,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 4, right: 4),
                            child: ClipRRect(
                                child: new HuoNetImage(
                                  imageUrl: state.gameBannerItems[index].image,
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                          ),
                          onTap: () {
                            dispatch(IndexBannerActionCreator.onClick(index));
                          },
                        ),
                  if (null != state.gameBannerItems[index].game)
                  _buildGotoGameDetail(state, viewService, dispatch,
                      state.gameBannerItems[index].game),
                ],
              );
            }),
      ),
    ],
  );
}

Widget _buildGotoGameDetail(
    IndexBannerState state, ViewService viewService, dispatch, Game game) {
  return Container(
      height: 50,
      margin: EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
          color: AppTheme.colors.groupColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: HuoNetImage(
              imageUrl: game.icon,
              placeholder: (context, url) => CircularProgressIndicator(),
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Text(game.oneWord,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(fontSize: 12, color: AppTheme.colors.textColor)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: ClickButton(
              child: Container(
                height: 27,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppTheme.colors.themeColor,
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: Text(
                  5 == game.classify ? getText(name: 'textToPlay') : getText(name: 'textToDownload'),
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              onClick: () {
                AppUtil.gotoGameDetail(viewService.context, game);
              },
            ),
          ),
        ],
      ));
}
