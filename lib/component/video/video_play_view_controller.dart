import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/component/video/screen_service.dart';

import 'package:video_player/video_player.dart';

class VideoController extends StatefulWidget {
  String image;
  final int positionTag;
  String video;

  VideoController({Key key, this.image, this.positionTag, this.video})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ViewControllerState();
  }
}

class ViewControllerState extends State<VideoController> {
  bool videoPrepared = false; //视频是否初始化
  bool _hideActionButton = true;
  VideoPlayerController _controller;
  double aspectRatio = 1;
  bool showVideoView = false;
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.video)
      ..initialize().then((_) {
        print("初始化成功" + widget.video);
        aspectRatio = _controller.value.aspectRatio;
        print(
            "初始化视频aspectRatio view" + _controller.value.aspectRatio.toString());
        videoPrepared = true;
        _controller.play();
        setState(() {});
      })
      ..setLooping(true).then((_) {});
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_controller.value.isPlaying) {
      _controller.pause();
      _hideActionButton = false;
    }
    print('deactivate');
  }

  @override
  void dispose() {
    _controller.dispose(); //释放播放器资源
    print("视频dispose");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    if (!_controller.value.isPlaying) {
//      _controller.play();
//      videoPrepared = true;
//      _hideActionButton = true;
//    }
    return getVideoViewMain();
  }

  Widget getVideoViewMain() {
    return Stack(
      children: <Widget>[
        GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Container(
                      color: Colors.black,
                      width: 360,
                      child: AspectRatio(
                        aspectRatio: aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                ),
                getPauseView()
              ],
            ),
            onTap: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
                _hideActionButton = false;
              } else {
                _controller.play();
                videoPrepared = true;
                _hideActionButton = true;
              }
              setState(() {});
            }),
        // getPreviewImg(),
      ],
    );
  }

  getPauseView() {
    return Offstage(
      offstage: _hideActionButton,
      child: Stack(
        children: <Widget>[
          Align(
            child: Container(
                child: Image.asset('images/ic_playing.png'),
                height: 50,
                width: 50),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }

  Widget getPreviewImg() {
    // var url;
    // HttpController.host.then((onValue) {
    //   url = onValue + widget.previewImgUrl;
    // });
    return Offstage(
        offstage: videoPrepared,
        child: Container(
          color: Colors.black,
          margin: EdgeInsets.only(top: ScreenService.topSafeHeight),
          child: Image.network(
            widget.image,
            // getUrl(widget.previewImgUrl),
            fit: BoxFit.fill,
            width: ScreenService.width,
            height: ScreenService.height,
          ),
        ));
  }
}
