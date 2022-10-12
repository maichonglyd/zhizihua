import 'package:flutter/material.dart';
import 'package:flutter_huoshu_app/common/util/app_util.dart';
import 'package:flutter_huoshu_app/common/util/date_format_base.dart';
import 'package:flutter_huoshu_app/common/util/nopop_info_util.dart';
import 'package:flutter_huoshu_app/generated/l10n.dart' as strings;
import 'package:flutter_huoshu_app/generated/locale_manager.dart';
import 'package:flutter_huoshu_app/generated/theme/app_theme.dart';
import 'package:flutter_huoshu_app/widget/huo_net_image.dart';

class HomePushDialog extends StatefulWidget {
  TextEditingController textEditingController = new TextEditingController();
  Function() ok;

  bool hasCancel = false;
  VoidCallback cancelCallback;
  VoidCallback confirmCallback;
  String image;
  HomePushDialog(
      {this.image, this.hasCancel, this.cancelCallback, this.confirmCallback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePushDialogState(
        image: image,
        hasCancel: hasCancel,
        cancelCallback: cancelCallback,
        confirmCallback: confirmCallback);
  }
}

class HomePushDialogState extends State<HomePushDialog> {
  String hint;
  bool hasCancel = false;
  VoidCallback cancelCallback;
  VoidCallback confirmCallback;
  String image;

  bool isNoPop = true;
  // TODO(johnsonmh): Update default dialog border radius to 4.0 to match material spec.
  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)));
  static const double _defaultElevation = 24.0;

  HomePushDialogState(
      {this.image, this.hasCancel, this.cancelCallback, this.confirmCallback});

  @override
  Widget build(BuildContext context) {
    if (this.cancelCallback == null) {
      this.cancelCallback = () {
        Navigator.pop(context);
      };
    }
    if (this.confirmCallback == null) {
      this.confirmCallback = () {
        Navigator.pop(context);
      };
    }

    final DialogTheme dialogTheme = DialogTheme.of(context);
    return Material(
      color: Colors.transparent,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            color: Colors.transparent,
            shape: _defaultDialogShape,
            type: MaterialType.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    confirmCallback();
                    saveInfo(isNoPop);
                  },
                  child: new Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                    ),
                    child: LimitedBox(
                      maxHeight: 410,
                      child: Image.network(image),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3, bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.white,
                        checkColor: AppTheme.colors.themeColor,
                        value: isNoPop,
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            isNoPop = !isNoPop;
                          });
                        },
                      ),
                      Text(
                        getText(name: 'textNotEjectToday'),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cancelCallback();
                    saveInfo(isNoPop);
                  },
                  child: Image.asset(
                    "images/icon_home_push_off.png",
                    width: 26,
                    height: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveInfo(bool isNoPop) {
    if (isNoPop) {
      String time = AppUtil.formatDate3();
      NoPopInfoUtil.saveData(time);
    }
  }
}
