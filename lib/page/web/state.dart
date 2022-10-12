import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:orientation/orientation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPageState implements Cloneable<WebPageState> {
  WebViewController webViewController;
  String url;
  String title = "";
  int gameId;

  int direction = 0;

  bool isTransparent = false;
  String userAgent;
  bool isH5Game = false;
  JavascriptChannel javascriptChannel;
  bool isPageFinish = false;
  bool noHttpParam = false;

  @override
  WebPageState clone() {
    return WebPageState()
      ..url = url
      ..userAgent = userAgent
      ..webViewController = webViewController
      ..javascriptChannel = javascriptChannel
      ..title = title
      ..direction = direction
      ..isH5Game = isH5Game
      ..isTransparent = isTransparent
      ..noHttpParam = noHttpParam;
  }
}

WebPageState initState(Map<String, dynamic> args) {
  WebView.platform = SurfaceAndroidWebView();
  print(args['url']);
  WebPageState state = WebPageState()
    ..url = args['url']
    ..title = args['title']
    ..gameId = args['game_id']
    ..direction = args['direction']
    ..isTransparent = args['transparent'] == null ? false : args['transparent']
    ..noHttpParam = args['noHttpParam'] == null ? false : args['noHttpParam'];
  if (args.containsKey("isH5Game")) {
    state.isH5Game = args['isH5Game'];
  }

  HuoLog.d("横竖屏方向 ${state.direction}");
  if (state.direction == 1) {
    //按照系统的方向来
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    //强制竖屏
    // OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
  } else {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //强制竖屏
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
  }
  return state;
}
