import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/index/recruitment_bean.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:flutter_huoshu_app/widget/huo_title_text.dart';
import 'package:flutter_huoshu_app/widget/little_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RecruitmentOrderState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: huoTitle(getText(name: 'textHighReward')),
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
    body: null == state.recruitmentModel
        ? SizedBox()
        : Container(
            color: Color(0xFFFF4735),
            child: Stack(
              children: [
                _buildSingleScrollView(state, dispatch, viewService),
                _buildBottomButton(state, dispatch, viewService)
              ],
            ),
          ),
  );
}

Widget _buildSingleScrollView(
    RecruitmentOrderState state, Dispatch dispatch, ViewService viewService) {
  String ruleText = '';
  if (null != state.recruitmentModel.data.rule) {
    for(String text in state.recruitmentModel.data.rule) {
      ruleText += text + '\n';
    }
  }
  return SingleChildScrollView(
    child: Stack(
      children: [
        Image.asset(
          "images/pic_recruit_bg.png",
          width: double.infinity,
          height: 518,
          fit: BoxFit.fill,
        ),
        Column(
          children: [
            _buildContainerView(
                getText(name: 'textHowToMakeMoney'),
                EdgeInsets.only(top: 440, left: 15, right: 15),
                Text(
                  ruleText,
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor, fontSize: 14),
                )),
            _buildContainerView(
                getText(name: 'textRevenueRanking'),
                EdgeInsets.only(top: 17, bottom: 15, left: 15, right: 15),
                _buildRankListView(state, dispatch, viewService))
          ],
        ),
      ],
    ),
  );
}

Widget _buildContainerView(
  String title,
  EdgeInsetsGeometry margin,
  Widget contentWidget,
) {
  return Container(
    margin: margin,
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.only(left: 15, right: 15, top: 44, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: contentWidget,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 220,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/pic_recruit_title_bg.png"),
                  fit: BoxFit.fill),
            ),
            child: Text(
              title ?? '',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRankListView(
    RecruitmentOrderState state, Dispatch dispatch, ViewService viewService) {
  return null != state.recruitmentModel.data.rankList &&
          state.recruitmentModel.data.rankList.length > 0
      ? ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: state.recruitmentModel.data.rankList
              .asMap()
              .keys
              .map((index) => _buildRankItemView(
                  index, state.recruitmentModel.data.rankList[index]))
              .toList(),
        )
      : SizedBox();
}

Widget _buildRankItemView(int index, RecruitmentRankBean bean) {
  return Container(
    height: 47,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 97,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 7),
            child: buildRankView(index, textColor: AppTheme.colors.themeColor),
          ),
        ),
        Expanded(
          flex: 136,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 29,
                height: 29,
                margin: EdgeInsets.only(right: 4),
                child: ClipOval(
                  child: HuoNetImage(
                    imageUrl: bean.icon ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                bean.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    color: AppTheme.colors.textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 67,
          child: Text(
            "+${getText(name: 'textHavePrice', args: [bean.money ?? 0])}",
            style: TextStyle(
                color: Color(0xFFFF0000),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}

Align _buildBottomButton(
    RecruitmentOrderState state, Dispatch dispatch, ViewService viewService) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: GestureDetector(
      onTap: () {
        dispatch(RecruitmentOrderActionCreator.showServiceDialog());
      },
      child: Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 34),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/pic_recruit_button.png"),
                fit: BoxFit.fill)),
        child: Text(
          getText(name: 'textJoinTheCityPartner'),
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    ),
  );
}
