import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:orientation/orientation.dart';

class WebPageState implements Cloneable<WebPageState> {
  FlutterWebviewPlugin flutterWebViewPlugin;
  String url;
  String title = "";
  int gameId;

  int direction = 0;
  bool isTransparent = false;
  String userAgent;
  bool isH5Game = false;
  JavascriptChannel javascriptChannel;
  bool isPageFinish = false;
  bool isFullScreen = false;
  bool noHttpParam = false;

  @override
  WebPageState clone() {
    return WebPageState()
      ..url = url
      ..flutterWebViewPlugin = flutterWebViewPlugin
      ..javascriptChannel = javascriptChannel
      ..title = title
      ..direction = direction
      ..isH5Game = isH5Game
      ..isTransparent = isTransparent
      ..isPageFinish = isPageFinish
      ..isFullScreen = isFullScreen
      ..noHttpParam = noHttpParam;
  }
}

WebPageState initState(Map<String, dynamic> args) {
  HuoLog.d(args['url']);
  WebPageState state = WebPageState()
    ..url = args['url']
    ..title = args['title']
    ..direction = args['direction']
    ..isTransparent = args['transparent'] == null ? false : args['transparent']
    ..isFullScreen = args['isFullScreen'] == null ? false : args['isFullScreen']
    ..noHttpParam = args['noHttpParam'] == null ? false : args['noHttpParam'];
  if (args.containsKey("isH5Game")) {
    state.isH5Game = args['isH5Game'];
  }
  state.flutterWebViewPlugin = FlutterWebviewPlugin();
  HuoLog.d("更改h5游戏横竖屏${state.direction}");
  if (state.direction == 1) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    //强制竖屏
//    OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //强制竖屏
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
  }
  return state;
}
