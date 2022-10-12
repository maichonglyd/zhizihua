import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/inviewnotifier/inview_notifier_list.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RmbFragmentState state, Dispatch dispatch, ViewService viewService) {
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
                initialInViewIds: ['0'],
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
                  dispatch(RmbFragmentActionCreator.getIndexData());
                },
                builder: listAdapter.itemBuilder),
          ),
        );
}
