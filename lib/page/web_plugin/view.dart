import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/page/web_plugin/HuoWebViewUtil.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'action.dart';
import 'state.dart';

//JavascriptChannel _alertJavascriptChannel(BuildContext context) {
//  return ;
//}

Widget buildView(
    WebPageState state, Dispatch dispatch, ViewService viewService) {
  return buildWebView(state, dispatch, viewService);
}

Widget buildWebView(
    WebPageState state, Dispatch dispatch, ViewService viewService) {
  if (!state.isFullScreen) {
    return WebviewScaffold(
      url: RequestUtil.urlAppendCommonParams(state.url),
      javascriptChannels: <JavascriptChannel>[state.javascriptChannel].toSet(),
      mediaPlaybackRequiresUserGesture: false,
      userAgent: state.userAgent,
      withZoom: true,
      withLocalStorage: true,
      useWideViewPort: true,
      ignoreSSLErrors: true,
      appBar: AppBar(
        title: huoTitle(state.title),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
            "images/icon_toolbar_return_icon_dark.png",
            width: 40,
            height: 44,
          ),
          onPressed: () {
            Navigator.pop(viewService.context);
          },
        ),
      ),
    );
  }

  state.flutterWebViewPlugin.launch(
    state.noHttpParam ? state.url : RequestUtil.urlAppendCommonParams(state.url),
    mediaPlaybackRequiresUserGesture: false,
    userAgent: state.userAgent,
    javascriptChannels: <JavascriptChannel>[state.javascriptChannel].toSet(),
    withZoom: true,
    withLocalStorage: true,
    useWideViewPort: true,
    ignoreSSLErrors: true,
  );
  state.flutterWebViewPlugin.show();

  return AnimatedOpacity(
    duration: Duration(milliseconds: 300),
    opacity: 0.0,
    child: new Container(
      color: Colors.black,
      height: 100.0,
      child: new Center(
        child: new Text(getText(name: 'textLoading'), style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}
