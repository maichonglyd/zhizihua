import 'dart:convert';
import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_huoshu_app/api/common_dio.dart';
import 'package:flutter_huoshu_app/api/deal_service.dart';
import 'package:flutter_huoshu_app/api/file_service.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/login_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart';
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/model/deal/deal_index_data.dart';
import 'package:flutter_huoshu_app/model/user/upload_info.dart';
import 'package:flutter_huoshu_app/page/deal/account_deal/deal_buy_game_list/page.dart';
import 'package:flutter_huoshu_app/utils/image_util.dart';
import 'package:flutter_huoshu_app/widget/dialog/DealSendSmsDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/SelectAccountDialog.dart';
import 'package:flutter_huoshu_app/widget/dialog/TipDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'action.dart';
import 'state.dart';

Effect<DealSellEditState> buildEffect() {
  return combineEffects(<Object, Effect<DealSellEditState>>{
    DealSellEditAction.selectPic: _selectPic,
    DealSellEditAction.showDialog: _showDialog,
    DealSellEditAction.gotoSelectGame: gotoSelectGame,
    DealSellEditAction.selectAccount: selectAccount,
    DealSellEditAction.sell: sell,
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
  });
}

void _initState(Action action, Context<DealSellEditState> ctx) {
  ctx.state.priceController.addListener(() {
    String price = ctx.state.priceController.text;
    if (price.isNotEmpty) {
      ctx.dispatch(DealSellEditActionCreator.updateSellPrice(price));
    }
  });
  if (ctx.state.goodsId != null) {
    DealService.getDealDetails(ctx.state.goodsId).then((data) {
      if (data.code == 200) {
        //??????text???????????????????????????reducer???????????????action,?????????effect?????????
        ctx.state.priceController.text = data.data.price;
        ctx.state.titleController.text = data.data.title;
        ctx.state.contentController.text = data.data.description;
        ctx.dispatch(DealSellEditActionCreator.echoDealDetails(data.data));
      }
    });
  }
  ctx.state.blankToolBarModel.outSideCallback = () {
    ctx.dispatch(DealSellEditActionCreator.onAction());
  };
}

void _dispose(Action action, Context<DealSellEditState> ctx) {
  ctx.state.blankToolBarModel.removeFocusListeners();
}

void sell(Action action, Context<DealSellEditState> ctx) {
  String price = ctx.state.priceController.text;
  String title = ctx.state.titleController.text;
  String description = ctx.state.contentController.text;

  if (ctx.state.playedGame == null) {
    showToast(getText(name: 'toastSelectSellGame'));
    return;
  }
  if (ctx.state.selectAccounts == null) {
    showToast(getText(name: 'toastSelectSellAccount'));
    return;
  }
  if (ctx.state.accountServer == null) {
    showToast(getText(name: 'toastSelectSellService'));
    return;
  }

  if (title.isEmpty || title.length < 6 || title.length > 12) {
    showToast(getText(name: 'toastSelectSellTitleNotNull'));
    return;
  }

  // iOS??????????????????????????????????????????????????????????????????????????????????????????????????????????????????
  if (!Platform.isAndroid) {
    bool titleIsOk = true;
    String errorStr = '';
    var titleFormatter = RegExp("[\\u4e00-\\u9fa5]|[\\w]|[a-zA-Z]");
    for (int i = 0; i < title.length; i++) {
      if (!titleFormatter.hasMatch(title[i])) {
        titleIsOk = false;
        errorStr = title[i];
        break;
      }
    }
    if (!titleIsOk) {
      String toastStr = ' ' == errorStr ? getText(name: 'lastSpace') : '"$errorStr"';
      showToast(getText(name: 'toastTitleIsNotStandard', args: [toastStr]));
      return;
    }
  }

  if (price.isEmpty) {
    showToast(getText(name: 'toastInputPrice'));
    return;
  }
  if (num.parse(price) < ctx.state.minPrice) {
    showToast(getText(name: 'toastNotLowPrice', args: [ctx.state.minPrice]));
    return;
  }

  if (description.isEmpty) {
    showToast(getText(name: 'toastInputDes'));
    return;
  }
  if (ctx.state.images.length <= 0) {
    showToast(getText(name: 'toastUploadImage'));
    return;
  }

  //????????????????????????
  if (LoginControl.getUserInfo() == null ||
      LoginControl.getUserInfo().data.mobile == null ||
      LoginControl.getUserInfo().data.mobile.isEmpty) {
    //???????????????????????????????????????
    showToast(getText(name: 'toastNoBondPhone'));
    return;
  }

  //?????? ????????????
  showDialog<Null>(
    context: ctx.context, //BuildContext??????
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, state) {
        return DealSendSmsDialog((code) {
          print("ok");
          Navigator.of(context).pop();
          submitData(ctx, code);
        }, () {
          //????????????
          DealService.sendSellSms().then((data) {});
        }, LoginControl.getUserInfo().data.mobile);
      });
    },
  );
}

void submitData(Context<DealSellEditState> ctx, String code) {
  //??????????????????
  List<String> imageUrls = List();
  //????????????
  FileService.uploadImageFiles(ctx.state.images).then((data) {
    print("======================????????????:");
    print(data);
    print("======================????????????:");
    for (ImageUploadInfo uploadInfo in data) {
      imageUrls.add(uploadInfo.data.url);
    }
    if (ctx.state.goodsId == null) {
      //??????????????????
      DealService.sell(
              code,
              ctx.state.accountServer.mgMemId,
              ctx.state.playedGame.gameId,
              ctx.state.titleController.text,
              ctx.state.priceController.text,
              json.encode(imageUrls),
              ctx.state.contentController.text)
          .then((data) {
        if (data.code == CommonDio.SUCCESS_CODE) {
          showToast(getText(name: 'toastSubmitSuccessful'));
          Navigator.pop(ctx.context);
          ctx.dispatch(DealSellEditActionCreator.onEditOK());
        }

//      if()
      });
    } else {
      //??????????????????
      DealService.edit(
        code,
        ctx.state.accountServer.roleId,
        ctx.state.playedGame.gameId,
        ctx.state.titleController.text,
        ctx.state.priceController.text,
        json.encode(imageUrls),
        ctx.state.contentController.text,
        ctx.state.accountServer.serverId,
        ctx.state.accountServer.serverName,
        ctx.state.goodsId.toString(),
        ctx.state.accountServer.mgMemId,
      ).then((data) {
        if (data.code == CommonDio.SUCCESS_CODE) {
          showToast(getText(name: 'textModifySuccessful'));
          Navigator.pop(ctx.context);
          ctx.broadcast(DealSellEditActionCreator.onEditOK());
        }
      });
    }
  });
}

void selectAccount(Action action, Context<DealSellEditState> ctx) {
  //???????????????????????????
  if (ctx.state.playedGame != null && ctx.state.accounts.length >= 0) {
    //????????????
    showModalBottomSheet(
        context: ctx.context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return SelectAccountDialog(ctx.state.accounts, (account) {
            ctx.dispatch(
                DealSellEditActionCreator.updateSelectAccount(account));
            //??????????????????
            DealService.getDealAccountServer(account.mgMemId).then((data) {
              if (data.code == 200) {
                ctx.dispatch(
                    DealSellEditActionCreator.updateAccountServer(data.data));
              }
            });
          });
        });
  } else {
    showToast(getText(name: 'toastPleaseSelectGame'));
  }
}

void gotoSelectGame(Action action, Context<DealSellEditState> ctx) {
  AppUtil.gotoPageByName(ctx.context, DealBuyGameListPage.pageName)
      .then((playedGame) {
    if (playedGame != null) {
      ctx.dispatch(DealSellEditActionCreator.updateSelectGame(playedGame));
      //???????????????????????????
      DealService.getDealAccountsByGame((playedGame as PlayedGame).gameId)
          .then((data) {
        if (data.code == 200) {
          ctx.dispatch(
              DealSellEditActionCreator.updateAccounts(data.data.list));
        }
      });
    }
  });
}

void _showDialog(Action action, Context<DealSellEditState> ctx) {
  showDialog<Null>(
      context: ctx.context, //BuildContext??????
      barrierDismissible: false,
      builder: (BuildContext context) {
        return TipDialog(
          getText(name: 'textConfirmCancelAccountDeal'),
          hint: getText(name: 'textCancelAccountDeal'),
        );
      });

//  showDialog(
//      context: ctx.context,
//      builder: (context) => Dialog(
//        elevation: 0,
//        backgroundColor: Colors.transparent,
//        child: Center(
//          //????????????????????????
//          child: new Container(
//            width: 271.0,
//            height: 183,
//            padding: EdgeInsets.all(16),
//            decoration: ShapeDecoration(
//              color: Colors.white,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(
//                  Radius.circular(15.0),
//                ),
//              ),
//            ),
//            child: new Column(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                new Container(
//                  padding: const EdgeInsets.only(
//                    top: 20.0,
//                  ),
//                  child: new Text(
//                    "1111111111",
//                    style: new TextStyle(
//                        fontSize: 17,
//                        color: AppTheme.colors.textColor,
//                        fontWeight: FontWeight.bold),
//                  ),
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Container(
//                      child: MaterialButton(
//                        onPressed: () {
//                          Navigator.pop(context);
//                        },
//                        child: Text(
//                          "??????",
//                        ),
//                      ),
//                      decoration: BoxDecoration(
//                          border:
//                          Border.all(color: Color(0xFFD8D8D8), width: 1),
//                          borderRadius:
//                          BorderRadius.all(Radius.circular(21))),
//                      width: 111,
//                      height: 41,
//                    ),
//                    Container(
//                      child: MaterialButton(
//                        onPressed: () {},
//                        child: Text(
//                          "??????",
//                          style: TextStyle(color: Colors.white),
//                        ),
//                      ),
//                      width: 111,
//                      height: 41,
//                      decoration: BoxDecoration(
//                          color: AppTheme.colors.themeColor,
//                          borderRadius:
//                          BorderRadius.all(Radius.circular(21))),
//                    )
//                  ],
//                )
//              ],
//            ),
//          ),
//        ),
//      ));
}

void _selectPic(Action action, Context<DealSellEditState> ctx) {
  var image = ImagePicker.pickImage(source: ImageSource.gallery);
  image.then((file) {
    if (file != null) {
      // ???????????????????????????????????????????????????????????????
      compressImageFile(file).then((compressFile) {
        ctx.dispatch(DealSellEditActionCreator.addPic(compressFile));
      });
    }
  });
}
