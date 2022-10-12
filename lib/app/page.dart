import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action,Page;
import 'package:flutter_huoshu_app/app/state.dart';
import 'package:flutter_huoshu_app/global_store/state.dart';
import 'package:flutter_huoshu_app/global_store/store.dart';
import 'package:flutter_huoshu_app/app/view.dart';
import 'package:flutter_huoshu_app/app/effect.dart';


class AppPage extends Page<AppState, Map<String, dynamic>> {
  static final String pageName = "AppPage";
  AppPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          view: buildView,
        );
}

Widget createApp() {
  Page page = AppPage();
  initPage(page);
  return page.buildPage(null);
}

void initPage(Page<Object, dynamic> page) {
  if (page.isTypeof<GlobalBaseState>()) {
    page.connectExtraStore<GlobalState>(GlobalStore.store, globalConn);
  }
  page.enhancer.append(
    viewMiddleware: <ViewMiddleware<dynamic>>[safetyView<dynamic>()],
    adapterMiddleware: <AdapterMiddleware<dynamic>>[safetyAdapter<dynamic>()],
    effectMiddleware: [],
//    middleware: <Middleware<dynamic>>[logMiddleware<dynamic>()],
  );
}
