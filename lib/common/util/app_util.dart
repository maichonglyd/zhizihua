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
  /// 复制到剪粘板
  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  /// 获取剪粘板
  static Future<String> getClipboardContent() async {
    ClipboardData clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null) {
      return Future.value(clipboardData.text);
    }
    return Future.value(null);
  }

  //时间格式化 2019-10-10
  static String formatDate1(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
  }

  //时间格式化 2019-10-10 00:00
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

  //时间格式化 2019-10-10
  static String formatDate3() {
    DateTime today = DateTime.now();
    String time = formatDate(today, [yyyy, '', mm, '', dd]);
    return time;
  }

  //时间格式化 2019-10-10 00:00
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

  //时间格式化 2019-10-10 00:00：00
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

  //时间格式化 2019-10-10
  static String formatDate6(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
  }

  //时间格式化 10-10
  static String formatDate10(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [mm, '-', dd]);
  }

  //时间格式化 2019-10-10
  static String formatDate7(int time) {
    if (null == time) time = 0;
    //查询是否是今年
    DateTime today = DateTime.now();
    int currentYear = today.year;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    int year = dateTime.year;
    if (currentYear == year) {
      //返回10-10
      return formatDate(dateTime, [mm, '-', dd]);
    } else {
      return formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
    }
  }

  //时间格式化 2019-10-10
  static String formatDate8(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [yyyy, '.', mm, '.', dd]);
  }

  //时间格式化 2019-10-10 00:00
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

  //时间格式化 10-10 00:00
  static String formatDate12(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [mm, '-', dd, ' ', HH, ':', nn]);
  }

  //时间格式化 10月10日
  static String formatDate13(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(dateTime, [mm, getText(name: 'textMouth'), dd, getText(name: 'textDay')]);
  }

  //时间格式化 10月10号 00:00
  static String formatDate14(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(
        dateTime, [mm, getText(name: 'textMouth'), dd, '${getText(name: 'textDay')} ', HH, ':', nn,]);
  }

  //时间格式化 10月10号00:00
  static String formatDate15(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(
        dateTime, [mm, getText(name: 'textMouth'), dd, getText(name: 'textDay'), HH, ':', nn,]);
  }

  //时间格式化 00:00
  static String formatDate16(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(
        dateTime, [HH, ':', nn,]);
  }

  //时间格式化 10月10号00:00, 并判断是否是今天或明天
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
    return formatDate(
        dateTime, [mm, getText(name: "textMouth"), dd, getText(name: "textDay"), HH, ':', nn,]);
  }

  //时间格式化 2019-10-10 00:00
  static String formatDate18(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(
        dateTime, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn]);
  }

  //时间格式化 05-12 19:39
  static String formatDate19(int time) {
    if (null == time) time = 0;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return formatDate(
        dateTime, [mm, '-', dd, ' ', HH, ':', nn]);
  }

  ///获取缓存大小
  ///加载缓存
  static Future<String> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        print(file.path);
      });*/
      print('临时目录大小: ' + value.toString());

      return _renderSize(value);
    } catch (err) {
      print(err);
      return "0";
    }
  }

  ///格式化文件大小
  static String _renderSize(double value) {
    if (null == value) {
      return "0";
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1000) {
      index++;
      value = value / 1000;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 递归方式 计算文件的大小
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

  ///清除缓存
  static Future<String> clearCache() async {
    //此处展示加载loading
    print("clearCache");
    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await delDir(tempDir);
      return loadCache();
    } catch (e) {
      print(e);
      print("clearCache e: $e");
      return loadCache();
    } finally {
      //此处隐藏加载loading
    }
  }

  ///递归方式删除目录
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

//  跳转页面
  static Future gotoPageByName(BuildContext context, String pageName,
      {arguments}) {
    if (!LoginControl.isLogin() && loginPages.contains(pageName)) {
      //跳转登录
      return Navigator.of(context).pushNamed(LoginPage.pageName);
    }
    //跳转页面
    return Navigator.of(context).pushNamed(pageName, arguments: arguments);
  }

  //  跳转页面
  static Future gotoGameDetailOrH5Game(BuildContext context, Game game) {
    if (game.classify == 5) {
      //H5游戏 打开网页
      if (!LoginControl.isLogin()) {
        return AppUtil.gotoPageByName(context, LoginPage.pageName);
      }
      //ios 的flutter_webview 在ios13.2上播放声音会导致浮点出现bug,更改为plugin_webview实现
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

  //跳转游戏详情给
  static Future gotoGameDetail(BuildContext context, Game game) {
    return AppUtil.gotoPageByName(context, GameDetailsPage.pageName,
        arguments: {"gameId": game.gameId});
  }

  //跳转游戏详情
  static Future gotoGameDetailById(BuildContext context, num gameId) {
    if (null == gameId || 0 == gameId) return Future(null);

    return AppUtil.gotoPageByName(context, GameDetailsPage.pageName,
        arguments: {"gameId": gameId});
  }

  //  跳转页面
  static Future gotoH5Game(BuildContext context, String url, int direction,
      {String gameName}) {
    if (!LoginControl.isLogin()) {
      return AppUtil.gotoPageByName(context, LoginPage.pageName);
    }
    //ios 的flutter_webview 在ios13.2上播放声音会导致浮点出现bug,更改为plugin_webview实现
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

  //  跳转页面
  static Future gotoH5Web(BuildContext context, String url, {String title, bool noHttpParam = false}) {
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
    } catch(e) {
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

  static String gameTypeTransport(List<String> type, String replace, int length) {
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

  static Future<bool> checkPhonePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }

    PermissionStatus permission =
    await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    if (permission != PermissionStatus.granted) {
      num date = SpUtil.prefs.getInt(SpUtil.PERMISSION_PHONE_LAST_TIME);
      if (null != date && DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(date)).inDays < 2) {
        return false;
      }

      Map<PermissionGroup, PermissionStatus> permissions =
      await PermissionHandler().requestPermissions(
          [PermissionGroup.phone]);
      PermissionStatus status = permissions[PermissionGroup.phone];
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        SpUtil.prefs.setInt(SpUtil.PERMISSION_PHONE_LAST_TIME, DateTime.now().millisecondsSinceEpoch);
        return false;
      }
    } else {
      return true;
    }
  }
}
