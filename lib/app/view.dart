import 'package:event_bus/event_bus.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter/services.dart';
import 'package:flutter_huoshu_app/api/loading_dialog/page.dart';
import 'package:flutter_huoshu_app/app/action.dart';
import 'package:flutter_huoshu_app/app/page.dart';
import 'package:flutter_huoshu_app/app/state.dart';
import 'package:flutter_huoshu_app/common/base/app_navigator_observer.dart';
import 'package:flutter_huoshu_app/common/device_info/device_Info.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/huo_log.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/component/game/game_reserve/page.dart';
import 'package:flutter_huoshu_app/component/video/event_bus_manager.dart';
import 'package:flutter_huoshu_app/event/event.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/global_store/store.dart';
import 'package:flutter_huoshu_app/page/activity/activity_details/page.dart';
import 'package:flutter_huoshu_app/page/activity/activitynews/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_buy_game_list/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_details_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_notice_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_search/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_sell_edit_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_sell_select_game/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_shop_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_buy_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_playing_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/my_sell_list_page/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_buy_edit/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_buy_record/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_details/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_order_details/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_select_game/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_sell_edit/page.dart';
import 'package:flutter_huoshu_app/page/deal/prop_deal/prop_deal_sell_record/page.dart';
import 'package:flutter_huoshu_app/page/deal_page/page.dart';
import 'package:flutter_huoshu_app/page/download/download_manage/page.dart';
import 'package:flutter_huoshu_app/page/game/game_classify/page.dart';
import 'package:flutter_huoshu_app/page/game/game_comment/page.dart';
import 'package:flutter_huoshu_app/page/game/game_comment_response/page.dart';
import 'package:flutter_huoshu_app/page/game/game_coupon/page.dart';
import 'package:flutter_huoshu_app/page/game/game_kaifu/page.dart';
import 'package:flutter_huoshu_app/page/game/game_new_notice/page.dart';
import 'package:flutter_huoshu_app/page/game/game_new_tour_list/page.dart';
import 'package:flutter_huoshu_app/page/game/game_pic_gallery/page.dart';
import 'package:flutter_huoshu_app/page/game/game_player_recharge_list/page.dart';
import 'package:flutter_huoshu_app/page/game/game_rank/page.dart';
import 'package:flutter_huoshu_app/page/game/game_rebate/page.dart';
import 'package:flutter_huoshu_app/page/game/game_search/page.dart';
import 'package:flutter_huoshu_app/page/game/game_special/page.dart';
import 'package:flutter_huoshu_app/page/game/game_strategy_money/page.dart';
import 'package:flutter_huoshu_app/page/game_details_page/page.dart';
import 'package:flutter_huoshu_app/page/gift/game_gift/page.dart';
import 'package:flutter_huoshu_app/page/gift/gift_details/page.dart';
import 'package:flutter_huoshu_app/page/gift/my_gift/page.dart';
import 'package:flutter_huoshu_app/page/home_page/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/lottery_activity/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/lottery_reward/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/lottery/reward_detail/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/recruitment_order/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/stop_game/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/turn_game/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/turn_game_detail/page.dart';
import 'package:flutter_huoshu_app/page/index_top_tab/turn/turn_gift/page.dart';
import 'package:flutter_huoshu_app/page/mine/Login/register_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_commit/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_recycle/account_recycle_tip/page.dart';
import 'package:flutter_huoshu_app/page/mine/account_security/page.dart';
import 'package:flutter_huoshu_app/page/mine/bind_mobile/page.dart';
import 'package:flutter_huoshu_app/page/mine/coupon_center/page.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/exchange_record_details/page.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/game_currency_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/game_currency/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/integral_shop/page.dart';
import 'package:flutter_huoshu_app/page/mine/intergral_shop_details/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_friend_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/invite_rule/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/find_password/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/page/mine/login/update_password/page.dart';
import 'package:flutter_huoshu_app/page/mine/lottery/page.dart';
import 'package:flutter_huoshu_app/page/mine/message/message_list/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_account_management/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_coupon/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_feedback/page.dart';
import 'package:flutter_huoshu_app/page/mine/mine_setting/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_recharge/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_recharge_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_select_channel/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/game_coin_select_game/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/my_wallet/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_expense_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_income_record/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/ptz_recharge/page.dart';
import 'package:flutter_huoshu_app/page/mine/recharge/recharge_info/page.dart';
import 'package:flutter_huoshu_app/page/mine/service/page.dart';
import 'package:flutter_huoshu_app/page/mine/task_center/page.dart';
import 'package:flutter_huoshu_app/page/mine/update_mobile/page.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_apply/page.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_commit/page.dart';
import 'package:flutter_huoshu_app/page/rebate/rebate_list/page.dart';
import 'package:flutter_huoshu_app/page/update/page.dart';
import 'package:flutter_huoshu_app/page/video/video_play/page.dart';
import 'package:flutter_huoshu_app/page/vip/member_center/page.dart';
import 'package:flutter_huoshu_app/page/vip/open_record/page.dart';
import 'package:flutter_huoshu_app/page/vip/open_vip/page.dart';
import 'package:flutter_huoshu_app/page/vip/pay_success/page.dart';
import 'package:flutter_huoshu_app/page/vip/vip_center/page.dart';
import 'package:flutter_huoshu_app/page/web/page.dart';
import 'package:flutter_huoshu_app/page/web_plugin/page.dart';
import 'package:flutter_huoshu_app/widget/fallback_cpu_ios_localization.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:oktoast/oktoast.dart';
import 'package:orientation/orientation.dart';

import '../app_config.dart';

Widget buildView(AppState state, Dispatch dispatch, ViewService viewService) {
  //创建路由
  final AbstractRoutes routes = PageRoutes(
    pages: <String, Page<Object, dynamic>>{
      HomePage.pageName: HomePage(),
      KaifuGamePage.pageName: KaifuGamePage(),
      LoginPage.pageName: LoginPage(),
      GameDetailsPage.pageName: GameDetailsPage(),
      AccountManagePage.pageName: AccountManagePage(),
      SettingPage.pageName: SettingPage(),
      FeedbackPage.pageName: FeedbackPage(),
      MyGiftPage.pageName: MyGiftPage(),
      GiftDetailsPage.pageName: GiftDetailsPage(),
      IntegralShopPage.pageName: IntegralShopPage(),
      IntegralRecordPage.pageName: IntegralRecordPage(),
      InvitePage.pageName: InvitePage(),
      InviteListPage.pageName: InviteListPage(),
      RebateApplyPage.pageName: RebateApplyPage(),
      RebateCommitPage.pageName: RebateCommitPage(),
      RebateRecordListPage.pageName: RebateRecordListPage(),
      MyWalletPage.pageName: MyWalletPage(),
      PtbExpensePage.pageName: PtbExpensePage(),
      PtzIncomePage.pageName: PtzIncomePage(),
      ServicePage.pageName: ServicePage(),
      SecurityPage.pageName: SecurityPage(),
      RegisterPage.pageName: RegisterPage(),
      FindPasswordPage.pageName: FindPasswordPage(),
      UpdatePasswordPage.pageName: UpdatePasswordPage(),
      DealDetailsPage.pageName: DealDetailsPage(),
      DealSellEditPage.pageName: DealSellEditPage(),
      MySellListPage.pageName: MySellListPage(),
      MyBuyListPage.pageName: MyBuyListPage(),
      DealSellSelectGamePage.pageName: DealSellSelectGamePage(),
      PlayingListPage.pageName: PlayingListPage(),
      DealShopListPage.pageName: DealShopListPage(),
      DealNoticePage.pageName: DealNoticePage(),
      MessageListPage.pageName: MessageListPage(),
      GameSearchPage.pageName: GameSearchPage(),
      GameClassifyPage.pageName: GameClassifyPage(),
      GameRankPage.pageName: GameRankPage(),
      BindMobilePage.pageName: BindMobilePage(),
      UpdateMobilePage.pageName: UpdateMobilePage(),
      GameSpecialPagePage.pageName: GameSpecialPagePage(),
      GameCommitCommentPage.pageName: GameCommitCommentPage(),
      WebPage.pageName: WebPage(),
      WebPluginPage.pageName: WebPluginPage(),
      IntegralShopDetailsPage.namePage: IntegralShopDetailsPage(),
      DealBuyGameListPage.pageName: DealBuyGameListPage(),
      PtzRechargePage.pageName: PtzRechargePage(),
      DealSearchPage.pageName: DealSearchPage(),
      GalleryPage.pageName: GalleryPage(),
      DownLoadManagePage.pageName: DownLoadManagePage(),
      UpdatePage.pageName: UpdatePage(),
      TaskCenterPage.pageName: TaskCenterPage(),
      LoadingDialogPage.pageName: LoadingDialogPage(),
      AccountRecyclePage.pageName: AccountRecyclePage(),
      AccountRecycleRecordPage.pageName: AccountRecycleRecordPage(),
      AccountRecycleCommitPage.pageName: AccountRecycleCommitPage(),
      PropDealSelectGamePage.pageName: PropDealSelectGamePage(),
      PropDealDetailsPage.pageName: PropDealDetailsPage(),
      PropDealBuyPage.pageName: PropDealBuyPage(),
      PropDealSellEditPage.pageName: PropDealSellEditPage(),
      PropDealBuyRecordPage.pageName: PropDealBuyRecordPage(),
      PropDealSellRecordPage.pageName: PropDealSellRecordPage(),
      AccountRecycleTipPage.pageName: AccountRecycleTipPage(),
      PropDealOrderDetailsPage.pageName: PropDealOrderDetailsPage(),
      ExchangeRecordPage.pageName: ExchangeRecordPage(),
      ActivityDetailsPage.pageName: ActivityDetailsPage(),
      ExchangeRecordDetailsPage.pageName: ExchangeRecordDetailsPage(),
      ActivityNewsPage.pageName: ActivityNewsPage(),
      LotteryPage.pageName: LotteryPage(),
      VideoPlayPage.pageName: VideoPlayPage(),
      InviteRulePage.pageName: InviteRulePage(),
      GameReservePage.pageName: GameReservePage(),
      OpenVipPage.pageName: OpenVipPage(),
      VipOpenPage.pageName: VipOpenPage(),
      MemberCenterPage.pageName: MemberCenterPage(),
      PaySuccessPage.pageName: PaySuccessPage(),
      OpenRecordPage.pageName: OpenRecordPage(),
      MineCouponPage.pageName: MineCouponPage(),
      RechargeInfoPage.pageName: RechargeInfoPage(),
      GameCoinRechargePage.pageName: GameCoinRechargePage(),
      GameCoinRechargeRecordPage.pageName: GameCoinRechargeRecordPage(),
      GameCoinSelectChannelPage.pageName: GameCoinSelectChannelPage(),
      GameCoinSelectGamePage.pageName: GameCoinSelectGamePage(),
      GameCurrencyListPage.pageName: GameCurrencyListPage(),
      MineCurrRecordPage.pageName: MineCurrRecordPage(),
      GameNewTourListPage.pageName: GameNewTourListPage(),
      GameStrategyMoneyPage.pageName: GameStrategyMoneyPage(),
      GamePlayerRechargeListPage.pageName: GamePlayerRechargeListPage(),
      GameNewNoticePage.pageName: GameNewNoticePage(),
      CouponCenterPage.pageName: CouponCenterPage(),
      DealPage.pageName: DealPage(),
      RecruitmentOrderPage.pageName: RecruitmentOrderPage(),
      GameRebatePage.pageName: GameRebatePage(),
      GameCouponPage.pageName: GameCouponPage(),
      GameGiftPage.pageName: GameGiftPage(),
      GameCommentResponsePage.pageName: GameCommentResponsePage(),
      TurnGamePage.pageName: TurnGamePage(),
      TurnGiftPage.pageName: TurnGiftPage(),
      StopGamePage.pageName: StopGamePage(),
      TurnGameDetailPage.pageName: TurnGameDetailPage(),
      LotteryActivityPage.pageName: LotteryActivityPage(),
      LotteryRewardPage.pageName: LotteryRewardPage(),
      RewardDetailPage.pageName: RewardDetailPage(),
    },
    visitor: (String path, Page<Object, dynamic> page) {
      /// XXX
      initPage(page);
    },
  );

  //statusBar设置为透明，去除半透明遮罩
  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //将style设置到app
  SystemChrome.setSystemUIOverlayStyle(_style);

  //设置app强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //强制竖屏
  OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);

  //再按一次退出
  return OKToast(
    child: MaterialApp(
        //隐藏右上角debug标志
        debugShowCheckedModeBanner: false,
        //国际化中，不能直接使用title，因为此时国际化还没有配置完成
        onGenerateTitle: (context) {
          return AppConfig.title;
        },
        // 设置APP的语言，null为跟随系统语言
        locale: LocaleManager.getLocaleType(),
        theme: ThemeData(
            primaryColor: Colors.white, backgroundColor: Colors.white),
        home: routes.buildPage(HomePage.pageName, null),
        onGenerateRoute: (RouteSettings settings) {
          //这里要设置路由信息,不然路由名称就为空了
          return MaterialPageRoute(
              settings: settings,
              builder: (BuildContext context) {
                return routes.buildPage(settings.name, settings.arguments);
              });
        },
        //设置字体大小不跟随系统设置改变
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget,
          );
        },
        //国际化 语言支持
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          const FallbackCupertinoLocalisationsDelegate(),
        ],
        supportedLocales: S.delegate.supportedLocales,
        //系统语言改变回调
       localeResolutionCallback: (deviceLocale, supportLocale) {
          HuoLog.d("localeResolutionCallback: deviceLocale = ${deviceLocale.languageCode}-${deviceLocale.countryCode}");
          LocaleManager.saveNowLanguage(deviceLocale);
          // 先获取APP的语言代码，若为null则是用户选择跟随系统语言，可以直接调用初始化接口
          // 但用户设置语言的话，该回调会调用多次，所以在LifeRecycler.init调用初始化
          if (null == LocaleManager.getLocaleType()) {
            dispatch(AppActionCreator.onInitUserAgent());
          }
          return;
       },
        navigatorObservers: [AppNavigatorObserver()]),
    position: ToastPosition.bottom,
  );
}
