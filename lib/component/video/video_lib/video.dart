import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/video_util.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/dialog/TipDialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:orientation/orientation.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

import './video_play_options.dart';
import './video_style.dart';
import './widget/default_progress_bar.dart';
import './widget/linear_progress_bar.dart';
import './widget/video_bottom_bar.dart';
import './widget/video_loading_view.dart';
import './widget/video_top_bar.dart';

typedef VideoCallback<T> = void Function(T t);

/// 视频组件
class AwsomeVideoPlayer extends StatefulWidget {
  AwsomeVideoPlayer(this.dataSource,
      {Key key,
      VideoPlayOptions playOptions,
      VideoStyle videoStyle,
      this.children,
      this.oninit,
      this.onplay,
      this.onpause,
      this.ontimeupdate,
      this.onprogressdrag,
      this.onended,
      this.onvolume,
      this.onbrightness,
      this.onnetwork,
      this.isShowVolumeIcon,
      this.isInView = false,
      this.isOpenVolume = true,
      this.volumeIcon,
      this.onfullscreen,
      this.isShowFullScreenIcon,
      this.onGotofullscreen,
      this.isControllerPause = true,
      this.isGameDetails = false,
      this.isVideoAspectRatio = false,
      this.onpop,
      this.playIndex = -1,
      this.videoType})
      : playOptions = playOptions ?? VideoPlayOptions(),
        videoStyle = videoStyle ?? VideoStyle(),
        super(key: key);

  /// 视频资源
  final dataSource;

  /// 播放自定义属性
  final VideoPlayOptions playOptions;
  final VideoStyle videoStyle;
  final List<Widget> children;
  final bool isShowVolumeIcon;
  final bool isOpenVolume;
  final String volumeIcon;
  final String videoType;

  //列表播放的index
  final int playIndex;

  final bool isControllerPause;

  final bool isGameDetails;

  //视频的原始比例
  final bool isVideoAspectRatio;

  //是否在可视化界面
  final bool isInView;

  //是否显示全屏切换按钮
  final isShowFullScreenIcon;

  /// 初始化完成回调事件
  final VideoCallback<VideoPlayerController> oninit;

  /// 播放开始回调
  final VideoCallback<VideoPlayerValue> onplay;

  /// 播放开始回调
  final VideoCallback<VideoPlayerValue> ontimeupdate;

  /// 播放暂停回调
  final VideoCallback<VideoPlayerValue> onpause;

  /// 播放结束回调
  final VideoCallback<VideoPlayerValue> onended;

  /// 播放声音大小回调
  final VideoCallback<double> onvolume;

  /// 屏幕亮度回调
  final VideoCallback<double> onbrightness;

  /// 网络变化回调
  final VideoCallback<String> onnetwork;

  /// 屏幕亮度回调
  final VideoCallback<bool> onfullscreen;

//  final VideoCallback<Map<String,dynamic>> onfullscreen;

  //全屏回调,传一个controller过去
  final VideoCallback<VideoPlayerController> onGotofullscreen;

  //顶部控制栏点击返回回调
  final VideoCallback<VideoPlayerValue> onpop;

  /// 进度被拖拽的回调
  final VideoProgressDragHandle onprogressdrag;

  @override
  AwsomeVideoPlayerState createState() => AwsomeVideoPlayerState();
}

//WidgetsBindingObserver
class AwsomeVideoPlayerState extends State<AwsomeVideoPlayer>
    with
        SingleTickerProviderStateMixin,
        WidgetsBindingObserver,
        HuoVideoListener {
  /// 控制器 - 快进 seekTo 暂停 pause 播放 play 摧毁 dispose
  VideoPlayerController controller;

  AnimationController controlBarAnimationController;
  Animation<double> controlTopBarAnimation;
  Animation<double> controlBottomBarAnimation;

  /// 是否全屏
  bool fullscreened = false;
  bool initialized = false;

  /// 屏幕亮度
  double brightness;

  /// 是否显示控制拦
  bool showMeau = false;

  //控制音量的大小
  bool isShowVolume = true;

  //控制是否打开声音
  bool isOpenVolume = true;

  ///控制音量键是否显示
  bool isVolumeVisible = true;

  /// 是否正在缓冲
  bool checkBuffing = false;
  bool isBuffing = false;

  /// 是否结束
  bool isEnded = false;
  Timer showTime;
  String position = "--:--";
  String duration = "--:--";

  /// 获取屏幕大小
  Size get screenSize => MediaQuery.of(context).size;

  StreamSubscription<ConnectivityResult> subscription;
  int currentPlayIndex = 0;

  @override
  void huoVideoPause(String type, {int textureId}) {
    if (widget.videoType == type) {
      if (controller != null) {
        if (textureId != null && textureId == controller.textureId) {
          HuoLog.e("暂停了${type} ${textureId}");
          controller.pause();
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                showMeau = true;
              });
            });
          }
        } else if (textureId == null) {
          HuoLog.e("暂停了${type}");
          controller.pause();
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              /// 接口请求
              setState(() {
                showMeau = true;
              });
            });
          }
        }
      }
    }
  }

  @override
  void huoVideoPlay(String type, {int textureId}) {
    if (widget.videoType == type) {
      if (controller != null) {
        if (textureId != null && textureId == controller.textureId) {
          HuoLog.e("播放了${type} ${textureId}");
          controller.play();
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              /// 接口请求
              setState(() {
                showMeau = false;
              });
            });
          }
        } else if (textureId == null) {
          HuoLog.e("播放了${type}");
          controller.play();
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              /// 接口请求
              setState(() {
                showMeau = false;
              });
            });
          }
        }
      }
    }
  }

  @override
  void huoVideoVolumePause(String type, {int textureId}) {
    HuoLog.d("暂停声音了${type} ${textureId} ${widget.videoType}");
    if (widget.videoType == type) {
      if (controller != null) {
        HuoLog.d("暂停声音了${textureId} ${controller.textureId}");
        controller.setVolume(0);
      }
    }
  }

  @override
  void huoVideoVolumePlay(String type, {int textureId}) {
    HuoLog.e("播放声音了${type} ${textureId} ${widget.videoType}");
    if (widget.videoType == type) {
      if (controller != null) {
        HuoLog.d("播放声音了${textureId} ${controller.textureId}");
        controller.setVolume(1);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    this.isVolumeVisible = widget.isShowVolumeIcon;
    this.isOpenVolume = widget.isOpenVolume;
    this.isShowVolume = isOpenVolume;
    WidgetsBinding.instance.addObserver(this);

    /// 控制拦动画
    controlBarAnimationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    controlTopBarAnimation = Tween(
            begin: -(widget.videoStyle.videoTopBarStyle.height +
                widget.videoStyle.videoTopBarStyle.margin.vertical * 2),
            end: 0.0)
        .animate(controlBarAnimationController);
    controlBottomBarAnimation = Tween(
            begin: -(widget.videoStyle.videoTopBarStyle.height +
                widget.videoStyle.videoControlBarStyle.margin.vertical * 2),
            end: 0.0)
        .animate(controlBarAnimationController);

    var widgetsBinding = WidgetsBinding.instance;
    //监听系统的每一帧
    widgetsBinding.addPostFrameCallback((callback) {
      widgetsBinding.addPersistentFrameCallback((callback) {
        if (!mounted || context == null) return;
        var orientation = MediaQuery.of(context).orientation;
        bool _fullscreen;
        if (orientation == Orientation.landscape) {
          //横屏
          _fullscreen = true;
          SystemChrome.setEnabledSystemUIOverlays([]);
        } else if (orientation == Orientation.portrait) {
          _fullscreen = false;
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        }
        if (_fullscreen != fullscreened) {
          setState(() {
            fullscreened = !fullscreened;
            _navigateLocally(context);
            //触发全屏事件
            if (widget.onfullscreen != null) {
              widget.onfullscreen(fullscreened);
            }
          });
        }
        //触发一帧的绘制
        widgetsBinding.scheduleFrame();
      });
    });

    /// 网络监听
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.mobile) {
        //如果是流量,暂停视频就弹窗是否继续播放
        if (controller.value.isPlaying) {
//          todo liuhongliang
//          showConfirmDialog();
        }
      } else if (result == ConnectivityResult.wifi) {
        //切换到wifi环境自动播放,弹窗消失掉
//        entry?.remove();
      } else {
        showToast(getText(name: 'textNoNetwork'));
      }
    });
    initPlayer();
  }

  TipDialog dialog;
  OverlayEntry entry;

  void showConfirmDialog() {
    final overlay = Overlay.of(context); // 获取一个overlay
// 创建一个OverlayEntry
    if (entry == null) {
      entry = OverlayEntry(
        builder: (context) {
          return MediaQuery.removeViewInsets(
            removeLeft: true,
            removeTop: true,
            removeRight: true,
            removeBottom: true,
            context: context,
            child: Center(
              child: Material(
                color: Color(0x72000000),
                type: MaterialType.card,
                child: Container(
                  width: 271.0,
                  height: 183,
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Text(
                          getText(name: 'textTip'),
                          style: TextStyle(
                              fontSize: 17,
                              color: AppTheme.colors.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        getText(name: 'textNotWifi'),
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.colors.textSubColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: MaterialButton(
                              onPressed: () {
//                                Navigator.pop(context);
                                entry.remove();
                              },
                              child: Text(
                                getText(name: 'textCancel'),
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFD8D8D8), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21))),
                            width: 111,
                            height: 41,
                          ),
                          Container(
                            child: MaterialButton(
                              onPressed: () {
                                entry.remove();
                                if (!controller.value.isPlaying) {
                                  //todo liuhongliang
                                  HuoVideoManager.setViewActive(
                                      widget.videoType);
                                }
                              },
                              child: Text(
                                getText(name: 'textContinue'),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            width: 111,
                            height: 41,
                            decoration: BoxDecoration(
                                color: AppTheme.colors.themeColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21))),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
// 添加进来即可显示
    overlay.insert(entry);
  }

  @override
  void didUpdateWidget(AwsomeVideoPlayer oldWidget) {
    if (oldWidget.dataSource != widget.dataSource) {
      if (controller.value.isPlaying) {
        showMeau = true;
      }
      updateDataSource();
    }
    super.didUpdateWidget(oldWidget);
  }

  //不可见的时候暂停
  @override
  void deactivate() {
    print("deactivate:##########################");
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  //生命周期发生变化的时候
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    clearHideControlbarTimer();
    HuoVideoManager.remove(widget.videoType);
    controller.pause();
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    Screen.keepOn(false);
    subscription.cancel();
    super.dispose();
  }

  void updateDataSource() {
    controller.pause();
    HuoVideoManager.remove(widget.videoType);
    setState(() {
      controller = createVideoPlayerController()
        ..addListener(listener)
        ..initialize().then(handleInit);
    });
  }

  void resetVideoPlayer() {
    setState(() {
      isEnded = true;
      isVolumeVisible = false;
      position = "--:--";
      duration = "--:--";
      controller.value = VideoPlayerValue(duration: null);
    });
  }

  void listener() {
    if (!mounted) {
      return;
    }
    if (controller != null) {
      if (controller.value.isInitialized) {
        var oPosition = controller.value.position;
        var oDuration = controller.value.duration;

        if (widget.ontimeupdate != null) {
          widget.ontimeupdate(controller.value);
        }

        if (controller.value.buffered.length == 0) {
          setState(() {
            checkBuffing = true;
          });
        }
        if (checkBuffing) {
          setState(() {
            isBuffing = controller.value.isBuffering;
            if (!isBuffing) {
              checkBuffing = false;
            }
          });
        }
        // print("error: " + controller.value.errorDescription);

        if (controller.value.isPlaying) {
          if (oDuration.inHours == 0) {
            var strPosition = oPosition.toString().split('.')[0];
            var strDuration = oDuration.toString().split('.')[0];
            position =
                "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
            duration =
                "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
          } else {
            position = oPosition.toString().split('.')[0];
            duration = oDuration.toString().split('.')[0];
          }
          //显示菜单才刷新界面
          if (showMeau) {
            setState(() {});
          }
        } else {
          if (oPosition >= oDuration) {
            if (widget.onended != null) {
              resetVideoPlayer();
              widget.onended(controller.value);
            }
          }
        }
      }
    }
  }

  void handleInit(_) {
    print("初始化完成 video ${controller.textureId}");
    if (widget.oninit != null) {
      widget.oninit(controller);
    }
    initialized = true;
    //注册视频播放监听
    HuoVideoManager.updateVideoInfo(
        widget.videoType, controller.textureId, this);
    // 判断是否需要播放声音
    HuoVideoViewExt ext = HuoVideoManager.getHuoVideoViewExt(widget.videoType);
    if (null != ext) {
      if (ext.openAudio) {
        controller.setVolume(1);
      } else {
        controller.setVolume(0);
      }
    }

    setState(() {});
    isEnded = false;
  }

  //是否已经播放过了
  bool isPlayed = false;

  void initPlayer() {
    if (controller == null) {
      if (widget.dataSource == null || widget.dataSource == "") return;
      controller = createVideoPlayerController()
        ..addListener(listener)
        ..initialize().then(handleInit)
        ..setLooping(widget.playOptions.loop);
    }

    print("isInView: ${widget.isInView}");

    isPlayed = true;

    HuoVideoManager.updateVideoInfo(widget.videoType, 0, this);
    HuoVideoViewExt ext = HuoVideoManager.getHuoVideoViewExt(widget.videoType);
    if (null != ext) {
      ext.openAudio = isOpenVolume;
    }
  }

  /// 返回对应的Rect区域...
  static Rect getRectFromKey(BuildContext currentContext) {
    var object = currentContext?.findRenderObject();
    var translation = object?.getTransformTo(null)?.getTranslation();
    var size = object?.semanticBounds?.size;
    if (translation != null && size != null) {
      return new Rect.fromLTWH(
          translation.x, translation.y, size.width, size.height);
    } else {
      return null;
    }
  }

  /// 点击播放或暂停
  void togglePlay() {
    HuoLog.d("点击了播放按钮");
    createHideControlbarTimer();

    if (controller.value.isPlaying) {
      HuoVideoManager.setViewActive(widget.videoType);
      HuoVideoManager.videoPause(widget.videoType);
      if (widget.onpause != null) {
        widget.onpause(controller.value);
      }
    } else {
      HuoVideoManager.setViewActive(widget.videoType);
      HuoVideoManager.videoPlay(widget.videoType);
      if (widget.onplay != null) {
        widget.onplay(controller.value);
      }
    }
    setState(() {});
  }

  /// 点击全屏或取消(这里全屏显示有问题,所以只能打开一个横屏的页面进行播放)
  void toggleFullScreen() {
    if (fullscreened) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    } else {
      OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
    }
  }

  /// 点击全屏或取消(这里全屏显示有问题,所以只能打开一个横屏的页面进行播放)
  void gotoFullScreen() {
    if (widget.onGotofullscreen != null) {
      widget.onGotofullscreen(controller);
    }
  }

  /// 显示或隐藏菜单栏
  void toggleControls() {
    clearHideControlbarTimer();

    if (!showMeau) {
      showMeau = true;
      isVolumeVisible = false;
      createHideControlbarTimer();
    } else {
      showMeau = false;
      isVolumeVisible = true;
    }
    setState(() {
      if (showMeau) {
        controlBarAnimationController.forward();
      } else {
        controlBarAnimationController.reverse();
      }
    });
  }

  void createHideControlbarTimer() {
    clearHideControlbarTimer();

    ///如果是播放状态3秒后自动隐藏
    showTime = Timer(Duration(milliseconds: 3000), () {
      if (controller != null && controller.value.isPlaying) {
        if (showMeau) {
          setState(() {
            showMeau = false;
            isVolumeVisible = true;
            controlBarAnimationController.reverse();
          });
        }
      }
    });
  }

  void clearHideControlbarTimer() {
    showTime?.cancel();
  }

  /// 视频快退
  void fastRewind() {
    createHideControlbarTimer();
    setState(() {
      print(controller.value.position);
      var currentPosition = controller.value.position;
      controller.seekTo(Duration(
          seconds: currentPosition.inSeconds - widget.playOptions.seekSeconds));
    });
  }

  /// 视频快进
  void fastForward() {
    createHideControlbarTimer();
    setState(() {
      var currentPosition = controller.value.position;
      controller.seekTo(Duration(
          seconds: currentPosition.inSeconds + widget.playOptions.seekSeconds));
    });
  }

  /// 创建video controller
  VideoPlayerController createVideoPlayerController() {
    final netRegx = new RegExp(r'^(http|https):\/\/([\w.]+\/?)\S*');
    final fileRegx = new RegExp(r'^(file):\/\/([\w.]+\/?)\S*');
    final isNetwork = netRegx.hasMatch(widget.dataSource);
    final isFile = fileRegx.hasMatch(widget.dataSource);
    if (isNetwork) {
      return VideoPlayerController.network(widget.dataSource);
    } else if (isFile) {
      return VideoPlayerController.file(widget.dataSource);
    } else {
      return VideoPlayerController.asset(widget.dataSource);
    }
  }

  //计算设备的宽高比
  double _calculateAspectRatio(BuildContext context) {
    final width = screenSize.width;
    final height = screenSize.height;
    // return widget.playOptions.aspectRatio ?? controller.value.aspectRatio;
    return width > height ? width / height : height / width;
  }

  /// 动态生成进度条组件,这里不需要快进和快退按钮
  List<Widget> generateVideoProgressChildren() {
    Map<String, Widget> videoProgressWidgets = {
      "play": Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () {
            togglePlay();
          },
          child: controller.value.isPlaying
              ? widget.videoStyle.videoControlBarStyle.pauseIcon
              : widget.videoStyle.videoControlBarStyle.playIcon,
        ),
      ),

      ///线条视频进度条
      "progress": Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: VideoLinearProgressBar(controller,
              allowScrubbing: widget.playOptions.allowScrubbing,
              onprogressdrag: widget.onprogressdrag,
              padding:
                  widget.videoStyle.videoControlBarStyle.progressStyle.padding,
              progressStyle:
                  widget.videoStyle.videoControlBarStyle.progressStyle),
        ),
      ),

      ///默认视频进度条
      "basic-progress": Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: VideoDefaultProgressBar(controller,
              allowScrubbing: widget.playOptions.allowScrubbing,
              progressStyle:
                  widget.videoStyle.videoControlBarStyle.progressStyle),
        ),
      ),
      "time": Padding(
        padding: widget.videoStyle.videoControlBarStyle.timePadding,
        child: Text(
          "$position / $duration",
          style: TextStyle(
            color: widget.videoStyle.videoControlBarStyle.timeFontColor,
            fontSize: widget.videoStyle.videoControlBarStyle.timeFontSize,
          ),
        ),
      ),
      "position-time": Padding(
        padding: widget.videoStyle.videoControlBarStyle.timePadding,
        child: Text(
          "$position",
          style: TextStyle(
            color: widget.videoStyle.videoControlBarStyle.timeFontColor,
            fontSize: widget.videoStyle.videoControlBarStyle.timeFontSize,
          ),
        ),
      ),
      "duration-time": Padding(
        padding: widget.videoStyle.videoControlBarStyle.timePadding,
        child: Text(
          "$duration",
          style: TextStyle(
            color: widget.videoStyle.videoControlBarStyle.timeFontColor,
            fontSize: widget.videoStyle.videoControlBarStyle.timeFontSize,
          ),
        ),
      ),
      "fullscreen": Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Container(
              child: GestureDetector(
//            onTap: toggleFullScreen,
            onTap: gotoFullScreen,
            child: fullscreened
                ? widget.videoStyle.videoControlBarStyle.fullscreenExitIcon
                : widget.videoStyle.videoControlBarStyle.fullscreenIcon,
          ))),
    };

    List<Widget> videoProgressChildrens = [];
    var userSpecifyItem = widget.videoStyle.videoControlBarStyle.itemList;

    for (var i = 0; i < userSpecifyItem.length; i++) {
      videoProgressChildrens.add(videoProgressWidgets[userSpecifyItem[i]]);
    }
    return videoProgressChildrens;
  }

  /// 内置组件
  List<Widget> videoBuiltInChildrens() {
    return [
      /// 顶部控制拦
      widget.videoStyle.videoTopBarStyle.show
          ? VideoTopBar(
              animation: controlTopBarAnimation,
              videoTopBarStyle: widget.videoStyle.videoTopBarStyle,
              videoControlBarStyle: widget.videoStyle.videoControlBarStyle,
              onpop: () {
                if (fullscreened) {
                  toggleFullScreen();
                } else {
                  if (widget.onpop != null) {
                    widget.onpop(null);
                  }
                }
              })
          : Align(),

      /// 是否显示播放按钮,正在播放
      widget.videoStyle.showPlayIcon &&
              initialized &&
              !isEnded &&
              !isBuffing &&
              showMeau
          ? Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  togglePlay();
                },
                child: controller.value.isPlaying
                    ? widget.videoStyle.pauseIcon
                    : widget.videoStyle.playIcon,
              ),
            )
          : Text(""),

      /// 是否显示重播按钮
      initialized && isEnded
          ? Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  isEnded = false;
                  updateDataSource();
                  HuoVideoManager.videoPlay(widget.videoType);
                },
                child: widget.videoStyle.replayIcon,
              ),
            )
          : Text(""),

      /// 主字幕
      widget.videoStyle.videoSubtitlesStyle.mianTitle != null
          ? widget.videoStyle.videoSubtitlesStyle.mianTitle
          : Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
                child: Text("",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: widget
                            .videoStyle.videoSubtitlesStyle.mainTitleColor,
                        fontSize: widget
                            .videoStyle.videoSubtitlesStyle.mainTitleFontSize)),
              ),
            ),

      /// 辅字幕
      widget.videoStyle.videoSubtitlesStyle.subTitle != null
          ? widget.videoStyle.videoSubtitlesStyle.subTitle
          : Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text("",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            widget.videoStyle.videoSubtitlesStyle.subTitleColor,
                        fontSize: widget
                            .videoStyle.videoSubtitlesStyle.subTitleFontSize)),
              ),
            ),
      this.isVolumeVisible && widget.isShowVolumeIcon
          ? Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: GestureDetector(
                    child: Image.asset(
                        isShowVolume
                            ? "images/ic_shengyin_open.png"
                            : "images/ic_shengyin_off.png",
                        width: 28,
                        height: 28),
                    onTap: () {
                      setState(() {
                        this.isShowVolume = !isShowVolume;
                        //处理音量
                        if (isShowVolume) {
                          controller.setVolume(1);
                        } else {
                          controller.setVolume(0);
                        }
                      });
                    },
                  )),
            )
          : Container(),

      /// 底部控制拦
      VideoBottomBar(
        animation: controlBottomBarAnimation,
        videoControlBarStyle: widget.videoStyle.videoControlBarStyle,
        children: generateVideoProgressChildren(),
      ),

      /// Loading
      !initialized || isBuffing
          ? VideoLoadingView(loadingStyle: widget.videoStyle.videoLoadingStyle)
          : Align()
    ];
  }

  @override
  Widget build(BuildContext context) {
    /// Video children
    final videoChildrens = <Widget>[
      /// 视频区域
      GestureDetector(
          //点击
          onTap: () {
            //显示或隐藏菜单栏和进度条
            toggleControls();
          },
          //双击
          onDoubleTap: () {
            if (!controller.value.isInitialized) return;
            togglePlay();
          },

          ///视频播放器
          child: widget.isVideoAspectRatio
              ? ClipRRect(
                  child: Container(
                  height: double.infinity,
                  color: Colors.black,
                  child: Center(
                      child: AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller),
                  )),
                ))
              : !widget.isGameDetails
                  ? ClipRRect(
                      child: Container(
                      color: Colors.black,
                      child: Center(
                        child: VideoPlayer(controller),
                      ),
                    ))
                  : ClipRRect(
                      child: Container(
                      height: double.infinity,
                      color: Colors.black,
                      child: Center(
                          child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      )),
                    ))),

      ///控制拦以及(可拓展)元素
    ];

    /// 内置元素
    videoChildrens.addAll(videoBuiltInChildrens());

    /// 自定义拓展元素
    videoChildrens.addAll(widget.children ?? []);

    /// 构建video
    return RepaintBoundary(
        child: AspectRatio(
      aspectRatio: fullscreened
          ? _calculateAspectRatio(context)
          : widget.isGameDetails
          ? controller.value.aspectRatio : widget.playOptions.aspectRatio,

      /// build 所有video组件
      child: Stack(children: videoChildrens),
    ));
  }

  void _navigateLocally(context) async {
    if (!fullscreened) {
      if (ModalRoute.of(context).willHandlePopInternally) {
        Navigator.of(context).pop();
      }
      return;
    }
    ModalRoute.of(context).addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      if (fullscreened) toggleFullScreen();
    }));
  }
}
