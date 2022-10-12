import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/coupon/coupon_center_list.dart';
import 'package:flutter_huoshu_app/page/mine/login/login_page/page.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';
import 'package:oktoast/oktoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CouponCenterState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      titleSpacing: 0,
      elevation: 0,
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
      title: _buildSearchView(state, dispatch, viewService),
    ),
    body: Stack(
      children: [
        _buildHeaderImageView(state, dispatch, viewService),
        _buildContentListView(state, dispatch, viewService),
      ],
    ),
  );
}

Widget _buildSearchView(
    CouponCenterState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: 290,
    height: 35,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Color(0xFFF0F2F5),
      borderRadius: BorderRadius.all(Radius.circular(18)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, right: 4),
          child: Image.asset(
            "images/tobar_ic_search_gray.png",
            height: 24,
            width: 24,
          ),
        ),
        Expanded(
          child: TextField(
            controller: state.contentController,
            decoration: InputDecoration(
              hintText: getText(name: 'hintPleaseInputCouponGameName'),
              hintStyle:
                  TextStyle(color: AppTheme.colors.hintTextColor, fontSize: 14),
              contentPadding: EdgeInsets.only(left: 0, bottom: 13),
              counterText: "",
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
            ),
            style: TextStyle(color: AppTheme.colors.textColor, fontSize: 14),
            textInputAction: TextInputAction.search,
            onEditingComplete: () {
              dispatch(CouponCenterActionCreator.searchCoupon());
            },
            onChanged: (text) {
              dispatch(CouponCenterActionCreator.onAction());
            },
          ),
        ),
        if (_checkShowDeleteView(state, dispatch, viewService))
          _buildDeleteView(state, dispatch, viewService),
        GestureDetector(
          onTap: () {
            dispatch(CouponCenterActionCreator.searchCoupon());
          },
          child: Container(
            width: 50,
            height: 28,
            margin: EdgeInsets.only(left: 8, right: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xFFFC5A41),
                borderRadius: BorderRadius.circular(18)),
            child: Text(
              getText(name: 'textSearch'),
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        )
      ],
    ),
  );
}

bool _checkShowDeleteView(
    CouponCenterState state, Dispatch dispatch, ViewService viewService) {
  return null != state.contentController &&
      null != state.contentController.text &&
      state.contentController.text.isNotEmpty;
}

Widget _buildDeleteView(
    CouponCenterState state, Dispatch dispatch, ViewService viewService) {
  return GestureDetector(
    onTap: () {
      state.contentController.text = '';
      dispatch(CouponCenterActionCreator.getData(1));
    },
    child: Container(
      width: 15,
      height: 15,
      child: Image.asset(
        "images/shenqingfanli_tijiaoshenqing.png",
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget _buildHeaderImageView(
    CouponCenterState state, Dispatch dispatch, ViewService viewService) {
  return Image.asset(
    "images/pic_coupon_center.png",
    width: double.infinity,
    height: 140,
    fit: BoxFit.fill,
  );
}

Widget _buildContentListView(
    CouponCenterState state, Dispatch dispatch, ViewService viewService) {
  Widget contentView;
  if (null != state.gameCouponList && state.gameCouponList.length > 0) {
    contentView = Column(
      children: state.gameCouponList
          .map((value) => _buildItemView(state, dispatch, viewService, value))
          .toList(),
    );
  } else {
    contentView = Container(
      padding: EdgeInsets.only(top: 65),
      child: Text(
        getText(name: 'textDataLoading'),
        style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 15),
      ),
    );
  }

  return Container(
    width: double.infinity,
    height: double.infinity,
    child: state.refreshHelper.getEasyRefresh(
      ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 127),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: Colors.white,
            ),
            child: contentView,
          )
        ],
      ),
      emptyWidget: Container(
        margin: EdgeInsets.only(top: 127),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          color: Colors.white,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 65),
          child: Text(
            getText(name: 'textNoCouponToGet'),
            style: TextStyle(color: AppTheme.colors.textSubColor, fontSize: 15),
          ),
        ),
      ),
      onRefresh: () {
        dispatch(CouponCenterActionCreator.getData(1));
      },
      loadMore: (page) {
        dispatch(CouponCenterActionCreator.getData(page));
      },
      controller: state.refreshHelperController,
    ),
  );
}

Widget _buildItemView(CouponCenterState state, Dispatch dispatch,
    ViewService viewService, CouponCenter gameCoupon) {
  return Container(
    margin: EdgeInsets.only(top: 12),
    child: Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            AppUtil.gotoGameDetailById(viewService.context, gameCoupon.gameId);
          },
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    child: HuoNetImage(
                      imageUrl: gameCoupon.icon ?? '',
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            gameCoupon.gameName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppTheme.colors.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          getText(name: 'textSizeAndPlayCnt', args: [gameCoupon.size ?? '', gameCoupon.userCnt ?? '']),
                          style: TextStyle(
                            color: AppTheme.colors.textSubColor2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  getText(name: 'textToGameDetail'),
                  style: TextStyle(
                      color: AppTheme.colors.textSubColor, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 129,
          margin: EdgeInsets.only(left: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildCouponView(
                  state, dispatch, viewService, gameCoupon.cvCoupon[index]);
            },
            itemCount: gameCoupon.cvCoupon.length,
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: AppTheme.colors.lineColor,
        )
      ],
    ),
  );
}

Widget _buildCouponView(CouponCenterState state, Dispatch dispatch,
    ViewService viewService, CvCouponBean coupon) {
  int hasGet = 2;
  return Container(
    width: 260,
    height: 95,
    margin: EdgeInsets.only(top: 15, bottom: 19, left: 5, right: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          offset: Offset(0, 1),
          blurRadius: 5,
        )
      ],
    ),
    child: Row(
      children: [
        Expanded(
          flex: 145,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 26,
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: getText(name: 'textCurrencySymbol'),
                      style: TextStyle(
                        color: Color(0xFFFC5A41),
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: coupon.money.toString() ?? '',
                      style: TextStyle(
                        color: Color(0xFFFC5A41),
                        fontSize: 26,
                      ),
                    ),
                  ])),
                ),
                _buildProgressView(state, dispatch, viewService, coupon.remain / coupon.total),
                _buildProgressText(coupon.expireDate ?? ''),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 115,
          child: GestureDetector(
              onTap: () {
                if (!LoginControl.isLogin()) {
                  AppUtil.gotoPageByName(
                      viewService.context, LoginPage.pageName);
                  return;
                }
                if (hasGet != coupon.isGet) {
                  dispatch(CouponCenterActionCreator.obtainCoupon(coupon.id));
                } else {
                  showToast(getText(name: 'textToGameRechargeUse'));
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/bg_coupon_center_right.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      coupon.conditionDes ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!LoginControl.isLogin()) {
                          AppUtil.gotoPageByName(
                              viewService.context, LoginPage.pageName);
                          return;
                        }
                        if (hasGet != coupon.isGet) {
                          dispatch(CouponCenterActionCreator.obtainCoupon(
                              coupon.id));
                        } else {
                          showToast(getText(name: 'textHasGotCoupon'));
                        }
                      },
                      child: Container(
                        width: 85,
                        height: 25,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          color: hasGet != coupon.isGet
                              ? Colors.white
                              : Color(0xFFFC5A41),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: Text(
                          hasGet != coupon.isGet
                              ? getText(name: 'textObtainCoupon')
                              : getText(name: 'textUseNow'),
                          style: TextStyle(
                              color: hasGet != coupon.isGet
                                  ? Color(0xFFFC5A41)
                                  : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Text(
                      coupon.expire ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ],
                ),
              )),
        )
      ],
    ),
  );
}

Widget _buildProgressView(CouponCenterState state, Dispatch dispatch,
    ViewService viewService, double progress) {
  if (progress > 0 && progress < 0.01) {
    progress = 0.01;
  }
  double viewWidth = 90;
  return Container(
    width: viewWidth,
    height: 14,
    child: Stack(
      children: [
        Container(
          width: viewWidth,
          height: double.infinity,
          margin: EdgeInsets.only(top: 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Color(0xFFFFC9C1),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFC5A41)),
            ),
          ),
        ),
        Container(
          width: viewWidth,
          alignment: Alignment.center,
          child: Text(
            getText(name: 'textRemainPercent', args: [(progress * 100).toInt()]),
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

Widget _buildProgressText(String text) {
  return Container(
    child: Text(
      text,
      style: TextStyle(color: AppTheme.colors.textSubColor2, fontSize: 10),
    ),
  );
}
