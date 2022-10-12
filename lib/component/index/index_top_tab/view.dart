import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/common/util/swiper_pagination.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/common/style/color/huo_colors.dart';
import 'package:flutter_huoshu_app/common/style/huo_dimens.dart';
import 'package:flutter_huoshu_app/model/index/index_top_tab_bean.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/split_line.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(IndexTopTabComponentState state, Dispatch dispatch,
    ViewService viewService) {
  return null == state.list || 0 == state.list.length
      ? SizedBox()
      : Container(
          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: 5 >= state.list.length
              ? _buildRowView(state, dispatch, viewService, state.list)
              : _buildSwiperView(state, dispatch, viewService),
        );
}

Widget _buildRowView(IndexTopTabComponentState state, Dispatch dispatch,
    ViewService viewService, List<IndexTopTabBean> itemList) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: itemList
        .map((value) => _buildItemView(state, dispatch, viewService, value))
        .toList(),
  );
}

Widget _buildSwiperView(IndexTopTabComponentState state, Dispatch dispatch,
    ViewService viewService) {
  int itemLength = 5;
  int itemCount = state.list.length ~/ itemLength +
      (state.list.length % itemLength > 0 ? 1 : 0);
  return Container(
    height: 70,
    child: Swiper(
      itemCount: itemCount,
      loop: false,
      pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 0),
          builder: SliverSwiperPaginationBuilder(
            color: AppTheme.colors.lineColor,
            activeColor: AppTheme.colors.themeColor,
            widthSize: 15,
            heightSize: 3,
          )),
      itemBuilder: (BuildContext context, int index) {
        List<IndexTopTabBean> itemList = [];
        int start = index * itemLength;
        int end = itemCount != index + 1
            ? (index + 1) * itemLength
            : state.list.length;
        itemList.addAll(state.list.sublist(start, end));
        return _buildRowView(state, dispatch, viewService, itemList);
      },
    ),
  );
}

Widget _buildItemView(IndexTopTabComponentState state, Dispatch dispatch,
    ViewService viewService, IndexTopTabBean bean) {
  return GestureDetector(
    onTap: () {
      switch (bean.topicKey) {
        case 'freegame': //0元畅玩
          dispatch(IndexTopTabComponentActionCreator.gotoSpecialGame(bean));
          break;
        case 'couponcenter': //领券中心
          dispatch(IndexTopTabComponentActionCreator.gotoCouponCenter());
          break;
        case 'vipcenter': //省钱卡
          dispatch(IndexTopTabComponentActionCreator.gotoVipRebate());
          break;
        case 'taskcenter': //任务赚金
          dispatch(IndexTopTabComponentActionCreator.gotoTaskCenter());
          break;
        case 'switchgame': //转游福利
          dispatch(IndexTopTabComponentActionCreator.gotoTurnGame());
          break;
        case 'accountdeal': //交易
          dispatch(IndexTopTabComponentActionCreator.gotoDealPage());
          break;
        case 'lottery': //幸运大抽奖
          dispatch(IndexTopTabComponentActionCreator.gotoLotteryActivity());
          break;
        case 'recruitment': //招募令
          dispatch(IndexTopTabComponentActionCreator.gotoRecruitOrder());
          break;
        case 'headlinenew': //王者攻略
          dispatch(IndexTopTabComponentActionCreator.gotoActivityNews());
          break;
        case 'serverschedule': //开服表
          dispatch(IndexTopTabComponentActionCreator.gotoGameReserve());
          break;
      }
    },
    child: Column(
      children: <Widget>[
        Container(
            height: 34,
            width: 34,
            child: ClipRRect(
              child: HuoNetImage(
                imageUrl:
                bean.topicIcon ?? 0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            )),
        Container(
          width: 60,
          margin: EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          child: Text(
            bean.topicName,
            style: TextStyle(
                color: AppTheme.colors.textSubColor,
                fontSize: HuoTextSizes.index_tab),
          ),
        ),
      ],
    ),
  );
}
