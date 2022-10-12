import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/widget/down/down_view.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    VideoPlayState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Container(
                  width: 360,
                  child: AspectRatio(
                    aspectRatio: state.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(state.videoPlayerController),
                  ),
                ),
              ),
            ),
            state.videoPlayerController.value.isPlaying
                ? Container()
                : Align(
                    child: Container(
                        child: Image.asset('images/icon_n_play.png'),
                        height: 50,
                        width: 50),
                    alignment: Alignment.center,
                  ),
            Align(
                alignment: Alignment.topLeft,
                child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: 15, right: 15, top: 40),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: IconButton(
                        iconSize: 40,
                        icon: Image.asset(
                          "images/icon_close.png",
                          width: 44,
                          height: 44,
                        ),
                        onPressed: () {
                          Navigator.pop(viewService.context);
                        },
                      ),
                    ))),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 75,
                  margin: EdgeInsets.only(bottom: 30),
                  child: state.game != null
                      ? _buildGameInfo(state.game, viewService)
                      : Container()),
            ),
          ],
        ),
        onTap: () {
          dispatch(VideoPlayActionCreator.changeVideoState());
        }),
  );
}

Widget _buildGameInfo(Game game, ViewService viewService) {
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
            //这里要暂停视频播放
//            HuoVideoManager.pauseByType(HuoVideoManager.type_video);
            AppUtil.gotoGameDetailOrH5Game(viewService.context, game)
                .then((value) {
//              HuoVideoManager.playByType(HuoVideoManager.type_video);
            });
          },
        ),
      ),
    ],
  );
}
