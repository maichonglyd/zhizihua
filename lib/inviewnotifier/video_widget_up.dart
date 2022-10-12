import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';
import 'package:video_player/video_player.dart';

class VideoWidget2 extends StatefulWidget {
  final String url;
  final bool play;
  String videoType;
  bool noFootprint = true;
  bool onlyVideoShow = true;
  int gameId;
  bool isShowVolume = true;

  VideoWidget2(
      {Key key,
      @required this.url,
      @required this.play,
      this.videoType,
      this.noFootprint = true,
      this.onlyVideoShow = true,
      this.gameId,
      this.isShowVolume = true})
      : super(key: key);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget2> with HuoVideoListener {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

//  StreamSubscription _pauseSubscription;

  //控制音量的大小
  bool isShowVolume = true;
  Timer showTime;

  /// 是否显示控制拦
  bool showMeau = false;

  ///控制音量键是否显示
  bool isVolumeVisible = true;
  AnimationController controlBarAnimationController;
  bool initialized = false;
  StreamSubscription<ConnectivityResult> subscription;

  void handleInit(_) {
    HuoLog.d("初始化完成");
    initialized = true;
    HuoVideoManager.updateVideoInfo(
        widget.videoType, _controller.textureId, this);
    if (isShowVolume) {
      _controller.setVolume(1);
    } else {
      _controller.setVolume(0);
    }
    setState(() {});
//    _controller.play();
  }

  @override
  void huoVideoPause(String type, {int textureId}) {
    if (widget.videoType == type) {
      if (_controller != null) {
        if (textureId != null && textureId == _controller.textureId) {
          HuoLog.e("暂停了${type} ${textureId}");
          _controller.pause();
          if (mounted) {
            Future.delayed(Duration.zero, () {
              setState(() {
                showMeau = true;
              });
            });
          }
        } else if (textureId == null) {
          HuoLog.e("暂停了${type}");
          _controller.pause();
          if (mounted) {
            Future.delayed(Duration.zero, () {
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
      if (_controller != null) {
        if (textureId != null && textureId == _controller.textureId) {
          HuoLog.e("播放了${type} ${textureId}");
          _controller.play();
          if (mounted) {
            Future.delayed(Duration.zero, () {
              setState(() {
                showMeau = false;
              });
            });
          }
        } else if (textureId == null) {
          HuoLog.e("播放了${type}");
          _controller.play();
          if (mounted) {
            Future.delayed(Duration.zero, () {
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
  void initState() {
    super.initState();

    this.isShowVolume = widget.isShowVolume;
    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize().then(handleInit);
    if (widget.play) {
      HuoVideoManager.setViewActive(widget.videoType);
      _controller.setLooping(true);
    } else {
      HuoVideoManager.setViewPause(widget.videoType);
    }

    /// 网络监听
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.mobile) {
        //如果是流量,暂停视频就弹窗是否继续播放
        if (_controller.value.isPlaying) {
//          todo liuhongliang
//          HuoVideoManager.pauseByType(widget.index,
//              textureId: _controller.textureId);
//           showConfirmDialog();
        }
      } else if (result == ConnectivityResult.wifi) {
        //          todo liuhongliang
        //切换到wifi环境自动播放
        if (!_controller.value.isPlaying) {
//          HuoVideoManager.playByType(widget.index,
//              textureId: _controller.textureId);
        }
        entry?.remove();
        // showToast("当前wifi环境播放");
      } else {
        // showToast("当前没有网络！");
      }
    });
  }

  OverlayEntry entry;

  void showConfirmDialog() {
    final overlay = Overlay.of(context); // 获取一个overlay
// 创建一个OverlayEntry
//    final DialogTheme dialogTheme = DialogTheme.of(context);
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
//              color: dialogTheme.backgroundColor ??
//                  Theme.of(context).dialogBackgroundColor,
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
                              if (!_controller.value.isPlaying) {
                                //todo liuhongliang
//                                HuoVideoManager.playByType(widget.index,
//                                    textureId: _controller.textureId);
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
// 添加进来即可显示
    overlay.insert(entry);
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
//      if (showMeau) {
//        controlBarAnimationController.forward();
//      } else {
//        controlBarAnimationController.reverse();
//      }
    });
  }

  void createHideControlbarTimer() {
    clearHideControlbarTimer();

    ///如果是播放状态2秒后自动隐藏
    showTime = Timer(Duration(milliseconds: 2000), () {
      if (_controller != null && _controller.value.isPlaying) {
        if (showMeau) {
          setState(() {
            showMeau = false;
            isVolumeVisible = true;
//            controlBarAnimationController.reverse();
          });
        }
      }
    });
  }

  void clearHideControlbarTimer() {
    showTime?.cancel();
  }

  /// 点击播放或暂停
  void togglePlay() {
    if (_controller.value.isPlaying) {
      HuoVideoManager.setViewActive(widget.videoType);
      HuoVideoManager.videoPause(widget.videoType);
    } else {
      HuoVideoManager.setViewActive(widget.videoType);
      HuoVideoManager.videoPlay(widget.videoType);
    }
  }

  @override
  void deactivate() {
    if (_controller.value.isPlaying) {
      HuoVideoManager.videoPause(widget.videoType);
    }
    super.deactivate();
  }

  @override
  void didUpdateWidget(VideoWidget2 oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        HuoVideoManager.setViewActive(widget.videoType);
        HuoVideoManager.videoPlay(widget.videoType);
      } else {
        HuoVideoManager.setViewPause(widget.videoType);
        HuoVideoManager.videoPause(widget.videoType);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    HuoVideoManager.remove(widget.videoType);
    _controller.dispose();
    subscription.cancel();
//    _pauseSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        child: FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  //点击
                  //显示或隐藏菜单栏和进度条
                  if (widget.onlyVideoShow) {
                    AppUtil.gotoGameDetailById(context, widget.gameId);
                  } else {
                    toggleControls();
                  }
                },
                onDoubleTap: () {
                  //双击
                },
                child: ClipRRect(
                    child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: Center(
                      child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )),
                )),
              ),
              initialized && showMeau && !widget.onlyVideoShow
                  ? Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {
                            togglePlay();
                          },
                          child: Image.asset(
                            _controller.value.isPlaying
                                ? "images/icon_n_stop.png"
                                : "images/icon_n_play.png",
                            width: 50,
                            height: 50,
                          )),
                    )
                  : widget.onlyVideoShow && !widget.play
                      ? Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "images/icon_n_play.png",
                            width: 50,
                            height: 50,
                          ),
                        )
                      : Text(""),
              isVolumeVisible && widget.noFootprint
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 12, bottom: 12),
                          child: GestureDetector(
                            child: Image.asset(
                                isShowVolume
                                    ? "images/video_ic_shengyin_open.png"
                                    : "images/video_ic_shengyin_off.png",
                                width: 24,
                                height: 24),
                            onTap: () {
                              setState(() {
                                this.isShowVolume = !isShowVolume;
                                //处理音量
                                if (isShowVolume) {
                                  _controller.setVolume(1);
                                } else {
                                  _controller.setVolume(0);
                                }
                              });
                            },
                          )),
                    )
                  : Container()
            ],
          );
        } else {
          return GestureDetector(
            onTap: () {
              AppUtil.gotoGameDetailById(context, widget.gameId);
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: HuoNetImage(
                imageUrl: HuoVideoManager.getVideoFirstFrame(widget.url),
                fit: BoxFit.fill,
              ),
            ),
          );
//          return Center(
//            child: CircularProgressIndicator(),
//          );
        }
      },
    ));
  }
}
