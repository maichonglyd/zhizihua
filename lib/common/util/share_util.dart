import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/model/user/share_info.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

void shareQQCustom(
    BuildContext context, ShareInfo shareInfo, Function(String type) callback) {
  print("shareQQCustom");
  print("Shareinfo is ${shareInfo.data.toJson()}");
  SSDKMap params = SSDKMap()
    ..setQQ(
        shareInfo.data.content,
        shareInfo.data.title,
        shareInfo.data.url,
        null,
        null,
        null,
        null,
        shareInfo.data.icon,
        null,
        shareInfo.data.icon,
        null,
        shareInfo.data.url,
        null,
        null,
        SSDKContentTypes.webpage,
        ShareSDKPlatforms.qq);
        SharesdkPlugin.share(ShareSDKPlatforms.qq, params, (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
            SSDKError error) {
          callback('qq');
          print(error.code);
          print(error.userInfo);
          print(userdata);
  });
}

void shareToWechat(
    BuildContext context, ShareInfo shareInfo, Function(String type) callback) {
  print("Shareinfo is ${shareInfo.data.toJson()}");
  SSDKMap params = SSDKMap()
    ..setWechat(
        shareInfo.data.content,
        shareInfo.data.title,
        shareInfo.data.url,
        null,
        [
          shareInfo.data.icon,
        ],
        null,
        null,
        shareInfo.data.icon,
        null,
        null,
        null,
        null,
        null,
        SSDKContentTypes.webpage,
        ShareSDKPlatforms.wechatSession);

  SharesdkPlugin.share(ShareSDKPlatforms.wechatSession, params,
      (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
          SSDKError error) {
        callback('wx');
        print(error.code);
        print(error.userInfo);
        print(userdata);
  });
}

void shareToWechatFavorites(
    BuildContext context, ShareInfo shareInfo, Function(String type) callback) {
  print("Shareinfo is ${shareInfo.data.toJson()}");
  SSDKMap params = SSDKMap()
    ..setWechat(
        shareInfo.data.content,
        shareInfo.data.title,
        shareInfo.data.url,
        null,
        [
          shareInfo.data.icon,
        ],
        null,
        null,
        shareInfo.data.icon,
        null,
        null,
        null,
        null,
        null,
        SSDKContentTypes.webpage,
        ShareSDKPlatforms.wechatTimeline);

  SharesdkPlugin.share(ShareSDKPlatforms.wechatTimeline, params,
      (SSDKResponseState state, dynamic userdata, dynamic contentEntity,
          SSDKError error) {
        callback('wxp');
        print(error.code);
        print(error.userInfo);
        print(userdata);
  });
}
