import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action, Page;
import 'package:flutter/material.dart';
import 'package:flutter_custom_bottom_tab_bar/eachtab.dart';
import 'package:flutter_custom_bottom_tab_bar/tabbar.dart';

import 'package:flutter_huoshu_app/common/util/common_tab_indicator.dart';
import 'package:flutter_huoshu_app/common/util/swiper_pagination.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/inviewnotifier/inview_notifier_list.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ZKFragmentState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter listAdapter = viewService.buildAdapter();

  return null == state.homeData
      ? Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        )
      : Container(
          child: NotificationListener(
            child: InViewNotifierList(
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                controller: state.scrollController,
                refreshController: state.refreshController,
                physics: BouncingScrollPhysics(),
                isInViewPortCondition: (double deltaTop, double deltaBottom,
                    double viewPortDimension) {
                  return deltaTop < (0.5 * viewPortDimension) &&
                      deltaBottom > (0.5 * viewPortDimension);
                },
                itemCount: listAdapter.itemCount,
                hasSmartRefresher: true,
                enablePullDown: true,
                enablePullUp: false,
                onRefresh: () {
                  dispatch(ZkFragmentActionCreator.getIndexData());
                },
                builder: listAdapter.itemBuilder),
          ),
        );
}
