import 'package:flutter/cupertino.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/component/video/huo_video_manager.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';

class AppNavigatorObserver extends RouteObserver<PageRoute<dynamic>> {
  var isTypeVideoPlay = false;

  /// The [Navigator] pushed `route`.
  ///
  /// The route immediately below that one, and thus the previously active
  /// route, is `previousRoute`.
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    var screenName = route.settings.name;
//    var previousScreenName = previousRoute.settings.name;
    if (VideoPlayPage.pageName == screenName) {
      VideoPlayPage.isCurrent = true;
    }
    HuoLog.d("didPush---screenName: $screenName");
    if ("/" != screenName) {
      if (GameDetailsPage.pageName == screenName) {
        HuoVideoManager.setViewActive(HuoVideoManager.type_game_detail);
        //暂停视频列表视频播放问题
        HuoVideoManager.setViewPause(HuoVideoManager.type_home);
      } else {
        //暂停视频列表视频播放问题
        HuoVideoManager.setViewActive(HuoVideoManager.type_other);
        HuoVideoManager.setViewPause(HuoVideoManager.type_home);
      }
    } else {
      HuoVideoManager.setViewActive(HuoVideoManager.type_home);
    }

  }

  /// The [Navigator] popped `route`.
  ///
  /// The route immediately below that one, and thus the newly active
  /// route, is `previousRoute`.
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    var screenName = route.settings.name;
    HuoLog.d("didPop---screenName: $screenName");
    //从别的页面回到主页，需要判断当前是否是视频底部tab,如果是，需要播放视频
    if (previousRoute != null) {
      if ("/" == previousRoute.settings.name) {
        HuoVideoManager.setViewActive(HuoVideoManager.type_home);
      }
    }
  }

  /// The [Navigator] removed `route`.
  ///
  /// If only one route is being removed, then the route immediately below
  /// that one, if any, is `previousRoute`.
  ///
  /// If multiple routes are being removed, then the route below the
  /// bottommost route being removed, if any, is `previousRoute`, and this
  /// method will be called once for each removed route, from the topmost route
  /// to the bottommost route.
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {}

  /// The [Navigator] replaced `oldRoute` with `newRoute`.
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {}

  /// The [Navigator]'s routes are being moved by a user gesture.
  ///
  /// For example, this is called when an iOS back gesture starts, and is used
  /// to disabled hero animations during such interactions.
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic> previousRoute) {}

  /// User gesture is no longer controlling the [Navigator].
  ///
  /// Paired with an earlier call to [didStartUserGesture].
  void didStopUserGesture() {}
}
