import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/api/request_util.dart';
import 'package:flutter_huoshu_app/common/util/sp_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/model/game/game_bean.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_details_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_sell_edit_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_buy_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_sell_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_buy_edit/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_sell_edit/page.dart';
import 'package:flutter_huoshu_app/page/game/game_comment/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/page/gift/my_gift/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_security/page.dart';
import 'package:flutter_huoshu_app/page/mine/coupon_center/page.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/game_currency_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_shop/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/lottery/page.dart';
import 'package:flutter_huoshu_app/page/mine/message/message_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_recharge/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_recharge/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/recharge_info/page.dart';
import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/page.dart';
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';
import 'package:flutter_huoshu_app/page/vip/member_center/page.dart';
import 'package:flutter_huoshu_app/page/vip/open_vip/page.dart';
import 'package:flutter_huoshu_app/page/vip/vip_center/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'date_format_base.dart';
import 'login_util.dart';

class AppUtil {
  /// ??????????????????
  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  /// ???????????????
  static Future<String> getClipboardContent() async {
    ClipboardData clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null) {
      return Future.value(clipboardData.text);
    }
    return Future.value(null);
  }

  //??????????????? 2019-10-10
  static String formatDate1(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
  }

  //??????????????? 2019-10-10 00:00
  static String formatDate2(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [
      yyyy,
      '-',
      mm,
      '-',
      dd,
      ' ',
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 2019-10-10
  static String formatDate3() {
    DateTime today = DateTime.now();
    String time = formatDate(today, [yyyy, '', mm, '', dd]);
    return time;
  }

  //??????????????? 2019-10-10 00:00
  static String formatDate4(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [
      mm,
      '-',
      dd,
      ' ',
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 2019-10-10 00:00???00
  static String formatDate5(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [
      yyyy,
      '-',
      mm,
      '-',
      dd,
      ' ',
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 2019-10-10
  static String formatDate6(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
  }

  //??????????????? 10-10
  static String formatDate10(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [mm, '-', dd]);
  }

  //??????????????? 2019-10-10
  static String formatDate7(int time) {
    if (null == time) time = 0;
    //?????????????????????
    DateTime today = DateTime.now();
    int currentYear = today.year;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    int year = dateTime.year;
    if (currentYear == year) {
      //??????10-10
      return formatDate(dateTime, [mm, '-', dd]);
    } else {
      return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
    }
  }

  //??????????????? 2019-10-10
  static String formatDate8(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [yyyy, '.', mm, '.', dd]);
  }

  //??????????????? 2019-10-10 00:00
  static String formatDate9(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [
      yyyy,
      '-',
      mm,
      '-',
      dd,
      ' ',
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 10-10 00:00
  static String formatDate12(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [mm, '-', dd, ' ', HH, ':', nn]);
  }

  //??????????????? 10???10???
  static String formatDate13(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime,
        [mm, getText(name: 'textMouth'), dd, getText(name: 'textDay')]);
  }

  //??????????????? 10???10??? 00:00
  static String formatDate14(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [
      mm,
      getText(name: 'textMouth'),
      dd,
      '${getText(name: 'textDay')} ',
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 10???10???00:00
  static String formatDate15(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [
      mm,
      getText(name: 'textMouth'),
      dd,
      getText(name: 'textDay'),
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 00:00
  static String formatDate16(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 10???10???00:00, ?????????????????????????????????
  static String formatDate17(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    int result = calculateDifference(dateTime);
    String hour = formatDate16(time);
    if (-1 == result) {
      return getText(name: "textYesterday") + hour;
    } else if (0 == result) {
      return getText(name: "textToday") + hour;
    } else if (1 == result) {
      return getText(name: "textTomorrow") + hour;
    }
    return formatDate(dateTime, [
      mm,
      getText(name: "textMouth"),
      dd,
      getText(name: "textDay"),
      HH,
      ':',
      nn,
    ]);
  }

  //??????????????? 2019-10-10 00:00
  static String formatDate18(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
  }

  //??????????????? 05-12 19:39
  static String formatDate19(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [mm, '-', dd, ' ', HH, ':', nn]);
  }

  ///??????????????????
  ///????????????
  static Future<String> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //?????????????????????????????????
        print(file.path);
      });*/
      print('??????????????????: ' + value.toString());

      return _renderSize(value);
    } catch (err) {
      print(err);
      return "0";
    }
  }

  ///?????????????????????
  static String _renderSize(double value) {
    if (null == value) {
      return "0";
    }
    List<String> unitArr = ['B', 'K', 'M', 'G'];
    int index = 0;
    while (value > 1000) {
      index++;
      value = value / 1000;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// ???????????? ?????????????????????
  static Future<double> _getTotalSizeOfFilesInDir(
      final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null)
          for (final FileSystemEntity child in children)
            total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  ///????????????
  static Future<String> clearCache() async {
    //??????????????????loading
    print("clearCache");
    try {
      Directory tempDir = await getTemporaryDirectory();
      //??????????????????
      await delDir(tempDir);
      return loadCache();
    } catch (e) {
      print(e);
      print("clearCache e: $e");
      return loadCache();
    } finally {
      //??????????????????loading
    }
  }

  ///????????????????????????
  static Future<Null> delDir(FileSystemEntity file) async {
    print("delDir");
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      print("delDir e: $e");
      print(e);
    }
  }

  static String getFinalString(String str) {
    return "";
  }

  static final List loginPages = [
    PtzRechargePage.pageName,
    GameCommitCommentPage.pageName,
    MyBuyListPage.pageName,
    MySellListPage.pageName,
    DealSellEditPage.pageName,
//    DealDetailsPage.pageName,
    MyWalletPage.pageName,
    MyGiftPage.pageName,
    AccountManagePage.pageName,
    RebateApplyPage.pageName,
    InviteListPage.pageName,
    TaskCenterPage.pageName,
    SecurityPage.pageName,
    IntegralShopPage.pageName,
    MessageListPage.pageName,
    LotteryPage.pageName,
    PropDealSellEditPage.pageName,
    PropDealBuyPage.pageName,
    AccountRecyclePage.pageName,
    InvitePage.pageName,
    MemberCenterPage.pageName,
    OpenVipPage.pageName,
    GameCoinRechargePage.pageName,
    RechargeInfoPage.pageName,
    VipOpenPage.pageName,
    GameCurrencyListPage.pageName,
    MineCurrRecordPage.pageName,
    MineCouponPage.pageName,
    CouponCenterPage.pageName,
  ];

//  ????????????
  static Future gotoPageByName(BuildContext context, String pageName,
      {arguments}) {
    if (!LoginControl.isLogin() && loginPages.contains(pageName)) {
      //????????????
      return Navigator.of(context).pushNamed(LoginPage.pageName);
    }
    //????????????
    return Navigator.of(context).pushNamed(pageName, arguments: arguments);
  }

  //  ????????????
  static Future gotoGameDetailOrH5Game(BuildContext context, Game game) {
    if (game.classify == 5) {
      //H5?????? ????????????
      if (!LoginControl.isLogin()) {
        return AppUtil.gotoPageByName(context, LoginPage.pageName);
      }
      //ios ???flutter_webview ???ios13.2????????????????????????????????????bug,?????????plugin_webview??????
      var pageName = WebPluginPage.pageName;
      if (Platform.isAndroid) {
        pageName = WebPage.pageName;
      }

      return AppUtil.gotoPageByName(context, pageName, arguments: {
        "url": game.downUrl,
        "title": game.gameName,
        "game_id": game.gameId,
        "isH5Game": true,
        "direction": game.direction,
        "isFullScreen": true,
      });
    } else {
      return AppUtil.gotoPageByName(context, GameDetailsPage.pageName,
          arguments: {"gameId": game.gameId});
    }
  }

  //?????????????????????
  static Future gotoGameDetail(BuildContext context, Game game) {
    return AppUtil.gotoPageByName(context, GameDetailsPage.pageName,
        arguments: {"gameId": game.gameId});
  }

  //??????????????????
  static Future gotoGameDetailById(BuildContext context, num gameId) {
    if (null == gameId || 0 == gameId) return Future(null);

    return AppUtil.gotoPageByName(context, GameDetailsPage.pageName,
        arguments: {"gameId": gameId});
  }

  //  ????????????
  static Future gotoH5Game(BuildContext context, String url, int direction,
      {String gameName}) {
    if (!LoginControl.isLogin()) {
      return AppUtil.gotoPageByName(context, LoginPage.pageName);
    }
    //ios ???flutter_webview ???ios13.2????????????????????????????????????bug,?????????plugin_webview??????
    var pageName = WebPluginPage.pageName;
    if (Platform.isAndroid) {
      pageName = WebPage.pageName;
    }
    return AppUtil.gotoPageByName(context, pageName, arguments: {
      "url": url,
      "title": gameName ?? getText(name: 'textH5Game'),
      "isH5Game": true,
      "direction": direction,
      "isFullScreen": true,
    });
  }

  //  ????????????
  static Future gotoH5Web(BuildContext context, String url,
      {String title, bool noHttpParam = false}) {
    if (!LoginControl.isLogin() && !noHttpParam) {
      return AppUtil.gotoPageByName(context, LoginPage.pageName);
    }

    var pageName = WebPluginPage.pageName;
    if (Platform.isAndroid) {
      pageName = WebPage.pageName;
    }
    return AppUtil.gotoPageByName(context, pageName, arguments: {
      "url": url,
      "title": title,
      "isH5Game": false,
      "noHttpParam": noHttpParam,
    });
  }

  static num stringToNum(String str) {
    try {
      return num.parse(str);
    } catch (e) {
      return 0;
    }
  }

  static String numToString(num var1, {int digits = 2}) {
    try {
      if (var1 == var1.toInt()) {
        return var1.toInt().toString();
      } else {
        return var1.toStringAsFixed(digits);
      }
    } catch (e) {
      return '0';
    }
  }

  static String stringToNumStr(String str) {
    try {
      var var1 = stringToNum(str);
      return numToString(var1);
    } catch (e) {
      return '0';
    }
  }

  static String timeToDate(num second) {
    num minute = second / 60;
    if (minute < 60) {
      return "$minute${getText(name: 'textMinute')}";
    } else if ((minute / 60) < 24) {
      return "${numToString(minute / 60)}${getText(name: 'textHour')}";
    } else {
      return "${numToString(minute / 60 / 24)}${getText(name: 'textOneDay')}";
    }
  }

  static String getObjectToString(Map<String, dynamic> json, String key) {
    try {
      return json[key];
    } catch (e) {
      return '';
    }
  }

  static String gameTypeTransport(
      List<String> type, String replace, int length) {
    if (null != type && type.length > 0) {
      String result = '';
      for (int i = 0; i < type.length; i++) {
        result += type[i];
        if (i != length - 1) {
          result += replace;
        } else {
          break;
        }
      }
      return result;
    }
    return '';
  }

  /// ?????????????????????
  /// ???????????? ????????????????????????????????????????????????????????????
  static Future<bool> checkPhonePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }

    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    if (permission != PermissionStatus.granted) {
      num date = SpUtil.prefs.getInt(SpUtil.PERMISSION_PHONE_LAST_TIME);
      if (null != date &&
          DateTime.now()
                  .difference(DateTime.fromMillisecondsSinceEpoch(date))
                  .inDays <
              2) {
        return false;
      }

      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler().requestPermissions([PermissionGroup.phone]);
      PermissionStatus status = permissions[PermissionGroup.phone];
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        SpUtil.prefs.setInt(SpUtil.PERMISSION_PHONE_LAST_TIME,
            DateTime.now().millisecondsSinceEpoch);
        return false;
      }
    } else {
      return true;
    }
  }
}
