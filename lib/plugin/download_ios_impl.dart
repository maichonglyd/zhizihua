import 'dart:async';
import 'dart:convert' as JSON;

import 'package:flutter_huoshu_app/api/game_service.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/plugin/flutter_download_plugin.dart';
import 'package:flutter_huoshu_app/plugin/ipa_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/util/huo_log.dart';

class DownloadIosImpl {
  static var _timer;

  static init() {
    _timer = new Timer.periodic(new Duration(seconds: 5), (timer) {
      print("进来了定时器");
      downIpaMap.forEach((gameId, ipaInfo) {
        if (ipaInfo.ipaInstallUrl.isEmpty) {
          GameService.getDownUrl(ipaInfo.gameId,
                  udid: DeviceInfoUtil.deviceBean.mac, isShowToast: false)
              .then((data) {
            if (data['code'] != 55013 && data['code'] != 200) {
              downIpaMap[ipaInfo.gameId].status = DownloadStatus.RETRY;
            } else if (data["data"] != null &&
                data["data"]["down_url"] != null) {
              String downUrl = data["data"]["down_url"];
              if (data["data"]["is_web"] != null &&
                  data["data"]["is_web"].toString() == "2") {
                try {
                  HuoLog.d("downUrl = $downUrl");
                  launch(downUrl);
                } catch (e) {
                  print(e);
                }
                return;
              }

              if (downUrl.isNotEmpty && downUrl.startsWith("itms-services")) {
                downIpaMap[ipaInfo.gameId].status = DownloadStatus.INITIAL;
                downIpaMap[ipaInfo.gameId].ipaInstallUrl = downUrl;
                _launch(downUrl);
              }
            }
            FlutterDownloadPlugin.updateGameStatus(ipaInfo.gameId);
          });
        }
      });
    });
  }

  static _launch(String url) {
    print("准备打开的游戏地址为：" + url);
    launch(url);
  }

  static Map<int, IpaInfo> downIpaMap = Map();

  static startTask(String fileName, String fileUrl, int gameId) {
    print("进来了dddd");
    if (fileUrl.isNotEmpty && fileUrl.startsWith("itms-services")) {
      _launch(fileUrl);
    } else {
      if (!downIpaMap.containsKey(gameId)) {
        downIpaMap[gameId] =
            IpaInfo(gameId, DownloadStatus.DOWNLOADING, fileUrl);
      } else {
        if (downIpaMap[gameId].ipaInstallUrl.isNotEmpty &&
            downIpaMap[gameId].ipaInstallUrl.startsWith("itms-services")) {
          _launch(fileUrl);
        }
      }
    }
    FlutterDownloadPlugin.updateGameStatus(gameId);
  }

  static Future<int> getStatus(
      String fileName, String fileUrl, Game game) async {
    if (downIpaMap.containsKey(game.gameId)) {
      return Future.value(downIpaMap[game.gameId].status);
    }
    return Future.value(DownloadStatus.INITIAL);
  }
}
