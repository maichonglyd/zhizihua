import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/page/home_page/action.dart';
import 'package:oktoast/oktoast.dart';

import '../../app_config.dart';

///底部功能按钮第三个加号按钮点击弹窗
class HomePageAddDialog extends StatefulWidget {
  Function() close;
  Dispatch dispatch;
  HomePageAddDialog(this.dispatch, this.close);

  @override
  State<StatefulWidget> createState() {
    return DialogContentState(this.close);
  }
}

class DialogContentState extends State<HomePageAddDialog> {
  Function() close;
//  Dispatch dispatch;
  DialogContentState(this.close);

  bool selectAgreement = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, //透明类型,
      child: Container(
//      width: double.maxFinite,
//      color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Container(),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _createItem(
                      widget.dispatch, "images/ic_hs_ks_money.png", getText(name: 'textInviteMoney'), 0),
                ),
                Expanded(
                  flex: 1,
                  child: _createItem(
                      widget.dispatch, "images/ic_hs_ks_renwu.png", getText(name: 'textTaskCenter'), 1),
                ),
                Expanded(
                  flex: 1,
                  child: _createItem(
                      widget.dispatch, "images/ic_hs_ks_renwu.png", getText(name: 'textAllGame'), 6),
                ),
                Expanded(
                  flex: 1,
                  child: _createItem(widget.dispatch,
                      "images/ic_hs_ks_recycling.png", getText(name: 'textRecycle'), 2),
                ),
              ],
            ),
            Container(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _createItem(
                        widget.dispatch, "images/ic_hs_ks_kaifu.png", getText(name: 'textService'), 3),
                  ),
                  Expanded(
                    flex: 1,
                    child: _createItem(widget.dispatch,
                        "images/ic_hs_ks_market.png", getText(name: 'textShop'), 5),
                  ),
                  AppConfig.hasTurntable
                      ? Expanded(
                          flex: 1,
                          child: _createItem(widget.dispatch,
                              "images/ic_hs_ks_choujiang.png", getText(name: 'textLottery'), 4),
                        )
                      : Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(bottom: 70, top: 40),
                child: Image.asset(
                  "images/icon_huosdk_rukou_off.png",
                  width: 30,
                  height: 30,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

Widget _createItem(Dispatch dispatch, String icon, String title, int id) {
  return GestureDetector(
    child: Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            icon,
            width: 47,
            height: 47,
          ),
          Container(
            child: Text(
              title,
              style:
                  TextStyle(fontSize: 12, color: AppTheme.colors.textSubColor),
            ),
            margin: EdgeInsets.only(top: 3, bottom: 3),
          )
        ],
      ),
    ),
    onTap: () {
      switch (id) {
        case 0:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoInvite());
          break;
        case 1:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoTaskCenter());
          break;
        case 2:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoRecycle());
          break;
        case 3:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoKaifu());
          break;
        case 4:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoLottery());
          break;
        case 5:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoShop());
          break;
        case 6:
          dispatch(HomeActionCreator.showTab());
          dispatch(HomeActionCreator.gotoGameClass());
          break;
        default:
          break;
      }
    },
  );
}
