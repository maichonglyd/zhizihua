import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/component/video/screen_service.dart';
import 'package:flutter_huoshu_app/page/web/HuoWebViewUtil.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'action.dart';
import 'state.dart';

//JavascriptChannel _alertJavascriptChannel(BuildContext context) {
//  return ;
//}

Widget buildView(
    WebPageState state, Dispatch dispatch, ViewService viewService) {
  if (state.isH5Game) {
    return WillPopScope(
      onWillPop: () async {
        dispatch(WebPageActionCreator.showPopPageDialog());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: buildWebView(state, dispatch, viewService),
        ),
      ),
    );
  } else {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: huoTitle(state.title),
          leading: new IconButton(
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          child: buildWebView(state, dispatch, viewService),
        )));
  }
}

Widget buildWebView(
    WebPageState state, Dispatch dispatch, ViewService viewService) {
  return WebView(
    userAgent: state.userAgent,
    onWebViewCreated: (WebViewController webViewController) {
      dispatch(WebPageActionCreator.onWebViewCreated(webViewController));
    },
    onPageFinished: (url) {
      print("onPageFinished: ${url}");
      dispatch(WebPageActionCreator.onPageFinished(url));
    },
    debuggingEnabled: true,
    initialUrl: state.noHttpParam
        ? state.url
        : RequestUtil.urlAppendCommonParams(state.url),
    javascriptMode: JavascriptMode.unrestricted,
    javascriptChannels: <JavascriptChannel>[
//      _alertJavascriptChannel(viewService.context),
      state.javascriptChannel
    ].toSet(),
    navigationDelegate: (NavigationRequest navigation) {
      return HuoWebViewUtil.huoNavigationDelegate(navigation, state);
    },
  );
}
